#!/bin/bash

# ============================================================
# CORRECTION GÉNÉRIQUE DE JS-DOS
# ============================================================
#
# Le script recherche automatiquement dans un répertoire
# tous les fichiers contenant :
#
#     setWindowTitle!=="undefined"
#
# et remplace cette chaîne par :
#
#     setWindowTitle=="undefined"
#
# Il n'est donc pas nécessaire de connaître à l'avance
# les fichiers problématiques.
#
# Une copie de chaque fichier est créée avant modification :
#
#     fichier.js
#     fichier.js.bak
#
# Utilisation :
#
#     ./reparer-jsdos.sh /chemin/vers/js-dos
#
# Exemple :
#
#     ./reparer-jsdos.sh 6.22.60
#
# ============================================================


# ------------------------------------------------------------
# Vérification de l'argument
# ------------------------------------------------------------

if [ -z "$1" ]; then
    echo "Usage : $0 /chemin/vers/js-dos"
    exit 1
fi


# ------------------------------------------------------------
# Répertoire à analyser
# ------------------------------------------------------------

DIR="$1"


# ------------------------------------------------------------
# Vérification du répertoire
# ------------------------------------------------------------

if [ ! -d "$DIR" ]; then
    echo "Erreur : le répertoire '$DIR' n'existe pas."
    exit 1
fi


# ------------------------------------------------------------
# Texte recherché
# ------------------------------------------------------------

OLD='setWindowTitle!=="undefined"'


# ------------------------------------------------------------
# Texte de remplacement
# ------------------------------------------------------------

NEW='setWindowTitle=="undefined"'


# ------------------------------------------------------------
# Recherche des fichiers problématiques
# ------------------------------------------------------------
#
# grep :
#
#   -r  recherche récursivement
#   -l  affiche uniquement les noms des fichiers
#   -I  ignore les fichiers binaires
#   -F  recherche le texte exactement
#
# "|| true" empêche le script de s'arrêter si grep ne
# trouve aucun fichier.
# ------------------------------------------------------------

mapfile -t FILES < <(
    grep -rIlF "$OLD" "$DIR" 2>/dev/null || true
)


# ------------------------------------------------------------
# Vérification du résultat de la recherche
# ------------------------------------------------------------

if [ "${#FILES[@]}" -eq 0 ]; then

    echo "Aucun fichier contenant :"
    echo
    echo "    $OLD"
    echo
    echo "n'a été trouvé dans :"
    echo
    echo "    $DIR"

    exit 0
fi


# ------------------------------------------------------------
# Affichage du nombre de fichiers trouvés
# ------------------------------------------------------------

echo "=========================================="
echo " Fichiers problématiques trouvés"
echo "=========================================="
echo

echo "Nombre de fichiers : ${#FILES[@]}"
echo


# ------------------------------------------------------------
# Affichage de la liste
# ------------------------------------------------------------

for FILE in "${FILES[@]}"; do
    echo "  $FILE"
done


echo
echo "=========================================="
echo " Correction"
echo "=========================================="
echo


# ------------------------------------------------------------
# Traitement de chaque fichier
# ------------------------------------------------------------

for FILE in "${FILES[@]}"; do

    echo "Traitement : $FILE"


    # --------------------------------------------------------
    # Création d'une sauvegarde
    # --------------------------------------------------------
    #
    # Le fichier original est conservé avec l'extension .bak.
    #
    # Exemple :
    #
    #     dosbox.js
    #
    # devient :
    #
    #     dosbox.js
    #     dosbox.js.bak
    #
    # --------------------------------------------------------

    BACKUP="$FILE.bak"


    # --------------------------------------------------------
    # Évite d'écraser une sauvegarde existante
    # --------------------------------------------------------
    #
    # Si .bak existe déjà, on ne le remplace pas.
    #
    # Cela évite de perdre la version originale si le script
    # est exécuté plusieurs fois.
    #
    # --------------------------------------------------------

    if [ ! -f "$BACKUP" ]; then

        cp -p "$FILE" "$BACKUP"

        echo "  Sauvegarde : $BACKUP"

    else

        echo "  Sauvegarde déjà présente : $BACKUP"

    fi


    # --------------------------------------------------------
    # Compte le nombre d'occurrences avant modification
    # --------------------------------------------------------

    COUNT=$(grep -oF "$OLD" "$FILE" | wc -l)


    echo "  Occurrences trouvées : $COUNT"


    # --------------------------------------------------------
    # Effectue le remplacement
    # --------------------------------------------------------
    #
    # sed -i modifie directement le fichier.
    #
    # "g" signifie que toutes les occurrences de la chaîne
    # sont remplacées.
    #
    # --------------------------------------------------------

    sed -i \
        's/setWindowTitle!=="undefined"/setWindowTitle=="undefined"/g' \
        "$FILE"


    # --------------------------------------------------------
    # Vérification après modification
    # --------------------------------------------------------

    if grep -Fq "$OLD" "$FILE"; then

        echo "  ERREUR : certaines occurrences sont encore présentes."

        # Restauration automatique
        cp -p "$BACKUP" "$FILE"

        echo "  Fichier restauré depuis la sauvegarde."

    else

        echo "  OK : $COUNT occurrence(s) corrigée(s)."

    fi


    echo

done


# ------------------------------------------------------------
# Résumé final
# ------------------------------------------------------------

echo "=========================================="
echo " Terminé"
echo "=========================================="
echo

echo "Fichiers traités : ${#FILES[@]}"
echo
echo "Les fichiers originaux sont conservés avec l'extension .bak."

