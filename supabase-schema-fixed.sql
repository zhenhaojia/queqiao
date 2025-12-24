-- 鹊桥AI婚礼帮手数据库表结构
-- 在Supabase SQL编辑器中执行这些SQL语句

-- 注意：不在数据库级别设置RLS，而是在每个表上单独启用

-- 用户表
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 婚礼表
CREATE TABLE IF NOT EXISTS weddings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  bride_name VARCHAR(100) NOT NULL,
  groom_name VARCHAR(100) NOT NULL,
  wedding_date DATE NOT NULL,
  budget DECIMAL(12, 2) NOT NULL,
  guest_count INTEGER NOT NULL,
  venue TEXT,
  style VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'planning' CHECK (status IN ('planning', 'confirmed', 'completed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 嘉宾表
CREATE TABLE IF NOT EXISTS guests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  wedding_id UUID REFERENCES weddings(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(20),
  address TEXT,
  rsvp_status VARCHAR(20) DEFAULT 'pending' CHECK (rsvp_status IN ('pending', 'confirmed', 'declined')),
  plus_ones INTEGER DEFAULT 0,
  dietary_restrictions TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 供应商表
CREATE TABLE IF NOT EXISTS vendors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL CHECK (category IN ('photography', 'videography', 'music', 'catering', 'decoration', 'makeup', 'venue')),
  contact_person VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  website TEXT,
  description TEXT NOT NULL,
  price_range VARCHAR(50) NOT NULL,
  rating DECIMAL(3, 2) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
  review_count INTEGER DEFAULT 0,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 预算表
CREATE TABLE IF NOT EXISTS budgets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  wedding_id UUID REFERENCES weddings(id) ON DELETE CASCADE,
  category VARCHAR(100) NOT NULL,
  allocated_amount DECIMAL(12, 2) NOT NULL,
  spent_amount DECIMAL(12, 2) DEFAULT 0,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 任务表
CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  wedding_id UUID REFERENCES weddings(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  due_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'todo' CHECK (status IN ('todo', 'in_progress', 'completed')),
  priority VARCHAR(10) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high')),
  assigned_to VARCHAR(100),
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_weddings_user_id ON weddings(user_id);
CREATE INDEX IF NOT EXISTS idx_guests_wedding_id ON guests(wedding_id);
CREATE INDEX IF NOT EXISTS idx_vendors_category ON vendors(category);
CREATE INDEX IF NOT EXISTS idx_budgets_wedding_id ON budgets(wedding_id);
CREATE INDEX IF NOT EXISTS idx_tasks_wedding_id ON tasks(wedding_id);

-- 创建更新时间触发器
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_weddings_updated_at BEFORE UPDATE ON weddings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_guests_updated_at BEFORE UPDATE ON guests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_vendors_updated_at BEFORE UPDATE ON vendors FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_budgets_updated_at BEFORE UPDATE ON budgets FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 行级安全策略
-- 用户表策略
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY "用户可以查看自己的信息" ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "用户可以更新自己的信息" ON users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "用户可以插入自己的信息" ON users FOR INSERT WITH CHECK (auth.uid() = id);

-- 婚礼表策略
ALTER TABLE weddings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "用户可以查看自己的婚礼" ON weddings FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "用户可以管理自己的婚礼" ON weddings FOR ALL USING (auth.uid() = user_id);

-- 嘉宾表策略
ALTER TABLE guests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "用户可以管理自己婚礼的嘉宾" ON guests FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid())
);

-- 预算表策略
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "用户可以管理自己婚礼的预算" ON budgets FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid())
);

-- 任务表策略
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "用户可以管理自己婚礼的任务" ON tasks FOR ALL USING (
  wedding_id IN (SELECT id FROM weddings WHERE user_id = auth.uid())
);

-- 供应商表策略（公开只读，管理员可写）
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
CREATE POLICY "所有人都可以查看供应商" ON vendors FOR SELECT USING (true);

-- 插入一些示例供应商数据
INSERT INTO vendors (name, category, contact_person, phone, email, website, description, price_range, rating, review_count) VALUES
('浪漫时光摄影', 'photography', '张摄影师', '13800138001', 'zhang@photography.com', 'https://romance-photo.com', '专业婚礼摄影，记录您的美好瞬间', '8000-20000', 4.8, 156),
('梦幻婚礼策划', 'decoration', '李策划师', '13800138002', 'li@wedding.com', 'https://dream-wedding.com', '一站式婚礼策划服务', '30000-100000', 4.9, 89),
('优雅新娘造型', 'makeup', '王化妆师', '13800138003', 'wang@makeup.com', 'https://elegant-makeup.com', '专业新娘化妆造型', '2000-8000', 4.7, 234),
('天籁之音婚礼司仪', 'music', '赵司仪', '13800138004', 'zhao@music.com', 'https://heaven-music.com', '专业婚礼主持服务', '3000-10000', 4.6, 78),
('美味佳肴餐饮', 'catering', '陈厨师', '13800138005', 'chen@catering.com', 'https://delicious-food.com', '高端婚礼餐饮服务', '500-2000/桌', 4.5, 92);