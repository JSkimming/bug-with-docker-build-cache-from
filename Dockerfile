# Stage 1
FROM alpine as stage1
WORKDIR /stage1tmp

ENV stge1=stge1

COPY ./ ./

RUN ls

# Stage 2
FROM alpine as stage2
WORKDIR /stage2tmp

ENV stge2=stge2

COPY --from=stage1 ./stage1tmp/for-stage2.txt .

RUN ls
RUN cat for-stage2.txt

# Stage 3
FROM alpine as stage3
WORKDIR /stage3tmp

ENV stge3=stge3

COPY --from=stage1 ./stage1tmp/for-stage3.txt .

RUN ls
RUN cat for-stage3.txt

# Stage 4
FROM alpine as stage4
WORKDIR /stage4tmp

ENV stge4=stge4

COPY --from=stage1 ./stage1tmp/for-stage4.txt .

RUN ls
RUN cat for-stage4.txt
