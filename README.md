# patch_js-dos_6.22

Problème rencontré avec js-dos 6.22 : Le titre que je donne à mes pages html est écrasé par JS-DOS et indique DOSBox. Pour résoudre ce problème, je modifie certains fichiers de l’archive en remplaçant :

setWindowTitle!=="undefined"

par :

setWindowTitle=="undefined"
