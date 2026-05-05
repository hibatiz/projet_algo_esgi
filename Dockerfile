FROM python:3.10-slim

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    iputils-ping \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Définir le dossier de travail
WORKDIR /app

# Copier tout le projet dans le conteneur
COPY . .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

#On lance le script en arrière plan et on maintien le conteneur actif 
CMD ["tail", "-f", "/dev/null"]
