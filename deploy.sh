docker build -t jvilcans/multi-client:latest -t jvilcans/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jvilcans/multi-server:latest -t jvilcans/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jvilcans/multi-worker:latest -t jvilcans/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jvilcans/multi-client:latest
docker push jvilcans/multi-server:latest
docker push jvilcans/multi-worker:latest

docker push jvilcans/multi-client:$SHA
docker push jvilcans/multi-server:$SHA
docker push jvilcans/multi-worker:$SHA

kubectl -f k8s
kubectl set image /deployments/server-deployment server=jvilcans/multi-server:$SHA
kubectl set image /deployments/client-deployment client=jvilcans/multi-client:$SHA
kubectl set image /deployments/worker-deployment worker=jvilcans/multi-worker:$SHA
