FROM node:18

WORKDIR /app
RUN npm install express javascript-obfuscator mustache
COPY . .

EXPOSE 3000

CMD ["node", "server.js"]