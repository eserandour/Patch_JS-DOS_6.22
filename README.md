# Patch_JS-DOS_6.22

JS-DOS permet d'exécuter un programme DOS dans un navigateur Web de manière très simple.<br>
Site officiel : https://js-dos.com<br>
Version 6.22 : https://github.com/caiiiycuk/js-dos/releases/tag/6.22.60<br>

Problème rencontré avec JS-DOS 6.22 : Le titre que je donne à mes pages html est écrasé par JS-DOS et indique DOSBox. Pour résoudre ce problème, je modifie certains fichiers de l’archive en remplaçant :

setWindowTitle!=="undefined"<br>
par :<br>
setWindowTitle=="undefined"<br>

Pour lister les fichiers concernés par le problème, on utilise : liste-jsdos.sh<br>
Pour réparer les fichiers concernés par le problème, on utilise : reparer-jsdos.sh 
