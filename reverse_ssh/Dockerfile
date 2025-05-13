FROM reversessh/reverse_ssh

VOLUME /data

COPY ./start.sh start.sh
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]