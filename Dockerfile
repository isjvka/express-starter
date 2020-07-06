FROM node:14-alpine AS base

EXPOSE 3000
ENV NODE_ENV=production

RUN mkdir /app && chown -R node:node /app
WORKDIR /app
USER node

COPY --chown=node:node package*.json ./
RUN npm i --only=production && npm cache clean --force


FROM base AS dev

ENV NODE_ENV=development
ENV PATH /app/node_modules/.bin:$PATH

RUN npm i --only=development

CMD [ "nodemon" ]


FROM dev AS build

COPY --chown=node:node . .
RUN tsc


FROM base AS prod

COPY --chown=node:node --from=build /app/dist/ .

CMD [ "node", "main.js" ]
