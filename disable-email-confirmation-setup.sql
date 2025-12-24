-- 禁用邮箱确认设置
-- 在 Supabase Dashboard 的 Authentication -> Settings 中执行以下操作

-- 方式1: 通过 SQL 执行（需要管理员权限）
UPDATE auth.settings 
SET enable_email_confirmations = false,
    disable_signup = false
WHERE id = (SELECT id FROM auth.settings LIMIT 1);

-- 方式2: 直接更新特定设置
-- 只禁用邮箱确认，但保持注册开启
UPDATE auth.settings 
SET enable_email_confirmations = false
WHERE id = (SELECT id FROM auth.settings LIMIT 1);

-- 验证设置是否生效
SELECT enable_email_confirmations, disable_signup 
FROM auth.settings 
LIMIT 1;

-- 注意事项：
-- 1. 禁用邮箱确认后，用户注册后可以直接登录
-- 2. 用户仍然会收到欢迎邮件，但不需要点击确认链接
-- 3. 这个设置会立即生效，新注册的用户可以直接登录
-- 4. 已有的未确认用户仍然需要确认邮箱

-- 如果遇到权限问题，请在 Supabase Dashboard 中手动设置：
-- Dashboard -> Authentication -> Settings -> "Enable email confirmations" -> 取消勾选