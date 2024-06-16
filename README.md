# Install
```zsh
docker compose up --build
```

### POST Request
```zsh
curl -X POST http://localhost:3000/users -H "Content-Type: application/json" -d '{"name": "John Doe", "age": 30}' 
```
```json
{"id":4,"name":"John Doe","age":30}  
```

### GET Request
```zsh
curl http://localhost:3000/users
```

Response
```json
[{"id":1,"name":"John Doe","age":30},{"id":2,"name":"John Doe","age":30},{"id":3,"name":"John Doe","age":30}]
```