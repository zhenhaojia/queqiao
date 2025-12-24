-- 为 weddings 表添加缺失字段（如果不存在）
-- 在 Supabase SQL Editor 中执行这些命令

-- 检查表结构并添加必要字段
-- 如果 venue_type 不存在，添加它
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM information_schema.columns 
        WHERE table_name='weddings' 
        AND column_name='venue_type'
        AND table_schema='public'
    ) THEN
        ALTER TABLE weddings ADD COLUMN venue_type TEXT;
    END IF;
END $$;

-- 如果 theme_color 不存在，添加它  
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM information_schema.columns 
        WHERE table_name='weddings' 
        AND column_name='theme_color'
        AND table_schema='public'
    ) THEN
        ALTER TABLE weddings ADD COLUMN theme_color TEXT;
    END IF;
END $$;

-- 如果 special_requirements 不存在，添加它
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM information_schema.columns 
        WHERE table_name='weddings' 
        AND column_name='special_requirements'
        AND table_schema='public'
    ) THEN
        ALTER TABLE weddings ADD COLUMN special_requirements TEXT;
    END IF;
END $$;

-- 将 venue 的值复制到 location（如果需要）
UPDATE weddings SET location = venue WHERE location IS NULL AND venue IS NOT NULL;

-- 确保所有字段都允许 NULL 值
ALTER TABLE weddings 
ALTER COLUMN venue_type DROP NOT NULL,
ALTER COLUMN theme_color DROP NOT NULL,  
ALTER COLUMN special_requirements DROP NOT NULL;