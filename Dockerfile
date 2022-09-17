FROM alpine:latest 

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

USER root
RUN mkdir -p /var/volume/
WORKDIR /var/volume

ENTRYPOINT ["python", "/var/volume/app.py"]
