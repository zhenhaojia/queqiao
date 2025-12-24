# 鹊桥AI婚礼帮手 - Web版

> 智能婚礼策划平台，为新人提供一站式婚礼解决方案

## 项目概述

鹊桥AI婚礼帮手是一款基于AI技术的婚礼策划Web应用，通过智能算法为新人提供个性化婚礼方案、供应商对接、进度管理、预算控制等全方位服务。

## 主要功能

### 🤖 AI智能策划
- **方案生成**：基于用户需求智能生成个性化婚礼方案
- **方案优化**：根据用户反馈持续优化婚礼方案
- **智能问答**：24小时AI客服解答婚礼筹备问题

### 📋 筹备管理
- **进度管理**：详细的任务清单和时间节点
- **嘉宾管理**：嘉宾名单、邀请函发送、出席统计
- **预算控制**：智能预算分配、支出追踪、超支提醒

### 🏪 资源对接
- **供应商展示**：分类展示优质婚礼服务商家
- **在线对接**：直接与商家沟通、预约服务
- **评价体系**：真实用户评价，帮助选择可靠资源

## 技术栈

### 前端技术
- **框架**：Next.js 14 + React 18
- **样式**：Tailwind CSS + 自定义设计系统
- **状态管理**：Zustand
- **UI组件**：Headless UI + 自定义组件库
- **动画**：Framer Motion
- **图标**：Lucide React

### 后端服务
- **数据库**：Supabase (PostgreSQL)
- **AI服务**：预留API接口（待配置工作流）
- **认证**：手机号验证码、微信、QQ登录

### 开发工具
- **语言**：TypeScript
- **包管理**：npm
- **代码规范**：ESLint + Prettier

## 快速开始

### 环境要求
- Node.js 18+
- npm 或 yarn

### 安装依赖
```bash
npm install
```

### 环境配置
创建 `.env.local` 文件并配置以下变量：

```env
# 数据库配置
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# AI服务配置 (待配置)
# NEXT_PUBLIC_AI_API_URL=
# AI_API_KEY=

# 第三方登录配置 (待配置)
# NEXT_PUBLIC_WECHAT_APPID=
# NEXT_PUBLIC_QQ_APPID=
```

### 启动开发服务器
```bash
npm run dev
```

访问 [http://localhost:3000](http://localhost:3000) 查看应用。

### 构建生产版本
```bash
npm run build
npm start
```

## 项目结构

```
src/
├── app/                    # Next.js App Router
│   ├── globals.css        # 全局样式
│   ├── layout.tsx         # 根布局
│   ├── page.tsx           # 首页
│   ├── login/             # 登录页面
│   ├── register/          # 注册页面
│   └── ai-planning/       # AI策划页面
├── components/            # 组件库
│   ├── ui/               # 基础UI组件
│   ├── layout/           # 布局组件
│   └── features/         # 功能组件
├── lib/                  # 工具库
│   ├── aiService.ts     # AI服务接口
│   └── supabase.ts      # 数据库配置
├── store/                # 状态管理
│   ├── authStore.ts     # 用户认证状态
│   └── weddingStore.ts  # 婚礼数据状态
├── types/                # TypeScript类型定义
├── hooks/                # 自定义React Hooks
└── utils/                # 工具函数
```

## 核心特性

### 🎨 现代化UI设计
- 采用 Tailwind CSS 构建
- 响应式设计，适配各种设备
- 玻璃态效果和渐变色彩
- 流畅的动画过渡

### 🔐 用户认证
- 手机号验证码登录
- 微信、QQ第三方登录
- 安全的会话管理
- 用户信息持久化

### 🤖 AI服务集成
- 预留AI服务接口
- 支持多种AI功能
- 错误处理和重试机制
- 服务可用性检测

### 📊 数据可视化
- 进度图表展示
- 预算分析图表
- 嘉宾统计报表
- 数据导出功能

## 部署说明

### Vercel部署
1. 将代码推送到GitHub仓库
2. 在Vercel中导入项目
3. 配置环境变量
4. 自动部署

### 其他平台
支持部署到任何支持Next.js的平台，如：
- Netlify
- AWS Amplify
- 自建服务器

## 开发计划

### ✅ 已完成
- [x] 项目基础架构
- [x] UI组件库
- [x] 用户认证系统
- [x] AI策划模块（预留接口）
- [x] 响应式布局

### 🚧 进行中
- [ ] 资源对接模块
- [ ] 嘉宾管理功能
- [ ] 预算管理系统
- [ ] 数据可视化

### 📋 待开发
- [ ] 微信/QQ登录集成
- [ ] AI服务完整对接
- [ ] 移动端优化
- [ ] 性能优化
- [ ] 测试覆盖

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 联系我们

- 项目主页：[鹊桥AI婚礼帮手](https://queqiao-wedding.com)
- 问题反馈：[GitHub Issues](https://github.com/queqiao/wedding-assistant/issues)
- 邮箱：contact@queqiao-wedding.com

---

*让AI为您的婚礼保驾护航* 💒