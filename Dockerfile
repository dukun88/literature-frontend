FROM node:14
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "build"]
FROM node:14
COPY build .
RUN npm install -g serve
EXPOSE 3000
CMD [ "serve", "-s", "." ]
