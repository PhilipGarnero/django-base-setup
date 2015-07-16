from python:2.7-slim

RUN apt-get update && apt-get install -y \
                   libmysqlclient-dev \
                   libpq-dev \
                   sqlite3 \
                   build-essential \
		   git \
            --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove

RUN mkdir -p /app && mkdir -p /app/public
WORKDIR /app
COPY requirements.txt manage.py /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY base /app/base

EXPOSE 8000

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]