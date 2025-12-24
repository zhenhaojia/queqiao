-- 修复认证和RLS策略问题 v2
-- 在Supabase SQL编辑器中执行这些SQL语句

-- 检查并修复RLS状态
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE weddings ENABLE ROW LEVEL SECURITY;
ALTER TABLE guests ENABLE ROW LEVEL SECURITY;
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;

-- 删除可能存在的策略然后重新创建（使用IF EXISTS避免重复错误）
DROP POLICY IF EXISTS "用户可以查看所有用户信息" ON users;
DROP POLICY IF EXISTS "用户可以更新自己的信息" ON users;
DROP POLICY IF EXISTS "用户可以插入自己的信息" ON users;
DROP POLICY IF EXISTS "用户可以查看自己的信息" ON users;

DROP POLICY IF EXISTS "用户可以查看自己的婚礼" ON weddings;
DROP POLICY IF EXISTS "用户可以管理自己的婚礼" ON weddings;

DROP POLICY IF EXISTS "用户可以管理自己婚礼的嘉宾" ON guests;

DROP POLICY IF EXISTS "用户可以管理自己婚礼的预算" ON budgets;

DROP POLICY IF EXISTS "用户可以管理自己婚礼的任务" ON tasks;

DROP POLICY IF EXISTS "所有人都可以查看供应商" ON vendors;
DROP POLICY IF EXISTS "已认证用户可以管理供应商" ON vendors;

-- 重新创建优化的用户表策略
CREATE POLICY "允许查看用户信息" ON users FOR SELECT USING (true);
CREATE POLICY "允许更新自己的信息" ON users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "允许插入用户信息" ON users FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 婚礼表策略
CREATE POLICY "允许查看自己的婚礼" ON weddings FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "允许管理自己的婚礼" ON weddings FOR ALL USING (auth.uid() = user_id);

-- 嘉宾表策略
CREATE POLICY "允许管理婚礼嘉宾" ON guests FOR ALL USING (
  auth.uid() IS NOT NULL
);

-- 预算表策略
CREATE POLICY "允许管理婚礼预算" ON budgets FOR ALL USING (
  auth.uid() IS NOT NULL
);

-- 任务表策略
CREATE POLICY "允许管理婚礼任务" ON tasks FOR ALL USING (
  auth.uid() IS NOT NULL
);

-- 供应商表策略
CREATE POLICY "允许查看供应商" ON vendors FOR SELECT USING (true);
CREATE POLICY "允许管理供应商" ON vendors FOR ALL USING (auth.role() = 'authenticated');

-- 修复用户注册触发器（先删除后创建）
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'name', '新用户')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 删除并重新创建触发器
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE PROCEDURE public.handle_new_user();

-- 检查并创建必要的索引（如果不存在）
CREATE INDEX IF NOT EXISTS idx_users_id ON users(id);
CREATE INDEX IF NOT EXISTS idx_weddings_user_id ON weddings(user_id);
CREATE INDEX IF NOT EXISTS idx_guests_wedding_id ON guests(wedding_id);
CREATE INDEX IF NOT EXISTS idx_budgets_wedding_id ON budgets(wedding_id);
CREATE INDEX IF NOT EXISTS idx_tasks_wedding_id ON tasks(wedding_id);

-- 验证修复结果
SELECT 
  schemaname,
  tablename,
  rowsecurity as rls_enabled
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename IN ('users', 'weddings', 'guests', 'budgets', 'tasks', 'vendors')
ORDER BY tablename;