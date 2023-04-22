FROM node:17 as builder
RUN git clone https://github.com/ping-pub/explorer.git /app
WORKDIR /app
COPY . .
run rm -rf src/chains/mainnet/*
COPY eqty.json src/chains/mainnet/eqty-1.json
RUN yarn install ; yarn build

FROM nginx:alpine
WORKDIR /ping
COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/ping.conf /etc/nginx/conf.d/default.conf
