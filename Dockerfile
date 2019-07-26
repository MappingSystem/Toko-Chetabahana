FROM alpine
COPY example.html /example.html
ENTRYPOINT ["sh", "cat", "/example.html"]
