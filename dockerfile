# Using node version alpine image as a base image for builder phase
FROM node:alpine as builder

# Specifying the working directory
WORKDIR '/app'

# Copying dependency file to the workspace
COPY package.json .

# Installing dependency
RUN npm install

# Copying rest application files
COPY . .

# Build the production files
RUN npm run build

# After completion of builder phase, docker create new image using nginx as a base imnage
FROM nginx

# Copying build files from previous phase to this image
COPY --from=builder /app/build /usr/share/nginx/html

