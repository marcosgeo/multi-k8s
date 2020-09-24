docker build -t marcosgeo/multi-client:latest -t marcosgeo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcosgeo/multi-server:latest -t marcosgeo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcosgeo/multi-worker:latest -t marcosgeo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcosgeo/multi-client:latest
docker push marcosgeo/multi-client:$SHA
docker push marcosgeo/multi-server:latest
docker push marcosgeo/multi-server:$SHA
docker push marcosgeo/multi-worker:latest
docker push marcosgeo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=marcosgeo/multi-client:$SHA
kubectl set image deployments/server-deployment server=marcosgeo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=marcosgeo/multi-worker:$SHA
