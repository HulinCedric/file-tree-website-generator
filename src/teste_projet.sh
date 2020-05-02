#! /bin/bash

# recopiez ce script dans le repertoire qui contient votre script creer_index.sh
# puis executez le!

chmod a-w Test_de_dossier_sans_droit_ecriture

#rm -rf Sources_de_Test			je met en commentaire pck je suis pas connecté a linserv
#cp -r ~syska/ASR3/Projet_2008/Sources_de_Test .

echo "Test de l'option page de manuel"
./creer_index.sh -h
# doit afficher la page de manuel
read pause

echo "Deuxieme test de l'option page de manuel"
./creer_index.sh --help
# doit afficher la page de manuel
read pause

echo "Test de --dossier avec un fichier au lieu d'un dossier"
./creer_index.sh --dossier Sources_de_Test/Repertoire_Simple/hello.cs
# doit generer une erreur
read pause

echo "Test de --dossier avec un dossier sans droits en ecriture"
./creer_index.sh --dossier Test_de_dossier_sans_droit_ecriture
# doit generer une erreur
read pause

echo "Test avec une mauvaise option"
./creer_index.sh --dosier Sources_de_Test/Repertoire_Simple
# doit generer une erreur
read pause

echo "Test simple repertoire"
./creer_index.sh --dossier Sources_de_Test/Repertoire_Simple --titre "Quelques exemples de Hello World"
# doit creer un fichier index.html similaire a
# ~syska/ASR3/Projet_2008/Resultat_Web/Repertoire_Simple/index.html
# ou bien
# file:///S:/ASR3/Projet/Test_Projet_2008/Resultat_Web/Repertoire_Simple/index.html
read pause

echo "Test arborescence"
./creer_index.sh --dossier Sources_de_Test/Arborescence --titre "Quelques exemples de Hello World par type de Langage"
# doit creer un fichier index.html similaire a ceux trouves sous
# ~syska/ASR3/Projet_2008/Resultat_Web/Arborescence
# ou bien
# file:///S:/ASR3/Projet/Test_Projet_2008/Resultat_Web/Arborescence
read pause

echo "Test arborescence et titre"
./creer_index.sh --dossier Sources_de_Test/Arborescence_Titre --titre "Quelques exemples de Hello World par type de Langage"
# doit creer un fichier index.html similaire a ceux trouves sous
# ~syska/ASR3/Projet_2008/Resultat_Web/Arborescence_Titre
# ou bien
# file:///S:/ASR3/Projet/Test_Projet_2008/Resultat_Web/Arborescence_Titre
read pause

echo "Test arborescence et titre et css"
./creer_index.sh --dossier Sources_de_Test --titre "Vive l'ASR3" --css wahou.css
# doit creer un fichier index.html similaire a ceux trouves sous
# ~syska/ASR3/Projet_2008/Resultat_Web
# ou bien
# file:///S:/ASR3/Projet/Test_Projet_2008/Resultat_Web
# avec un style css
read pause

echo 'Test arborescence et titre et css et type "pdf c cs"'
./creer_index.sh --dossier Sources_de_Test --titre "Vive l'ASR3" --css wahou.css --type "pdf c cs"
# doit creer un fichier index.html similaire a ceux trouves sous
# ~syska/ASR3/Projet_2008/Resultat_Web
# ou bien
# file:///S:/ASR3/Projet/Test_Projet_2008/Resultat_Web
# avec un style css
# et seulement avec des fichier de .pdf .c et .cs
read pause

echo enjoy ^^

