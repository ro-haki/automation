FROM debian:bullseye

RUN apt update
RUN apt install -y openssh-client
RUN apt install -y sqlite3

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /shells_and_executions
VOLUME /reverse_ssh_data

ENTRYPOINT ["/start.sh"]