FROM python:3.12

ENV PYTHONUNBUFFERED 1
RUN mkdir /easemart_backend
WORKDIR /easemart_backend
COPY . /easemart_backend/
RUN pip install -r requirements.txt