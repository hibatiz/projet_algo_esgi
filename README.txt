Projet Algo ESGI (Partie DevOps & Qualité Serveur)
# Projet Algo ESGI 
**Étudiant : Luka CLERTE, Emy CHARDELA, Hiba TIZAOUI**

---

## 🎯 Objectif du projet

Ce projet consiste à mettre en place un environnement de développement complet, automatisé et industrialisé pour un projet Python.
Il se concentre sur :

- La conteneurisation du projet avec Docker  
- La mise en place d’un environnement reproductible  
- L’intégration de SonarQube pour l’analyse de qualité  
- L’automatisation du déploiement via des scripts  
- La gestion de la persistance et des volumes Docker  

---

## 🐳 1. Environnement Docker

### ✔️ Dockerfile  
Le projet contient un `Dockerfile` permettant de :

- Installer Python  
- Installer les dépendances via `requirements.txt`  
- Exécuter le code dans un conteneur isolé  

### ✔️ Construction de l’image

```bash
docker build -t env-dev .
✔️ Lancement du conteneur
bash
docker run -it env-dev
📦 2. Dépendances Python
Les dépendances nécessaires au projet sont listées dans :

Code
requirements.txt
Elles sont automatiquement installées lors du build Docker.

🔍 3. Analyse de qualité avec SonarQube
✔️ Installation et lancement de SonarQube
SonarQube est lancé via Docker avec des volumes persistants :

bash
docker volume create sonarqube_data
docker volume create sonarqube_extensions

docker run -d --name sonarqube \
    -p 9000:9000 \
    -v sonarqube_data:/opt/sonarqube/data \
    -v sonarqube_extensions:/opt/sonarqube/extensions \
    sonarqube:latest
SonarQube est accessible ici :
👉 http://localhost:9000

📝 4. Configuration SonarScanner
Le fichier sonar-project.properties configure l’analyse :

Code
sonar.projectKey=mon-projet-python
sonar.projectName=mon-projet-python
sonar.projectVersion=1.0

sonar.sources=src
sonar.language=py

sonar.host.url=http://localhost:9000
sonar.token=VOTRE_TOKEN_ICI
✔️ Lancer l’analyse
bash
sonar-scanner
Les résultats sont visibles dans SonarQube.

⚙️ 5. Scripts de déploiement automatique
Deux scripts permettent d’automatiser l’installation complète de l’environnement :

✔️ Windows — deploy.ps1
Vérifie Docker

Crée les volumes

Lance SonarQube

Clone le dépôt

Construit l’image Docker

Lance le conteneur

Exécution :

powershell
./deploy.ps1
✔️ Linux — deploy.sh
Rendre exécutable :

bash
chmod +x deploy.sh
Exécution :

bash
./deploy.sh
📁 6. Arborescence du projet
Code
projet_algo_esgi/
│   Dockerfile
│   requirements.txt
│   sonar-project.properties
│   deploy.ps1
│   deploy.sh
│   README.md
│
└── src/
	api_binarytree.py
	api_gestion.py
	api_matrices.py
	demo_ml.py
	main.py