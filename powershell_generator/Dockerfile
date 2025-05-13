FROM debian:bullseye

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /powerhsell_scripts

ENTRYPOINT ["/start.sh"]