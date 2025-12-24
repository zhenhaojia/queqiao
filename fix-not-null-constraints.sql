-- 修复 weddings 表的 NOT NULL 约束问题
-- 在 Supabase SQL Editor 中执行这些命令

-- 方案1：将 NOT NULL 改为允许 NULL（推荐）
ALTER TABLE weddings 
ALTER COLUMN bride_name DROP NOT NULL,
ALTER COLUMN groom_name DROP NOT NULL,
ALTER COLUMN venue DROP NOT NULL,
ALTER COLUMN style DROP NOT NULL;

-- 方案2：如果必须保持 NOT NULL，则设置默认值
-- ALTER TABLE weddings 
-- ALTER COLUMN bride_name SET DEFAULT '',
-- ALTER COLUMN groom_name SET DEFAULT '',
-- ALTER COLUMN venue SET DEFAULT '',
-- ALTER COLUMN style SET DEFAULT '';

-- 更新现有 NULL 记录为空字符串
-- UPDATE weddings 
-- SET 
--     bride_name = COALESCE(bride_name, ''),
--     groom_name = COALESCE(groom_name, ''),
--     venue = COALESCE(venue, ''),
--     style = COALESCE(style, '')
-- WHERE 
--     bride_name IS NULL OR 
--     groom_name IS NULL OR 
--     venue IS NULL OR 
--     style IS NULL;

-- 检查表结构
-- SELECT column_name, is_nullable, data_type, column_default 
-- FROM information_schema.columns 
-- WHERE table_name = 'weddings' AND table_schema = 'public'
-- ORDER BY ordinal_position;