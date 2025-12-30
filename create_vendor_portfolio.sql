-- 创建供应商作品集表
CREATE TABLE IF NOT EXISTS vendor_portfolio (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  title VARCHAR(255),  -- 作品标题
  description TEXT,     -- 作品描述
  image_url TEXT NOT NULL,  -- 图片URL
  thumbnail_url TEXT,   -- 缩略图URL
  sort_order INTEGER DEFAULT 0,  -- 排序顺序
  is_featured BOOLEAN DEFAULT FALSE,  -- 是否为精选作品
  tags TEXT[],  -- 标签数组
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_vendor_portfolio_vendor_id ON vendor_portfolio(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_portfolio_sort_order ON vendor_portfolio(sort_order);
CREATE INDEX IF NOT EXISTS idx_vendor_portfolio_featured ON vendor_portfolio(is_featured);

-- 创建更新时间触发器
CREATE OR REPLACE FUNCTION update_vendor_portfolio_updated_at()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER vendor_portfolio_updated_at
    BEFORE UPDATE ON vendor_portfolio
    FOR EACH ROW
    EXECUTE FUNCTION update_vendor_portfolio_updated_at();

-- 为示例供应商添加精美作品集数据
-- 使用WITH子句先获取供应商ID，然后插入数据

-- 摄影摄像作品集
WITH photo_vendor AS (
  SELECT id FROM vendors WHERE category = 'photography' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['浪漫婚礼瞬间', '教堂婚礼仪式', '海滩婚礼日落', '新人特写', '婚礼派对', '新郎风采']),
  unnest(ARRAY['新人在花园中的浪漫亲吻瞬间', '神圣的教堂婚礼仪式现场', '夕阳西下的海滩婚礼场景', '新娘和新郎的幸福特写', '欢乐的婚礼派对场景', '英俊的新郎风采展示']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1519741497674-611481863552?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1519227425843-025b19774716?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1469374945827-ffb598432e53?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1523437113738-bd3cc5fcf482?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['婚礼', '浪漫', '户外'], 
    ARRAY['教堂', '仪式', '传统'], 
    ARRAY['海滩', '日落', '户外'], 
    ARRAY['特写', '幸福', '人像'], 
    ARRAY['派对', '欢乐', '庆祝'], 
    ARRAY['新郎', '人像', '风采']
  ]::text[][]
FROM photo_vendor;

-- 婚礼场地作品集
WITH venue_vendor AS (
  SELECT id FROM vendors WHERE category = 'venue' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['豪华宴会厅', '户外花园', '浪漫沙滩', '森林秘境', '山景视野', '古典城堡']),
  unnest(ARRAY['宽敞明亮的豪华宴会厅', '美丽的户外婚礼花园', '夕阳下的浪漫沙滩场地', '神秘的森林婚礼场地', '壮丽山景的婚礼场地', '古典优雅的城堡婚礼']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1469374945827-ffb598432e53?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1519167708426-a9bcd4aa3103?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1515705576963-95cad62945b6?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1519227425843-025b19774716?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['宴会厅', '豪华', '室内'], 
    ARRAY['花园', '户外', '自然'], 
    ARRAY['沙滩', '海边', '浪漫'], 
    ARRAY['森林', '自然', '神秘'], 
    ARRAY['山景', '视野', '壮观'], 
    ARRAY['城堡', '古典', '优雅']
  ]::text[][]
FROM venue_vendor;

-- 餐饮服务作品集
WITH catering_vendor AS (
  SELECT id FROM vendors WHERE category = 'catering' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['精致主菜', '甜点桌', '鸡尾酒会', '自助餐', '婚礼蛋糕', '海鲜盛宴']),
  unnest(ARRAY['精心制作的婚礼主菜', '精美的婚礼甜点桌', '优雅的鸡尾酒会场景', '丰盛的自助餐摆台', '精美的多层婚礼蛋糕', '新鲜的海鲜料理']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1556659797-2b78154f6d91?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['主菜', '精致', '美食'], 
    ARRAY['甜点', '甜品桌', '精美'], 
    ARRAY['鸡尾酒', '酒会', '优雅'], 
    ARRAY['自助餐', '丰盛', '多样'], 
    ARRAY['蛋糕', '婚礼', '多层'], 
    ARRAY['海鲜', '新鲜', '盛宴']
  ]::text[][]
FROM catering_vendor;

-- 婚礼司仪作品集
WITH music_vendor AS (
  SELECT id FROM vendors WHERE category = 'music' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['仪式主持', '音乐表演', '灯光秀', 'DJ演出', '乐队演奏', '音响设备']),
  unnest(ARRAY['专业的婚礼仪式主持', '现场音乐表演团队', '绚丽的灯光秀表演', '时尚的DJ现场演出', '现场乐队演奏表演', '专业音响设备展示']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1598857734556-1e32b5e54b91?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1580089849233-38a30cba8083?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['主持', '仪式', '专业'], 
    ARRAY['音乐', '表演', '现场'], 
    ARRAY['灯光', '表演', '绚烂'], 
    ARRAY['DJ', '音乐', '时尚'], 
    ARRAY['乐队', '演奏', '现场'], 
    ARRAY['音响', '设备', '专业']
  ]::text[][]
FROM music_vendor;

-- 婚礼策划作品集
WITH decoration_vendor AS (
  SELECT id FROM vendors WHERE category = 'decoration' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['花艺布置', '舞台设计', '主题装饰', '灯光氛围', '桌面布置', '迎宾区']),
  unnest(ARRAY['精美的婚礼花艺布置', '创意的婚礼舞台设计', '独特的主题婚礼装饰', '浪漫的灯光氛围营造', '精致的婚礼桌面布置', '温馨的迎宾区设计']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1519227425843-025b19774716?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1469374945827-ffb598432e53?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1512496010403-a0da51cc11a0?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1519741497674-611481863552?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['花艺', '布置', '精美'], 
    ARRAY['舞台', '设计', '创意'], 
    ARRAY['主题', '装饰', '独特'], 
    ARRAY['灯光', '氛围', '浪漫'], 
    ARRAY['桌面', '布置', '精致'], 
    ARRAY['迎宾', '设计', '温馨']
  ]::text[][]
FROM decoration_vendor;

-- 化妆造型作品集
WITH makeup_vendor AS (
  SELECT id FROM vendors WHERE category = 'makeup' LIMIT 1
)
INSERT INTO vendor_portfolio (vendor_id, title, description, image_url, sort_order, is_featured, tags)
SELECT 
  id,
  unnest(ARRAY['新娘妆', '发型设计', '妆容试妆', '整体造型', '伴娘妆', '妆后效果']),
  unnest(ARRAY['精致的新娘化妆造型', '优雅的新娘发型设计', '专业的妆容试妆服务', '完美的整体新娘造型', '优雅的伴娘化妆造型', '惊艳的妆后效果展示']),
  unnest(ARRAY[
    'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1494548162494-384bba4ab999?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb',
    'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=1200&h=800&fit=crop&auto=format&q=85&cs=tinysrgb'
  ]),
  unnest(ARRAY[1, 2, 3, 4, 5, 6]),
  unnest(ARRAY[true, true, false, false, false, false]),
  ARRAY[
    ARRAY['新娘妆', '化妆', '精致'], 
    ARRAY['发型', '设计', '优雅'], 
    ARRAY['试妆', '专业', '服务'], 
    ARRAY['整体造型', '完美', '新娘'], 
    ARRAY['伴娘', '化妆', '优雅'], 
    ARRAY['妆后', '效果', '惊艳']
  ]::text[][]
FROM makeup_vendor;

-- 显示插入的作品集数据
SELECT 
  v.name,
  v.category,
  COUNT(vp.id) as portfolio_count,
  COUNT(CASE WHEN vp.is_featured THEN 1 END) as featured_count
FROM vendors v
LEFT JOIN vendor_portfolio vp ON v.id = vp.vendor_id
GROUP BY v.id, v.name, v.category
ORDER BY v.category, v.name;