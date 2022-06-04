FROM python:3 AS cve-manager
WORKDIR /cve-manager
COPY ./cve-manager/requirements.txt requirements.txt
RUN pip3 install -r requirements.txt