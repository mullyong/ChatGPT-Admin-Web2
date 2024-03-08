# 使用官方 Node.js 环境作为父镜像
FROM node:18.10.0

# 设置容器中的工作目录
WORKDIR /usr/src/app

# 克隆项目仓库
RUN git clone https://github.com/AprilNEA/ChatGPT-Admin-Web.git .

# 安装 pnpm
RUN npm install -g pnpm

# 根据 package.json 安装所需的包
RUN pnpm install

# 设置环境变量，以便连接到 MySQL 数据库
# 注意：你应该将 '1Yjo3FnSVsNHO2GAQ4xZ8Pg60Wd579JC' 替换为你的实际密码
ENV DATABASE_URL=mysql://root:1Yjo3FnSVsNHO2GAQ4xZ8Pg60Wd579JC@hkg1.clusters.zeabur.com:31685/zeabur

# 设置环境变量，以便连接到您的Redis服务器
ENV REDIS_URL=redis://:t6bWTa0y7HqLKRZ2o51EkXGC3u489zvm@hkg1.clusters.zeabur.com:31125

# 把 3000 端口暴露给外部容器
EXPOSE 3000

# 容器启动时运行应用
CMD ["pnpm", "start"]
