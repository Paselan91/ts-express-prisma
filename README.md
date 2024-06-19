# Install
```zsh
docker compose up --build
```
```zsh
docker-compose exec api yarn prisma migrate dev
```

# Update API
After Update API, you need to exec following command to update dist.
```zsh
yarn build
```
```zsh
docker compose up 
```

### POST Request
```zsh
curl -X POST http://localhost:80/users -H "Content-Type: application/json" -d '{"name": "John Doe", "age": 30}'
```
```json
{"id":4,"name":"John Doe","age":30}
```

### GET Request
```zsh
curl http://localhost:80/users
```

Response
```json
[{"id":1,"name":"John Doe","age":30},{"id":2,"name":"John Doe","age":30},{"id":3,"name":"John Doe","age":30}]
```


# Deploy to AWS ECR
Exec build-deploy-to-ecr.sh
```zsh
ECR_ENDPOINT=<your-ecr-uri> ECS_CLUSTER_NAME=my-cluster ECS_SERVICE_NAME=my-service IMAGE_NAME=latest ./build-deploy-to-ecr.sh
```
