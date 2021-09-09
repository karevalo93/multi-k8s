docker build -t karevalo93/multi-client-k8s:latest -t karevalo93/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t karevalo93/multi-server-k8s:latest -t karevalo93/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t karevalo93/multi-worker-k8s:latest -t karevalo93/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker
docker push karevalo93/multi-client-k8s:latest
docker push karevalo93/multi-server-k8s:latest
docker push karevalo93/multi-worker-k8s:latest

docker push karevalo93/multi-client-k8s:latest:$SHA
docker push karevalo93/multi-server-k8s:latest:$SHA
docker push karevalo93/multi-worker-k8s:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karevalo93/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=karevalo93/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=karevalo93/multi-worker-k8s:$SHA