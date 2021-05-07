docker build -t cha0s92/multi-client:latest -t cha0s92/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cha0s92/multi-worker:latest -t cha0s92/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t cha0s92/multi-server:latest -t cha0s92/multi-server:$SHA -f ./server/Dockerfile ./server

docker push cha0s92/multi-client:latest
docker push cha0s92/multi-worker:latest
docker push cha0s92/multi-server:latest

docker push cha0s92/multi-client:$SHA
docker push cha0s92/multi-worker:$SHA
docker push cha0s92/multi-server:$SHA

kubectl apply -f K8s
kubectl set image deployments/server-deployment server=cha0s92/multi-server:$SHA
kubectl set image deployments/client-deployment client=cha0s92/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cha0s92/multi-worker:$SHA
