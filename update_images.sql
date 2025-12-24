-- 更新场地图片URL为真实的婚礼场地图片
-- 使用了免费的高质量图片资源

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1469371670407-c084654f8696?w=800&h=600&fit=crop&auto=format' 
WHERE name = '湖畔度假酒店婚礼中心';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800&h=600&fit=crop&auto=format' 
WHERE name = '现代艺术展览馆';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1519161393498-39d57d94b6a5?w=800&h=600&fit=crop&auto=format' 
WHERE name = '古堡庄园婚礼会所';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=600&fit=crop&auto=format' 
WHERE name = '森屿秘境草坪婚礼基地';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&h=600&fit=crop&auto=format' 
WHERE name = '悦榕庄温泉度假酒店';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&h=600&fit=crop&auto=format' 
WHERE name = '星空游轮婚礼会馆';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1578683010236-d716f98a3703?w=800&h=600&fit=crop&auto=format' 
WHERE name = '国风庭院婚礼堂';

UPDATE vendors SET avatar_url = 'https://images.unsplash.com/photo-1542361347-68e277434be6?w=800&h=600&fit=crop&auto=format' 
WHERE name = '云端高空婚礼宴会厅';

-- 验证更新结果
SELECT name, avatar_url FROM vendors WHERE category = 'venue' ORDER BY rating DESC;