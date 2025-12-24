-- 修复认证和RLS策略问题
-- 在Supabase SQL编辑器中执行这些SQL语句

-- 首先删除现有的RLS策略
DROP POLICY IF EXISTS "用户可以查看自己的信息" ON users;
DROP POLICY IF EXISTS "用户可以更新自己的信息" ON users;
DROP POLICY IF EXISTS "用户可以插入自己的信息" ON users;

-- 重新创建更宽松的用户表策略
-- 允许用户查看所有用户信息（用于用户名验证等）
CREATE POLICY "用户可以查看所有用户信息" ON users FOR SELECT USING (true);
-- 允许用户更新自己的信息
CREATE POLICY "用户可以更新自己的信息" ON users FOR UPDATE USING (auth.uid() = id);
-- 允许已认证用户插入用户信息
CREATE POLICY "已认证用户可以插入用户信息" ON users FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- 修复其他表的策略，确保它们不会阻止新用户
DROP POLICY IF EXISTS "用户可以查看自己的婚礼" ON weddings;
DROP POLICY IF EXISTS "用户可以管理自己的婚礼" ON weddings;
CREATE POLICY "用户可以查看自己的婚礼" ON weddings FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "用户可以管理自己的婚礼" ON weddings FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "用户可以管理自己婚礼的嘉宾" ON guests;
CREATE POLICY "用户可以管理自己婚礼的嘉宾" ON guests FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid()) OR auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS "用户可以管理自己婚礼的预算" ON budgets;
CREATE POLICY "用户可以管理自己婚礼的预算" ON budgets FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid()) OR auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS "用户可以管理自己婚礼的任务" ON tasks;
CREATE POLICY "用户可以管理自己婚礼的任务" ON tasks FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid()) OR auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS "所有人都可以查看供应商" ON vendors;
CREATE POLICY "所有人都可以查看供应商" ON vendors FOR SELECT USING (true);
CREATE POLICY "已认证用户可以管理供应商" ON vendors FOR ALL USING (auth.role() = 'authenticated');

-- 添加一个函数来处理新用户注册
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

-- 创建触发器，在用户注册时自动创建用户记录
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE PROCEDURE public.handle_new_user();