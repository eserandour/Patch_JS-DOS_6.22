#!/bin/bash

# ============================================================
# Recherche de fichiers contenant :
#
#     setWindowTitle!=="undefined"
#
# Utilisation :
#
#     ./liste-jsdos.sh /chemin/vers/le/repertoire
#
# Exemple :
#
#     ./liste-jsdos.sh /var/www/html/js-dos
# ============================================================


# ------------------------------------------------------------
# Vérifie qu'un répertoire a été fourni en argument
# ------------------------------------------------------------

if [ -z "$1" ]; then
    echo "Usage : $0 /chemin/vers/le/repertoire"
    exit 1
fi


# ------------------------------------------------------------
# Stocke le répertoire fourni dans une variable
# ------------------------------------------------------------

DIR="$1"


# ------------------------------------------------------------
# Vérifie que le répertoire existe
# ------------------------------------------------------------

if [ ! -d "$DIR" ]; then
    echo "Erreur : le répertoire '$DIR' n'existe pas."
    exit 1
fi


# ------------------------------------------------------------
# Texte que l'on recherche
# ------------------------------------------------------------

PATTERN='setWindowTitle!=="undefined"'


# ------------------------------------------------------------
# Recherche récursive avec grep
#
# -r  : recherche récursivement dans les sous-répertoires
# -l  : affiche uniquement le nom des fichiers contenant
#       le texte recherché
# -F  : recherche le texte exactement, sans expression
#       régulière
# -I  : ignore les fichiers binaires
#
# "$DIR" : répertoire dans lequel commencer la recherche
# ------------------------------------------------------------

grep -rIlF "$PATTERN" "$DIR"

