FROM node:20-alpine as builder

WORKDIR '/app'

# Add environment variables for the build process
ENV NODE_OPTIONS=--openssl-legacy-provider
ENV CHOKIDAR_USEPOLLING=true
ENV WDS_SOCKET_PORT=3000

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html/
