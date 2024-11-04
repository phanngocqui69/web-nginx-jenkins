# Sử dụng image Nginx
FROM nginx:alpine

# Sao chép các file ứng dụng web vào thư mục HTML của Nginx
COPY . /usr/share/nginx/html

# Mở cổng 80 cho Nginx
EXPOSE 80