-- 插入摄影师数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('photographer_1', '梦幻摄影工作室', 'photography', '张摄影师', '13800138001', 'zhang@dreamphoto.com', 'https://dreamphoto.com', '专业婚礼摄影10年，擅长捕捉真实情感瞬间，用镜头记录爱情故事', '北京市朝阳区三里屯SOHO', '8000-15000', 4.8, 156, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('photographer_2', '光影记忆摄影', 'photography', '李摄影师', '13800138002', 'li@lightmemory.com', 'https://lightmemory.com', '新派婚礼摄影，自然纪实风格，让每一张照片都有故事', '北京市海淀区中关村', '6000-12000', 4.6, 89, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('photographer_3', '爱典婚纱摄影', 'photography', '王摄影师', '13800138003', 'wang@aidian.com', 'https://aidian.com', '高端定制婚纱摄影，提供旅拍服务，记录最美的爱情旅程', '北京市东城区王府井', '12000-25000', 4.9, 203, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入化妆师数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('makeup_1', '美丽新娘化妆工作室', 'makeup', '刘化妆师', '13800138004', 'liu@beautybridal.com', 'https://beautybridal.com', '专业新娘化妆8年，擅长自然清新妆容，让新娘更加光彩照人', '北京市朝阳区国贸', '2000-5000', 4.7, 134, 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('makeup_2', '优雅造型工作室', 'makeup', '陈化妆师', '13800138005', 'chen@elegance.com', 'https://elegance.com', '韩式新娘化妆专家，提供试妆服务，打造完美新娘形象', '北京市西城区金融街', '3000-8000', 4.8, 167, 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入司仪数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('mc_1', '金牌婚礼司仪团队', 'music', '赵司仪', '13800138006', 'zhao@goldmc.com', 'https://goldmc.com', '资深婚礼司仪，声线浑厚有力，主持风格幽默温馨，掌控全场氛围', '北京市朝阳区CBD', '3000-6000', 4.9, 245, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('mc_2', '完美婚礼司仪', 'music', '孙司仪', '13800138007', 'sun@perfectmc.com', 'https://perfectmc.com', '年轻有活力的婚礼司仪，善于互动，让婚礼现场充满欢声笑语', '北京市海淀区五道口', '2500-5000', 4.6, 98, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入餐饮服务数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('catering_1', '盛宴餐饮服务', 'catering', '周经理', '13800138008', 'zhou@feast.com', 'https://feast.com', '高端婚宴餐饮服务，中西式餐点均可定制，食材新鲜，摆盘精美', '北京市顺义区天竺', '800-2000/桌', 4.8, 189, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('catering_2', '美食汇婚宴', 'catering', '吴经理', '13800138009', 'wu@foodgathering.com', 'https://foodgathering.com', '专业婚宴餐饮20年，提供多种主题套餐，满足不同需求', '北京市昌平区回龙观', '600-1500/桌', 4.7, 156, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入婚礼策划数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('planning_1', '完美婚礼策划', 'decoration', '郑策划', '13800138010', 'zheng@perfectwedding.com', 'https://perfectwedding.com', '一站式婚礼策划服务，从创意设计到现场执行，打造完美婚礼', '北京市朝阳区三里屯', '10000-50000', 4.9, 312, 'https://images.unsplash.com/photo-1519161393498-39d57d94b6a5?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('planning_2', '梦幻婚礼工作室', 'decoration', '冯策划', '13800138011', 'feng@dreamwedding.com', 'https://dreamwedding.com', '创意婚礼策划专家，擅长主题婚礼和 destination wedding', '北京市海淀区颐和园', '15000-80000', 4.8, 267, 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入更多场地数据（补充）
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('venue_9', '阳光花园酒店', 'venue', '钱经理', '13800138012', 'qian@sunnygarden.com', 'https://sunnygarden.com', '户外花园婚礼场地，阳光充足，绿植环绕，打造浪漫自然婚礼', '北京市通州区运河', '5000-15000', 4.7, 145, 'https://images.unsplash.com/photo-1469371670407-c084654f8696?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('venue_10', '星空酒店', 'venue', '沈经理', '13800138013', 'shen@starhotel.com', 'https://starhotel.com', '现代豪华酒店，拥有空中花园和城市天际线景观', '北京市朝阳区望京', '8000-20000', 4.8, 178, 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=200&h=200&fit=crop&auto=format', NOW(), NOW());