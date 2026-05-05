#!/bin/bash

echo "=== Déploiement automatique de l'environnement DevOps ==="

# 1. Vérification de Docker
echo "[1] Vérification de Docker..."
if ! command -v docker &> /dev/null
then
    echo "Docker n'est pas installé. Installez Docker avant de continuer."
    exit 1
fi
echo "Docker OK."
echo ""

# 2. Création des volumes persistants SonarQube
echo "[2] Création des volumes Docker..."
docker volume create sonarqube_data >/dev/null
docker volume create sonarqube_extensions >/dev/null
echo "Volumes créés."
echo ""

# 3. Lancement de SonarQube
echo "[3] Lancement de SonarQube..."
docker stop sonarqube >/dev/null 2>&1
docker rm sonarqube >/dev/null 2>&1

docker run -d --name sonarqube \
    -p 9000:9000 \
    -v sonarqube_data:/opt/sonarqube/data \
    -v sonarqube_extensions:/opt/sonarqube/extensions \
    sonarqube:latest

echo "SonarQube lancé sur http://localhost:9000"
echo ""

# 4. Clonage du dépôt Git
echo "[4] Clonage du dépôt Git..."
REPO_URL="https://github.com/hibatiz/projet_algo_esgi.git"
FOLDER=$(basename "$REPO_URL" .git)

if [ -d "$FOLDER" ]; then
    echo "Le dossier existe déjà, suppression..."
    rm -rf "$FOLDER"
fi

git clone "$REPO_URL" "$FOLDER"
echo "Dépôt cloné."
echo ""

# 5. Construction de l'image Docker
echo "[5] Construction de l'image Docker..."
cd "$FOLDER"
docker build -t env-dev .
echo "Image construite."
echo ""

# 6. Lancement du conteneur de développement
echo "[6] Lancement du conteneur..."
docker run -it env-dev
