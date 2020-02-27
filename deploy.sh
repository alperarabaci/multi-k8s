docker build -t alperarabaci/multi-client:latest -t alperarabaci/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alperarabaci/multi-server:latest -t alperarabaci/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alperarabaci/multi-worker:latest -t alperarabaci/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push alperarabaci/multi-client:latest
docker push alperarabaci/multi-server:latest
docker push alperarabaci/multi-worker:latest

docker push alperarabaci/multi-client:$SHA
docker push alperarabaci/multi-server:$SHA
docker push alperarabaci/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=alperarabaci/multi-server:$SHA
kubectl set image deployments/client-deployment  server=alperarabaci/multi-client:$SHA
kubectl set image deployments/worker-deployment  server=alperarabaci/worker-client:$SHA