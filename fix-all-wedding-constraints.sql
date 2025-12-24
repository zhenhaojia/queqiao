-- 完整修复 weddings 表的所有 NOT NULL 约束问题
-- 在 Supabase SQL Editor 中执行这些命令

-- 1. 首先检查当前表结构
SELECT column_name, is_nullable, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'weddings' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 2. 修复所有可选字段的 NOT NULL 约束
-- 将应该允许 NULL 的字段改为允许 NULL
ALTER TABLE weddings 
ALTER COLUMN wedding_date DROP NOT NULL,
ALTER COLUMN budget DROP NOT NULL,
ALTER COLUMN guest_count DROP NOT NULL,
ALTER COLUMN venue DROP NOT NULL,
ALTER COLUMN style DROP NOT NULL;

-- 3. 如果上述命令中有任何失败，说明字段已经是正确的约束了
-- 4. 更新现有记录中的 NULL 值为合适的默认值
UPDATE weddings 
SET 
    wedding_date = COALESCE(wedding_date, CURRENT_DATE),
    budget = COALESCE(budget, 0),
    guest_count = COALESCE(guest_count, 0),
    venue = COALESCE(venue, ''),
    style = COALESCE(style, '')
WHERE 
    wedding_date IS NULL OR 
    budget IS NULL OR 
    guest_count IS NULL OR 
    venue IS NULL OR 
    style IS NULL;

-- 5. 再次检查表结构确认修改成功
SELECT column_name, is_nullable, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'weddings' AND table_schema = 'public'
ORDER BY ordinal_position;