# PLIFT BACKEND

Back de proyecto Plift

## Requisitos

- PostgreSQL
- Django 4.1.7
- Python 3.10.0

## Pasos

1. Crear entorno virtual `python -m venv env`
2. Activar scripts `env/Scripts/activate`
3. Instalar dependencias con el comando `pip install -r requirements.txt`
6. Crear migraciones `python manage.py makemigrations`
7. Correr migracions `python manage.py migrate`

## Para ejecutar el proyecto
1. Correr server con el comando:
   `python manage.py runserver`

# Deploy Docker Railway

## Build
1. `docker build --build-arg GITHUB_TOKEN=tu_token_aqui .`

## Railway .env vars
```
DATABASE_URL=postgresql://usuario:contraseña@host:5432/database?sslmode=require
SECRET_KEY=
DEBUG=False
ALLOWED_HOSTS=*
CORS_ALLOW_ALL=True
```

