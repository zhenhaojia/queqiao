-- 更新供应商头像为精美的高质量图片
-- 为每个类别分配专业且美观的头像

-- 更新摄影摄像供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'photography' AND avatar_url IS NULL;

-- 更新婚礼场地供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1519227425843-025b19774716?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'venue' AND avatar_url IS NULL;

-- 更新餐饮服务供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1556659797-2b78154f6d91?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'catering' AND avatar_url IS NULL;

-- 更新婚礼司仪供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'music' AND avatar_url IS NULL;

-- 更新婚礼策划供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'decoration' AND avatar_url IS NULL;

-- 更新化妆造型供应商头像
UPDATE vendors 
SET avatar_url = 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
WHERE category = 'makeup' AND avatar_url IS NULL;

-- 为已有记录添加高质量头像（如果头像质量不高）
UPDATE vendors 
SET avatar_url = 
  CASE category
    WHEN 'photography' THEN 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    WHEN 'venue' THEN 'https://images.unsplash.com/photo-1519227425843-025b19774716?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    WHEN 'catering' THEN 'https://images.unsplash.com/photo-1556659797-2b78154f6d91?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    WHEN 'music' THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    WHEN 'decoration' THEN 'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    WHEN 'makeup' THEN 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
    ELSE 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=128&h=128&fit=crop&auto=format&face=center&q=85&cs=tinysrgb'
  END
WHERE avatar_url LIKE '%picsum%' OR avatar_url LIKE '%placeholder%' OR avatar_url IS NULL OR avatar_url = '';

-- 显示更新后的记录数量
SELECT 
  category,
  COUNT(*) as vendor_count,
  COUNT(CASE WHEN avatar_url IS NOT NULL AND avatar_url != '' THEN 1 END) as vendors_with_avatars
FROM vendors 
GROUP BY category;