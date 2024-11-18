FROM node:18
WORKDIR /app
COPY package.json ./
COPY . .
RUN npm install
RUN npm install cors --save
EXPOSE 3000
CMD ["node", "index.js"]
