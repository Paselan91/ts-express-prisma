FROM node:20-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["node", "dist/index.js"]