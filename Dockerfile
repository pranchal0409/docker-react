# build phase

FROM node:16-alpine as builder
# here builder is tag name for the phase
WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
# we do not need to use volume as this is production env
RUN npm run build  

# /app/build -> we nedd this in run phase

# run phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# /usr/share/nginx/html is the nginx base folder which will be displayed
# nginx will run on it's own 

