FROM node:16-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:stable-alpine as deploy-stage
COPY --from=build-stage /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx-debug", "-g", "daemon off;"]
