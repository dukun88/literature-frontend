FROM node:14
WORKDIR /app
COPY build .
RUN npm install -g serve
EXPOSE 3000
CMD [ "serve", "-s", "." ]
