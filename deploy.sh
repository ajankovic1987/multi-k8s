docker build -t ajankovic1987/multi-client:latest -t ajankovic1987/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajankovic1987/multi-server:latest -t ajankovic1987/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajankovic1987/multi-worker:latest -t ajankovic1987/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ajankovic1987/multi-client:latest
docker push ajankovic1987/multi-server:latest
docker push ajankovic1987/multi-worker:latest

docker push ajankovic1987/multi-client:$SHA
docker push ajankovic1987/multi-server:$SHA
docker push ajankovic1987/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajankovic1987/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajankovic1987/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajankovic1987/multi-worker:$SHA