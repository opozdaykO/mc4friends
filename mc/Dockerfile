FROM debian:trixie-slim

ARG MC_LINK

WORKDIR /app

EXPOSE 25565/tcp 25575/tcp

RUN apt update
RUN apt install -y wget
RUN apt install -y --no-install-recommends openjdk-21-jre
RUN wget -O server.jar $MC_LINK

CMD ["java", "-Xms4096M", "-Xmx4096M", "-jar", "server.jar", "nogui"]
