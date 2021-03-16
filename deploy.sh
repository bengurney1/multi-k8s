docker build -t bengurney/multi-client:latest  -t bengurney/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bengurney/multi-server:latest -t bengurney/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bengurney/multi-worker:latest -t bengurney/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bengurney/multi-client:latest
docker push bengurney/multi-server:latest
docker push bengurney/multi-worker:latest
docker push bengurney/multi-client:$SHA
docker push bengurney/multi-server:$SHA
docker push bengurney/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bengurney/multi-server:$SHA
kubectl set image deployments/client-deployment client=bengurney/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bengurney/multi-worker:$SHA
