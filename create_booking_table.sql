-- 创建场地预约表
CREATE TABLE venue_bookings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  venue_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  wedding_id UUID REFERENCES weddings(id) ON DELETE CASCADE,
  contact_person VARCHAR(100) NOT NULL,
  contact_phone VARCHAR(20) NOT NULL,
  contact_email VARCHAR(100) NOT NULL,
  booking_date DATE NOT NULL,
  preferred_time TIME NOT NULL,
  guest_count INTEGER NOT NULL,
  package_type VARCHAR(50) NOT NULL DEFAULT 'standard',
  special_requirements TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建索引以提高查询性能
CREATE INDEX idx_venue_bookings_venue_id ON venue_bookings(venue_id);
CREATE INDEX idx_venue_bookings_wedding_id ON venue_bookings(wedding_id);
CREATE INDEX idx_venue_bookings_status ON venue_bookings(status);
CREATE INDEX idx_venue_bookings_date ON venue_bookings(booking_date);

-- 创建预约状态枚举类型
ALTER TABLE venue_bookings 
ADD CONSTRAINT check_status 
CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed', 'no_show'));

-- 创建套餐类型枚举类型
ALTER TABLE venue_bookings 
ADD CONSTRAINT check_package_type 
CHECK (package_type IN ('basic', 'standard', 'premium', 'custom'));

-- 创建 RLS (Row Level Security) 策略
ALTER TABLE venue_bookings ENABLE ROW LEVEL SECURITY;

-- 允许用户查看自己婚礼的预约
CREATE POLICY "Users can view their own wedding bookings"
  ON venue_bookings FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM weddings 
      WHERE weddings.id = venue_bookings.wedding_id 
      AND weddings.user_id = auth.uid()
    )
  );

-- 允许用户创建预约
CREATE POLICY "Users can create bookings"
  ON venue_bookings FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM weddings 
      WHERE weddings.id = venue_bookings.wedding_id 
      AND weddings.user_id = auth.uid()
    )
  );

-- 允许用户更新自己的预约
CREATE POLICY "Users can update their own bookings"
  ON venue_bookings FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM weddings 
      WHERE weddings.id = venue_bookings.wedding_id 
      AND weddings.user_id = auth.uid()
    )
  );

-- 允许用户删除自己的预约
CREATE POLICY "Users can delete their own bookings"
  ON venue_bookings FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM weddings 
      WHERE weddings.id = venue_bookings.wedding_id 
      AND weddings.user_id = auth.uid()
    )
  );

-- 创建自动更新 updated_at 时间戳的函数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 创建触发器自动更新 updated_at
CREATE TRIGGER update_venue_bookings_updated_at
  BEFORE UPDATE ON venue_bookings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();