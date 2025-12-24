-- 场地数据导入脚本
-- 插入场地数据到 vendors 表
-- 所有场地数据 category 都设置为 'venue'

INSERT INTO vendors (
  id, 
  name, 
  category, 
  contact_person, 
  phone, 
  email, 
  website, 
  description, 
  price_range, 
  rating, 
  review_count, 
  avatar_url, 
  created_at, 
  updated_at
) VALUES 
  -- 湖畔度假酒店婚礼中心
  (
    gen_random_uuid(),
    '湖畔度假酒店婚礼中心',
    'venue',
    '张经理',
    '13800138000',
    'lake@hotel.com',
    'https://lake-hotel.com',
    '坐落在美丽的湖畔，拥有户外草坪和室内宴会厅，可容纳200-500人。提供一站式婚礼服务。',
    '10-20万',
    4.5,
    128,
    'https://example.com/lake-hotel.jpg',
    NOW(),
    NOW()
  ),
  -- 现代艺术展览馆
  (
    gen_random_uuid(),
    '现代艺术展览馆',
    'venue',
    '李小姐',
    '13900139000',
    'art@gallery.com',
    'https://art-gallery.com',
    '现代简约风格的艺术空间，适合追求个性的新人。配备先进的音响设备。',
    '5-10万',
    4.2,
    89,
    'https://example.com/art-gallery.jpg',
    NOW(),
    NOW()
  ),
  -- 古堡庄园婚礼会所
  (
    gen_random_uuid(),
    '古堡庄园婚礼会所',
    'venue',
    '王先生',
    '13700137000',
    'castle@manor.com',
    'https://castle-manor.com',
    '百年历史的欧式古堡，童话般的婚礼场地。提供专业的古堡婚礼策划。',
    '20-50万',
    4.8,
    156,
    'https://example.com/castle.jpg',
    NOW(),
    NOW()
  ),
  -- 森屿秘境草坪婚礼基地
  (
    gen_random_uuid(),
    '森屿秘境草坪婚礼基地',
    'venue',
    '刘主管',
    '13655889966',
    'senyu@wedding.com',
    'https://senyu-wedding.com',
    '隐匿于城市近郊的森林草坪，搭配森系花艺布景，可容纳150-300人，提供户外自助烧烤与露营体验。',
    '8-15万',
    4.6,
    205,
    'https://example.com/senyu-lawn.jpg',
    NOW(),
    NOW()
  ),
  -- 悦榕庄温泉度假酒店
  (
    gen_random_uuid(),
    '悦榕庄温泉度假酒店',
    'venue',
    '陈经理',
    '13522334455',
    'banyan@resort.com',
    'https://banyan-resort.com',
    '中式庭院风格婚礼场地，配套天然温泉汤屋，宴会厅融合古典与现代设计，可容纳200-400人，提供定制化婚宴菜单。',
    '15-25万',
    4.7,
    186,
    'https://example.com/banyan-resort.jpg',
    NOW(),
    NOW()
  ),
  -- 星空游轮婚礼会馆
  (
    gen_random_uuid(),
    '星空游轮婚礼会馆',
    'venue',
    '赵船长',
    '13488776699',
    'starcruise@wedding.com',
    'https://star-cruise.com',
    '沿江豪华游轮婚礼场地，可承载100-200人，夜幕降临后开启江景星空模式，搭配甲板仪式与烛光晚宴。',
    '12-22万',
    4.4,
    162,
    'https://example.com/star-cruise.jpg',
    NOW(),
    NOW()
  ),
  -- 国风庭院婚礼堂
  (
    gen_random_uuid(),
    '国风庭院婚礼堂',
    'venue',
    '马总监',
    '13399887766',
    'guofeng@courtyard.com',
    'https://guofeng-courtyard.com',
    '仿明清古建筑庭院，红墙黛瓦搭配江南园林布景，专业汉服婚礼仪式策划，可容纳180-350人。',
    '10-18万',
    4.9,
    230,
    'https://example.com/guofeng-courtyard.jpg',
    NOW(),
    NOW()
  ),
  -- 云端高空婚礼宴会厅
  (
    gen_random_uuid(),
    '云端高空婚礼宴会厅',
    'venue',
    '孙经理',
    '13266554433',
    'cloud@skyhall.com',
    'https://cloud-skyhall.com',
    '位于城市地标写字楼顶层，360°全景落地窗俯瞰全城，轻奢极简装修风格，可容纳80-150人小型精致婚礼。',
    '18-30万',
    4.3,
    98,
    'https://example.com/cloud-skyhall.jpg',
    NOW(),
    NOW()
  );

-- 数据导入完成提示
-- 验证导入结果：
-- SELECT COUNT(*) FROM vendors WHERE category = 'venue';
-- SELECT * FROM vendors WHERE category = 'venue' ORDER BY rating DESC;