FROM python:3.8
COPY . .
RUN apt update \
 && DEBIAN_FRONTEND=noninteractive \
    apt install --no-install-recommends --assume-yes \
    python3-dev libpq-dev postgresql postgresql-contrib nginx
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt
EXPOSE 8000
RUN python3 manage.py migrate --run-syncdb
CMD python3 manage.py runserver 0.0.0.0:8000