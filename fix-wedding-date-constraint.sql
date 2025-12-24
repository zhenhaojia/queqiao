-- 修复 weddings 表的 wedding_date 字段 NOT NULL 约束问题
-- 在 Supabase SQL Editor 中执行这些命令

-- 方案1：将 wedding_date 的 NOT NULL 改为允许 NULL（推荐）
ALTER TABLE weddings 
ALTER COLUMN wedding_date DROP NOT NULL;

-- 如果上述命令不工作，尝试下面的方案：
-- 方案2：检查当前表结构
SELECT column_name, is_nullable, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'weddings' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 方案3：如果必须保持 NOT NULL，则设置默认值为当前日期
-- ALTER TABLE weddings 
-- ALTER COLUMN wedding_date SET DEFAULT CURRENT_DATE;

-- 方案4：更新现有 NULL 记录为默认值（如果需要保持 NOT NULL）
-- UPDATE weddings 
-- SET wedding_date = COALESCE(wedding_date, CURRENT_DATE)
-- WHERE wedding_date IS NULL;