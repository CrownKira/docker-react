# builder phase 
# from this FROM command and everything underneath it 
# is going to be refered to as the builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build 

# /app/bulid
# run phase 
# already has a default startup command attached to this image 
# so don't need to write the startup command
# default port nginx is using is port 80
FROM nginx
# copy everything from the builder phase 
# https://hub.docker.com/_/nginx
COPY --from=builder /app/build /usr/share/nginx/html