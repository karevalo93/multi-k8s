docker build -t karevalo93/multi-client:latest -t karevalo93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t karevalo93/multi-server:latest -t karevalo93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t karevalo93/multi-worker:latest -t karevalo93/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push karevalo93/multi-client:latest
docker push karevalo93/multi-server:latest
docker push karevalo93/multi-worker:latest

docker push karevalo93/multi-client:latest:$SHA
docker push karevalo93/multi-server:latest:$SHA
docker push karevalo93/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karevalo93/multi-server:$SHA
kubectl set image deployments/client-deployment client=karevalo93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karevalo93/multi-worker:$SHA