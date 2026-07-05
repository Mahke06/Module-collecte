#!/bin/bash

# =============================================================
#  Script de lancement – Interface Voly Vary
# =============================================================

# Répertoire du projet
PROJET="/home/kenny/Documents/S4/Mmd Baovola/Voly-Vary-main"

# URL de l'application
URL="http://localhost:8080"

# Aller dans le répertoire du projet
cd "$PROJET" || {
    echo "Erreur : impossible d'aller dans le répertoire $PROJET" >&2
    exit 1
}

echo "============================================"
echo "   VOLY VARY – Lancement de l'application"
echo "============================================"
echo ""
echo "  Répertoire : $PROJET"
echo "  URL        : $URL"
echo ""
echo "  Pages disponibles :"
echo "    → $URL/"
echo "    → $URL/collectes"
echo "    → $URL/collectes/ajouter"
echo "    → $URL/producteurs"
echo "    → $URL/producteurs/ajouter"
echo ""
echo "  Appuyez sur Ctrl+C pour arrêter"
echo "============================================"
echo ""

# Charger la configuration locale si un fichier .env existe
if [ -f ".env" ]; then
    set -a
    . ./.env
    set +a
fi

# Configuration PostgreSQL surchargeable :
# DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-voly_vary}"
DB_USER="${DB_USER:-postgres}"

if [ -z "${DB_PASSWORD:-}" ] && [ -t 0 ]; then
    read -r -s -p "Mot de passe PostgreSQL pour $DB_USER (Entrée = postgres) : " DB_PASSWORD
    echo ""
fi
DB_PASSWORD="${DB_PASSWORD:-postgres}"

export SPRING_DATASOURCE_URL="jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME"
export SPRING_DATASOURCE_USERNAME="$DB_USER"
export SPRING_DATASOURCE_PASSWORD="$DB_PASSWORD"

# Choisir Maven : wrapper si complet, sinon Maven installé sur la machine
if [ -f "./.mvn/wrapper/maven-wrapper.properties" ]; then
    MAVEN_CMD="./mvnw"
elif command -v mvn >/dev/null 2>&1; then
    MAVEN_CMD="mvn"
else
    echo "Erreur : Maven est introuvable." >&2
    echo "Installez Maven ou restaurez .mvn/wrapper/maven-wrapper.properties." >&2
    exit 1
fi

# Ouvrir le navigateur après 10 secondes (le temps que le serveur démarre)
if command -v xdg-open >/dev/null 2>&1; then
    (sleep 10 && xdg-open "$URL" >/dev/null 2>&1) &
fi

# Lancer l'application Spring Boot
"$MAVEN_CMD" spring-boot:run
