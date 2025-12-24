/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['localhost', 'crizdxqbastfmxwtmtmb.supabase.co'],
  },
  env: {
    CUSTOM_KEY: 'queqiao-ai-wedding',
  },
  reactStrictMode: true,
  swcMinify: true,
  experimental: {
    esmExternals: false,
  },
  // 添加缓存优化
  generateEtags: false,
  // 确保静态资源正确生成
  poweredByHeader: false,
}

module.exports = nextConfig