# 使用官方 Node.js 环境作为父镜像
FROM node:18.10.0

# 安装 pnpm
RUN npm install -g pnpm

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 pnpm-lock.yaml 文件
COPY package.json pnpm-lock.yaml ./

# 安装依赖
RUN pnpm install --frozen-lockfile

# 拷贝项目文件到工作目录
COPY . .

# 这将在工作空间根目录显式运行 pnpm add 命令
#RUN pnpm add @prisma/client --workspace-root

# 设置环境变量（这些环境变量应该在部署时从外部传入，而不是写在 Dockerfile 中，为了示例这里写在这里）
# 你应该在部署时通过 docker run 的 -e 参数或者 docker-compose.yml 等方式来动态设置
ENV DATABASE_URL=postgresql://root:h129be4ZGw0DEx6X5U8zJBqfo3P7Lait@hkg1.clusters.zeabur.com:32593/zeabur
ENV REDIS_URL=redis://:t6bWTa0y7HqLKRZ2o51EkXGC3u489zvm@hkg1.clusters.zeabur.com:31125

# 把 3000 端口暴露给外部容器
EXPOSE 3000

# 容器启动时首先初始化数据库，随后运行应用
# 注意：db:init 可能依赖于数据库服务的可用性，因此在某些情况下你可能需要等待数据库服务启动完毕
CMD ["sh", "-c", "pnpm run db:init && pnpm start"]
