#bin/bash
echo "[root@localhost ~]# cd /"
cd /
echo "[root@localhost /]# mkdir docker"
mkdir docker
sudo bash -c "cat > Dockerfile<<EOF
FROM nginx:latest

COPY index.html /usr/share/nginx/html/

EOF"

echo "[root@localhost ~]# vi Dockerfile"
sudo vim Dockerfile

sudo bash -c "cat > index.html <<EOF
<h1>This is Docker Swarm</h1>
EOF"
echo "[root@localhost ~]# vim index.html"
vim index.html
read -p "set your username " username
read -p "set your tag " tag
echo "[root@localhost ~]# docker build -t $tag-$username/nginx-custom ."
docker build -t $tag-$username/nginx-custom .
echo "[root@localhost ~]# docker login"
docker login
echo "[root@localhost ~]# docker push $tag-$username/nginx-custom"
docker push $tag-$username/nginx-custom
echo "[root@localhost ~]# docker swarm init"
docker swarm init
echo "[root@localhost ~]# docker service create   --replicas 1   --name nginx-service  -p 80:80 $tag-$username/nginx-custom"
docker service create   --replicas 1   --name nginx-service  -p 80:80 $tag-$username/nginx-custom

echo "[root@localhost ~]# docker service ls"
docker service ls
read -p "set id of your service " id
echo "[root@localhost ~]# docker inspect $id"
docker inspect $id
echo "[root@localhost ~]# docker service scale nginx-service=2"
docker service scale nginx-service=2
echo "[root@localhost ~]# vim index.html"
vim index.html
echo "[root@localhost ~]# cp index.html /usr/share/nginx/html/"
cp index.html /usr/share/nginx/html/
echo "[root@localhost ~]# docker build -t $tag-$username/nginx-custom:v2 -f Dockerfile.nginx_v2 ."
docker build -t $tag-$username/nginx-custom:v2 -f Dockerfile.nginx_v2 .
echo "[root@localhost ~]# docker push $tag-$username/nginx-custom:v2"
docker push $tag-$username/nginx-custom:v2
