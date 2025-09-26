FROM python:3.13-bullseye-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE=back_plift.settings

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        build-essential \
        libpq-dev \
        git \
    && rm -rf /var/lib/apt/lists/*

# Clonar rama específica
RUN git clone --branch main --single-branch https://github.com/keaguirre/plift-prod.git .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Recolectar archivos estáticos
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && gunicorn --bind 0.0.0.0:8000 back_plift.wsgi:application"]