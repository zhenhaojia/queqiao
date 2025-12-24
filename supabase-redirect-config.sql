-- 更新 Supabase 认证配置
-- 注意：这些设置需要在 Supabase 控制台中进行配置

-- 1. 在 Supabase Dashboard -> Authentication -> Settings 中设置：
-- Site URL: http://localhost:3000
-- Redirect URLs: http://localhost:3000/auth/callback

-- 2. 或者在 SQL Editor 中运行以下更新（如果有权限）：

-- 更新 auth.settings 表中的重定向 URL
-- UPDATE auth.settings 
-- SET site_url = 'http://localhost:3000',
--     redirect_urls = '["http://localhost:3000/auth/callback", "http://localhost:3000"]'
-- WHERE id = (SELECT id FROM auth.settings LIMIT 1);

-- 对于生产环境，需要添加生产环境的 URL
-- 示例：https://yourdomain.com/auth/callback