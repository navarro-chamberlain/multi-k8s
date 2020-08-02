docker build -t navarrochamberlain/multi-client:latest -t navarrochamberlain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t navarrochamberlain/multi-server:latest -t navarrochamberlain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t navarrochamberlain/multi-worker:latest -t navarrochamberlain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push navarrochamberlain/multi-client:latest
docker push navarrochamberlain/multi-server:latest
docker push navarrochamberlain/multi-worker:latest

docker push navarrochamberlain/multi-client:$SHA
docker push navarrochamberlain/multi-server:$SHA
docker push navarrochamberlain/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=navarrochamberlain/multi-server:$SHA 
kubectl set image deployments/client-deployment client=navarrochamberlain/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=navarrochamberlain/multi-worker:$SHA 