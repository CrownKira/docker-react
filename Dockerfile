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

# docker build .  (get image id)
# docker run -p 8080:80 <image_id>   
FROM nginx
# copy everything from the builder phase 

# https://hub.docker.com/_/nginx
# in most env, this EXPOSE does nothing 
# just to tell the other developers that this 
# container needs a port map to port 80
# elasticbeanstalk will run this: 
# (knowing that the server inside docker is exposed at port 80)
# docker build .  (get image id)
# docker run -p 8080:80 <image_id>   
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html