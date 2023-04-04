FROM alpine:latest

LABEL maintainer="Etzion Bar Noy <etzion@barnoy.co.il>"
LABEL builder="Etzion Bar Noy"
LABEL GitHubPage="https://github.com/ezaton/dnsexit"

COPY dnsexit.sh .
RUN apk add --no-cache curl bash && rm -rf /var/cache/apk/*

ENTRYPOINT ["bash", "/dnsexit.sh"]
CMD [""]
