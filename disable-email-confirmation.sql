-- 禁用邮箱确认功能
-- 在 Supabase Dashboard -> Authentication -> Settings 中进行以下配置：

-- 1. 找到 "Enable email confirmations" 选项
-- 2. 取消勾选此选项（设置为 false）

-- 或者通过 SQL 执行（需要管理员权限）：

-- 更新认证设置以禁用邮箱确认
-- UPDATE auth.settings 
-- SET enable_signup = true,
--     enable_email_confirmations = false
-- WHERE id = (SELECT id FROM auth.settings LIMIT 1);

-- 注意：禁用邮箱确认后，用户注册后可以直接登录，无需邮件验证