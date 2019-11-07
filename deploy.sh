docker build -t medrahim/multi-client:latest -t medrahim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t medrahim/multi-server:latest -t medrahim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t medrahim/multi-worker:latest -t medrahim/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push medrahim/multi-client:latest
docker push medrahim/multi-server:latest
docker push medrahim/multi-worker:latest

docker push medrahim/multi-client:$SHA
docker push medrahim/multi-server:$SHA
docker push medrahim/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=medrahim/multi-server:$SHA
kubectl set image deployments/client-deployment client=medrahim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=medrahim/multi-worker:$SHA