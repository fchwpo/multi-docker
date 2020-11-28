docker build -t fchwpo/multi-client:latest -t fchwpo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fchwpo/multi-server:latest -t fchwpo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fchwpo/multi-worker:latest -t fchwpo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fchwpo/multi-client:latest
docker push fchwpo/multi-server:latest
docker push fchwpo/multi-worker:latest

docker push fchwpo/multi-client:$SHA
docker push fchwpo/multi-server:$SHA
docker push fchwpo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment cont-server=fchwpo/multi-server:$SHA
kubectl set image deployments/client-deployment cont-client=fchwpo/multi-client:$SHA
kubectl set image deployments/worker-deployment cont-worker=fchwpo/multi-worker:$SHA