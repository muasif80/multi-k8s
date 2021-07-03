docker build -t muasif80/multi-client:latest -t muasif80/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t muasif80/multi-server:latest -t muasif80/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t muasif80/multi-worker:latest -t muasif80/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push muasif80/multi-client:latest
docker push muasif80/multi-server:latest
docker push muasif80/multi-worker:latest

docker push muasif80/multi-client:$SHA
docker push muasif80/multi-server:$SHA
docker push muasif80/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=muasif80/multi-server:$SHA
kubectl set image deployments/client-deployment client=muasif80/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=muasif80/multi-worker:$SHA