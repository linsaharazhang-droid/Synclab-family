-- 创建评估结果表
CREATE TABLE IF NOT EXISTS assessment_results (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    family_code TEXT NOT NULL,
    role TEXT NOT NULL,
    results JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 开启行级安全 (RLS)
ALTER TABLE assessment_results ENABLE ROW LEVEL SECURITY;

-- 允许匿名插入 (客户端直接写入)
CREATE POLICY "Allow anonymous insert" ON assessment_results
    FOR INSERT WITH CHECK (true);

-- 允许匿名按 family_code 查询 (方便后期汇总)
CREATE POLICY "Allow anonymous read by code" ON assessment_results
    FOR SELECT USING (true);
