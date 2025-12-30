-- 为 vendors 表添加地址字段
ALTER TABLE vendors ADD COLUMN address TEXT;

-- 更新现有场地数据的地址（示例地址）
UPDATE vendors SET address = '北京市朝阳区湖畔路1号' WHERE name = '湖畔度假酒店婚礼中心';
UPDATE vendors SET address = '北京市朝阳区艺术中心南路2号' WHERE name = '现代艺术展览馆';
UPDATE vendors SET address = '北京市密云区古堡路88号' WHERE name = '古堡庄园婚礼会所';
UPDATE vendors SET address = '北京市顺义区森屿路168号' WHERE name = '森屿秘境草坪婚礼基地';
UPDATE vendors SET address = '北京市海淀区温泉路99号' WHERE name = '悦榕庄温泉度假酒店';
UPDATE vendors SET address = '北京市朝阳区游轮码头1号' WHERE name = '星空游轮婚礼会馆';
UPDATE vendors SET address = '北京市东城区国风街8号' WHERE name = '国风庭院婚礼堂';
UPDATE vendors SET address = '北京市朝阳区CBD中心大厦88层' WHERE name = '云端高空婚礼宴会厅';

-- 验证更新结果
SELECT name, address FROM vendors WHERE category = 'venue' ORDER BY rating DESC;