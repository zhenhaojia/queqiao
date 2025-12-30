-- 为vendors表添加address字段（如果不存在）
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='vendors' AND column_name='address'
    ) THEN
        ALTER TABLE vendors ADD COLUMN address TEXT;
    END IF;
END $$;

-- 插入摄影师数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('photographer_1', '梦幻摄影工作室', 'photography', '张摄影师', '13800138001', 'zhang@dreamphoto.com', 'https://dreamphoto.com', '专业婚礼摄影10年，擅长捕捉真实情感瞬间，用镜头记录爱情故事。提供婚纱照、婚礼跟拍、旅拍等服务。', '北京市朝阳区三里屯SOHO B座 1201室', '8000-15000', 4.8, 156, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('photographer_2', '光影记忆摄影', 'photography', '李摄影师', '13800138002', 'li@lightmemory.com', 'https://lightmemory.com', '新派婚礼摄影，自然纪实风格，让每一张照片都有故事。专业团队，设备精良，服务贴心。', '北京市海淀区中关村大街1号 805室', '6000-12000', 4.6, 89, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('photographer_3', '爱典婚纱摄影', 'photography', '王摄影师', '13800138003', 'wang@aidian.com', 'https://aidian.com', '高端定制婚纱摄影，提供旅拍服务，记录最美的爱情旅程。10年以上从业经验，作品获奖无数。', '北京市东城区王府井大街138号 502室', '12000-25000', 4.9, 203, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入化妆师数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('makeup_1', '美丽新娘化妆工作室', 'makeup', '刘化妆师', '13800138004', 'liu@beautybridal.com', 'https://beautybridal.com', '专业新娘化妆8年，擅长自然清新妆容，让新娘更加光彩照人。提供试妆服务，全程跟妆。', '北京市朝阳区国贸三期A座 2108室', '2000-5000', 4.7, 134, 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('makeup_2', '优雅造型工作室', 'makeup', '陈化妆师', '13800138005', 'chen@elegance.com', 'https://elegance.com', '韩式新娘化妆专家，提供试妆服务，打造完美新娘形象。使用国际一线品牌化妆品。', '北京市西城区金融街中心大厦 1503室', '3000-8000', 4.8, 167, 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('makeup_3', '花语新娘造型', 'makeup', '林化妆师', '13800138006', 'lin@flowerbride.com', 'https://flowerbride.com', '专业新娘化妆造型，擅长中式和西式妆容，提供新郎化妆服务。作品风格多样，经验丰富。', '北京市朝阳区望京SOHO T1 1205室', '2500-6000', 4.6, 98, 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入司仪数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('mc_1', '金牌婚礼司仪团队', 'music', '赵司仪', '13800138007', 'zhao@goldmc.com', 'https://goldmc.com', '资深婚礼司仪，声线浑厚有力，主持风格幽默温馨，掌控全场氛围。团队经验丰富，口碑极佳。', '北京市朝阳区CBD核心区 嘉里中心 1806室', '3000-6000', 4.9, 245, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('mc_2', '完美婚礼司仪', 'music', '孙司仪', '13800138008', 'sun@perfectmc.com', 'https://perfectmc.com', '年轻有活力的婚礼司仪，善于互动，让婚礼现场充满欢声笑语。风格时尚，语言生动。', '北京市海淀区五道口清华科技园 703室', '2500-5000', 4.6, 98, 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('mc_3', '浪漫之声主持工作室', 'music', '周司仪', '13800138009', 'zhou@romanticvoice.com', 'https://romanticvoice.com', '专业婚礼司仪，擅长浪漫温馨风格，能够完美诠释新人的爱情故事。普通话标准，声音甜美。', '北京市东城区东直门天恒大厦 1209室', '2800-5500', 4.7, 156, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入餐饮服务数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('catering_1', '盛宴餐饮服务', 'catering', '钱经理', '13800138010', 'qian@feast.com', 'https://feast.com', '高端婚宴餐饮服务，中西式餐点均可定制，食材新鲜，摆盘精美。拥有专业的厨师团队和服务团队。', '北京市顺义区天竺空港工业区 B区 8号', '800-2000/桌', 4.8, 189, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('catering_2', '美食汇婚宴', 'catering', '吴经理', '13800138011', 'wu@foodgathering.com', 'https://foodgathering.com', '专业婚宴餐饮20年，提供多种主题套餐，满足不同需求。菜品精致，服务周到。', '北京市昌平区回龙观东大街 118号', '600-1500/桌', 4.7, 156, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('catering_3', '品味轩婚宴', 'catering', '郑经理', '13800138012', 'zheng@tastepavilion.com', 'https://tastepavilion.com', '精品婚宴定制，融合川粤风味，可提供户外草坪婚礼餐饮服务。食材有机健康，制作工艺精湛。', '北京市海淀区西山国家森林公园北侧', '1000-2500/桌', 4.8, 201, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 插入婚礼策划数据
INSERT INTO vendors (id, name, category, contact_person, phone, email, website, description, address, price_range, rating, review_count, avatar_url, created_at, updated_at) VALUES
('planning_1', '完美婚礼策划', 'decoration', '冯策划', '13800138013', 'feng@perfectwedding.com', 'https://perfectwedding.com', '一站式婚礼策划服务，从创意设计到现场执行，打造完美婚礼。15年行业经验，服务过上千场婚礼。', '北京市朝阳区三里屯太古里南区 S2-1801室', '10000-50000', 4.9, 312, 'https://images.unsplash.com/photo-1519161393498-39d57d94b6a5?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('planning_2', '梦幻婚礼工作室', 'decoration', '沈策划', '13800138014', 'shen@dreamwedding.com', 'https://dreamwedding.com', '创意婚礼策划专家，擅长主题婚礼和 destination wedding。设计理念独特，执行能力强。', '北京市海淀区颐和园路 188号', '15000-80000', 4.8, 267, 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=200&h=200&fit=crop&auto=format', NOW(), NOW()),
('planning_3', '花缘婚礼策划', 'decoration', '韩策划', '13800138015', 'han@flowerfate.com', 'https://flowerfate.com', '专业婚礼策划，专注于打造浪漫唯美的婚礼现场。花艺设计突出，场景布置精美。', '北京市朝阳区建国门外大街 1号', '12000-60000', 4.7, 189, 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=200&h=200&fit=crop&auto=format', NOW(), NOW());

-- 更新现有场地数据，添加地址信息
UPDATE vendors SET 
  address = '北京市朝阳区建国路88号 SOHO现代城 A座 2801室',
  description = '现代风格婚礼场地，挑高6米，可容纳300人。配套设施齐全，包含音响、灯光、LED屏幕等。交通便利，地铁直达。',
  phone = '13800138016',
  email = 'beijing@grandhotel.com'
WHERE id = 'beijing-grand-hotel';

UPDATE vendors SET 
  address = '北京市海淀区中关村南大街5号 北京理工大学 学术交流中心',
  description = '欧式花园婚礼场地，户外草坪5000平米，室内宴会厅可容纳200人。环境优雅，绿树成荫，是举办户外婚礼的绝佳选择。',
  phone = '13800138017',
  email = 'garden@bitedu.edu.cn'
WHERE id = 'garden-hotel';

UPDATE vendors SET 
  address = '北京市朝阳区三里屯路11号 三里屯太古里北区 N4-502室',
  description = '时尚艺术婚礼场地，工业风格设计，挑高8米。配备专业舞台灯光系统，适合个性化主题婚礼。',
  phone = '13800138018',
  email = 'art@sanlitun.com'
WHERE id = 'art-gallery';

UPDATE vendors SET 
  address = '北京市顺义区天竺镇 杨林大道88号',
  description = '豪华度假村婚礼场地，拥有2个户外花园和1个水晶宴会厅。五星级服务，可提供住宿和餐饮一体服务。',
  phone = '13800138019',
  email = 'resort@grandhyatt.com'
WHERE id = 'hyatt-resort';

UPDATE vendors SET 
  address = '北京市东城区王府井大街138号 北京饭店 主楼8层',
  description = '百年历史酒店，经典中式婚礼场地。金碧辉煌的宴会厅，可容纳500人。拥有专业的婚庆服务团队。',
  phone = '13800138020',
  email = 'wedding@beijinghotel.com'
WHERE id = 'beijing-hotel';

UPDATE vendors SET 
  address = '北京市朝阳区建国门外大街1号 国贸三期 A座68层',
  description = '云端婚礼场地，城市天际线尽收眼底。360度全景视野，可同时容纳200人观礼。现代化设施，豪华配置。',
  phone = '13800138021',
  email = 'sky@cwbeijing.com'
WHERE id = 'sky-lounge';

UPDATE vendors SET 
  address = '北京市海淀区昆明湖路11号 颐和安缦酒店',
  description = '皇家园林婚礼场地，毗邻颐和园。古建筑风格，环境幽静。户外花园可举行仪式，室内餐厅举办宴席。',
  phone = '13800138022',
  email = 'garden@aman-summer-palace.com'
WHERE id = 'summer-palace';

UPDATE vendors SET 
  address = '北京市朝阳区东三环北路8号 亮马河大厦会议中心',
  description = '河畔婚礼场地，沿亮马河而建。户外草坪可举行仪式，室内宴会厅现代典雅。交通便利，环境优美。',
  phone = '13800138023',
  email = 'river@landmark.com'
WHERE id = 'river-view';