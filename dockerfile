FROM ubuntu
RUN apt-get update && apt install -y nginx
EXPOSE 80
WORKDIR /devops
RUN touch file1 file2
