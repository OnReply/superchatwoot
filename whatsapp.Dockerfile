FROM node:alpine as builder

ENV NODE_ENV production

WORKDIR /home/whatsapp/app

RUN apk add --update --no-cache git

COPY ./whatsapp /home/whatsapp/app

RUN yarn install --production

FROM node:alpine

ENV NODE_ENV production

ENV REDIS_URL redis://:123456@redis:6379

ENV PORT 8888

RUN addgroup -S whatsapp && adduser -S whatsapp -G whatsapp

WORKDIR /home/whatsapp/app

COPY --from=builder /home/whatsapp/app .

USER whatsapp

CMD ["yarn", "start"]