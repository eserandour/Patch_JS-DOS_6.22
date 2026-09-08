# Patch_JS-DOS_6.22

JS-DOS permet d'exécuter un programme DOS dans un navigateur Web de manière très simple.<br>
Site officiel : https://js-dos.com.

Problème rencontré avec js-dos 6.22 : Le titre que je donne à mes pages html est écrasé par JS-DOS et indique DOSBox. Pour résoudre ce problème, je modifie certains fichiers de l’archive en remplaçant :

setWindowTitle!=="undefined"
par :
setWindowTitle=="undefined"

Pour lister les fichiers concernés par le problème, on utilise : liste-jsdos.sh<br>
Pour réparer les fichiers concernés par le problème, on utilise : reparer-jsdos.sh 
