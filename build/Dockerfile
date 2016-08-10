FROM alpine

# Create folder for certificates
RUN mkdir -p /docker/certificates && \
	mkdir -p /docker/etc

# Add certificates
ADD certificates /docker/certificates

# Copy customized hosts file
ADD etc /docker/etc

# Copy entrypoint script and set execution mode
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /vm-etc

ENTRYPOINT ["/entrypoint.sh"]
