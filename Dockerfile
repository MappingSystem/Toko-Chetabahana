FROM alpine
COPY example.html /example.html
ENTRYPOINT ["sh", "ls"]
