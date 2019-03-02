FROM python:3.6.2-slim

ENV FLASK_DEBUG=1

RUN groupadd flaskgroup && useradd -m -g flaskgroup -s /bin/bash flask
RUN echo "flask ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /home/flask/app/web

WORKDIR /home/flask/app/web
COPY src /home/flask/app/web

RUN pip install --no-cache-dir -r requirements.txt
RUN chown -R flask:flaskgroup /home/flask

USER flask

EXPOSE 8000
ENTRYPOINT ["/usr/local/bin/gunicorn", "--bind", ":8000", "page-views:app", "--reload", "--workers", "16"]