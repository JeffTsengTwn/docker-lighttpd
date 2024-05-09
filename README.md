# docker-lighttpd
A simple dockefile for quick start lighttpd(lastly code) with HTTPS.
You can build docker image file and run in following steps:
1. Build docker image
```bash
docker build -t lighttpd-ssl .
```
2. Run docker image and mapping to host's port 8080(HTTP).
```bash
docker run -d -p 8080:8080 lighttpd-ssl
```
3. Run docker image and mapping to host's port 443(HTTPS).
```bash
docker run -d -p 443:443 lighttpd-ssl
```
4. And you can change _*ssl/server.pem*_ to the file  which signed by you. 