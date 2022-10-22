# Lab_3_Docker

ssh-keygen
 
 docker build -t simpleweb -f Dockerfile .
 
 docker tag simpleweb jerazmus/simpleweb
 
 docker run -p 8080:8080 -d simpleweb
