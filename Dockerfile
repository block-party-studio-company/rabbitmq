FROM rabbitmq:3.9.18-management

# Upload our configuration file
COPY rabbitmq.conf /etc/rabbitmq/
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

# Upload modified entrypoint file
COPY docker-entrypoint.sh /usr/local/bin

# Expose 15692 (for metrics)
EXPOSE 15692
