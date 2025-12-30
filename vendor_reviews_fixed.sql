-- 创建供应商评价表
CREATE TABLE IF NOT EXISTS vendor_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  wedding_id UUID REFERENCES weddings(id) ON DELETE SET NULL,
  rating DECIMAL(2, 1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  service_date DATE,
  pros TEXT[],  -- 优点列表
  cons TEXT[],  -- 缺点列表
  would_recommend BOOLEAN DEFAULT true,
  images TEXT[], -- 评价图片
  is_anonymous BOOLEAN DEFAULT false,
  is_verified BOOLEAN DEFAULT false, -- 是否为验证过的真实评价
  helpful_count INTEGER DEFAULT 0, -- 有多少人觉得有用
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(vendor_id, user_id) -- 每个用户对每个供应商只能评价一次
);

-- 创建供应商收藏表
CREATE TABLE IF NOT EXISTS vendor_favorites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  vendor_id UUID REFERENCES vendors(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, vendor_id)
);

-- 创建供应商咨询表
CREATE TABLE IF NOT EXISTS vendor_inquiries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  wedding_id UUID REFERENCES weddings(id) ON DELETE SET NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  preferred_contact VARCHAR(20) DEFAULT 'phone', -- phone, email, wechat
  inquiry_status VARCHAR(20) DEFAULT 'pending', -- pending, responded, resolved, closed
  vendor_response TEXT,
  vendor_response_time TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建供应商预约表（更通用的预约系统）
CREATE TABLE IF NOT EXISTS vendor_bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  wedding_id UUID REFERENCES weddings(id) ON DELETE SET NULL,
  contact_person VARCHAR(100) NOT NULL,
  contact_phone VARCHAR(20) NOT NULL,
  contact_email VARCHAR(100) NOT NULL,
  booking_date DATE NOT NULL,
  preferred_time TIME NOT NULL,
  duration_hours INTEGER DEFAULT 2, -- 预约时长（小时）
  guest_count INTEGER,
  package_type VARCHAR(50) DEFAULT 'standard', -- basic, standard, premium, custom
  special_requirements TEXT,
  budget_range VARCHAR(50),
  booking_status VARCHAR(20) DEFAULT 'pending', -- pending, confirmed, cancelled, completed, no_show
  vendor_notes TEXT,
  vendor_response_time TIMESTAMP WITH TIME ZONE,
  reminder_sent BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建供应商服务项目表
CREATE TABLE IF NOT EXISTS vendor_services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  service_name VARCHAR(100) NOT NULL,
  service_description TEXT,
  base_price DECIMAL(10, 2),
  price_unit VARCHAR(20) DEFAULT 'per_event', -- per_event, per_hour, per_day, per_person
  duration_hours INTEGER,
  included_items TEXT[],
  additional_costs JSONB, -- 额外费用的详细说明
  is_popular BOOLEAN DEFAULT false,
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 添加索引
CREATE INDEX IF NOT EXISTS idx_vendor_reviews_vendor_id ON vendor_reviews(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_reviews_user_id ON vendor_reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_vendor_reviews_rating ON vendor_reviews(rating);
CREATE INDEX IF NOT EXISTS idx_vendor_reviews_created_at ON vendor_reviews(created_at);

CREATE INDEX IF NOT EXISTS idx_vendor_favorites_user_id ON vendor_favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_vendor_favorites_vendor_id ON vendor_favorites(vendor_id);

CREATE INDEX IF NOT EXISTS idx_vendor_inquiries_vendor_id ON vendor_inquiries(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_inquiries_user_id ON vendor_inquiries(user_id);
CREATE INDEX IF NOT EXISTS idx_vendor_inquiries_status ON vendor_inquiries(inquiry_status);

CREATE INDEX IF NOT EXISTS idx_vendor_bookings_vendor_id ON vendor_bookings(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_bookings_user_id ON vendor_bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_vendor_bookings_status ON vendor_bookings(booking_status);
CREATE INDEX IF NOT EXISTS idx_vendor_bookings_date ON vendor_bookings(booking_date);

CREATE INDEX IF NOT EXISTS idx_vendor_services_vendor_id ON vendor_services(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_services_active ON vendor_services(is_active);

-- 创建更新时间戳的触发器函数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 为所有相关表添加更新时间戳触发器
CREATE TRIGGER update_vendor_reviews_updated_at BEFORE UPDATE ON vendor_reviews
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_vendor_inquiries_updated_at BEFORE UPDATE ON vendor_inquiries
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_vendor_bookings_updated_at BEFORE UPDATE ON vendor_bookings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_vendor_services_updated_at BEFORE UPDATE ON vendor_services
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 启用RLS
ALTER TABLE vendor_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_services ENABLE ROW LEVEL SECURITY;

-- 供应商评价的RLS策略
CREATE POLICY "Users can view all reviews" ON vendor_reviews
    FOR SELECT USING (true);

CREATE POLICY "Users can insert their own reviews" ON vendor_reviews
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own reviews" ON vendor_reviews
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own reviews" ON vendor_reviews
    FOR DELETE USING (auth.uid() = user_id);

-- 供应商收藏的RLS策略
CREATE POLICY "Users can manage their own favorites" ON vendor_favorites
    FOR ALL USING (auth.uid() = user_id);

-- 供应商咨询的RLS策略
CREATE POLICY "Users can view their own inquiries" ON vendor_inquiries
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert inquiries" ON vendor_inquiries
    FOR INSERT WITH CHECK (auth.uid() = user_id OR auth.uid() IS NULL);

CREATE POLICY "Users can update their own inquiries" ON vendor_inquiries
    FOR UPDATE USING (auth.uid() = user_id);

-- 供应商预约的RLS策略
CREATE POLICY "Users can view their own bookings" ON vendor_bookings
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert bookings" ON vendor_bookings
    FOR INSERT WITH CHECK (auth.uid() = user_id OR auth.uid() IS NULL);

CREATE POLICY "Users can update their own bookings" ON vendor_bookings
    FOR UPDATE USING (auth.uid() = user_id);

-- 供应商服务的RLS策略
CREATE POLICY "Everyone can view active services" ON vendor_services
    FOR SELECT USING (is_active = true);

-- 创建更新供应商评分的函数
CREATE OR REPLACE FUNCTION update_vendor_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE vendors 
    SET 
        rating = (
            SELECT COALESCE(AVG(rating), 0) 
            FROM vendor_reviews 
            WHERE vendor_id = NEW.vendor_id
        ),
        review_count = (
            SELECT COUNT(*) 
            FROM vendor_reviews 
            WHERE vendor_id = NEW.vendor_id
        )
    WHERE id = NEW.vendor_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 为评价表创建触发器
CREATE TRIGGER update_vendor_rating_trigger
    AFTER INSERT OR UPDATE OR DELETE ON vendor_reviews
    FOR EACH ROW EXECUTE FUNCTION update_vendor_rating();

-- 创建一个有用投票函数
CREATE OR REPLACE FUNCTION increment_helpful_count(review_id UUID)
RETURNS INTEGER AS $$
BEGIN
    UPDATE vendor_reviews 
    SET helpful_count = helpful_count + 1
    WHERE id = review_id;
    
    RETURN (SELECT helpful_count FROM vendor_reviews WHERE id = review_id);
END;
$$ LANGUAGE plpgsql;