Write-Host "=== Déploiement automatique de l'environnement DevOps ===" -ForegroundColor Cyan

# 1. Vérification de Docker
Write-Host "[1] Vérification de Docker..."
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker n'est pas installé. Installez Docker Desktop avant de continuer." -ForegroundColor Red
    exit 1
}
Write-Host "Docker OK.`n"

# 2. Création des volumes persistants SonarQube
Write-Host "[2] Création des volumes Docker..."
docker volume create sonarqube_data | Out-Null
docker volume create sonarqube_extensions | Out-Null
Write-Host "Volumes créés.`n"

# 3. Lancement de SonarQube
Write-Host "[3] Lancement de SonarQube..."
docker stop sonarqube 2>$null
docker rm sonarqube 2>$null

docker run -d --name sonarqube `
    -p 9000:9000 `
    -v sonarqube_data:/opt/sonarqube/data `
    -v sonarqube_extensions:/opt/sonarqube/extensions `
    sonarqube:latest

Write-Host "SonarQube lancé sur http://localhost:9000`n"

# 4. Clonage du dépôt Git
Write-Host "[4] Clonage du dépôt Git..."
$repoUrl = "https://github.com/TON_REPO_ICI.git"
$folder = "mon-projet"

if (Test-Path $folder) {
    Write-Host "Le dossier existe déjà, suppression..."
    Remove-Item -Recurse -Force $folder
}

git clone $repoUrl $folder
Write-Host "Dépôt cloné.`n"

# 5. Construction de l'image Docker
Write-Host "[5] Construction de l'image Docker..."
cd $folder
docker build -t env-dev .
Write-Host "Image construite.`n"

# 6. Lancement du conteneur de développement
Write-Host "[6] Lancement du conteneur..."
docker run -it env-dev
