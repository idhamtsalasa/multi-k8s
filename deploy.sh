docker build -t archvalkryn/multi-client:latest -t archvalkryn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t archvalkryn/multi-server:latest -t archvalkryn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t archvalkryn/multi-worker:latest -t archvalkryn/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push archvalkryn/multi-client:latest
docker push archvalkryn/multi-server:latest
docker push archvalkryn/multi-worker:latest

docker push archvalkryn/multi-client:$SHA
docker push archvalkryn/multi-server:$SHA
docker push archvalkryn/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=archvalkryn/multi-server:$SHA
kubectl set image deployments/client-deployment client=archvalkryn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=archvalkryn/multi-worker:$SHA
