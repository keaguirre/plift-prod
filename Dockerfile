FROM python:3.13-slim-bookworm
# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE=back_plift.settings

# Directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        build-essential \
        libpq-dev \
        git \
    && rm -rf /var/lib/apt/lists/*

# Clonar el repositorio público
RUN git clone https://github.com/keaguirre/plift-prod.git .

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Recolectar archivos estáticos con variables temporales para el build
RUN DATABASE_URL="sqlite:///temp.db" SECRET_KEY="temp-key-for-build" python manage.py collectstatic --noinput

# Exponer el puerto
EXPOSE 8000

# Ejecutar migraciones y iniciar servidor
CMD ["sh", "-c", "python manage.py migrate && gunicorn --bind 0.0.0.0:8000 back_plift.wsgi:application"]