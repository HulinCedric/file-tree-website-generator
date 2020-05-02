#!/bin/bash

# Declaration de la fonction parcours

	parcours()
	{
		fich=$1																# Le Fichier est egal a l'argument 1
		
		if [[ -d $fich ]]														# Si le Fichier est un dossier
		then																# On
			echo "<title> $TITRE </title>" > $1/index.html										# Cree l'index.html et y affiche le titre taper par l'utilisateur
			
			if [[ -n $CSS ]]													# Si un css a ete specifie
			then															# On
				echo '<link rel="stylesheet" media="screen" type="text/css" title="'`basename $CSS`'"  href="'$CSS'" />' >> $1/index.html	# Inclus le css dans le index.html
			fi
			if [[ -f .$1.titre ]]													# Si il y a un fichier .titre avec le meme nom que l'argument 1
			then 															# On
				echo "<h1> $(cat $PWD/.$1.titre) </h1>" >> $1/index.html							# Inclus le titre de la page avec ce qui a ecrie dedans
			else															# Sinon on
				echo "<h1> `basename $1` </h1>" >> $1/index.html								# Cree le titre de la page avec le nom de l'argument 1
			fi

			echo "<ul>" >> $1/index.html												# Inclus l'emplacement des liens dans index.html

			cd $fich														# Entre dans l'argument 1

			for elt in *														# Pour tout element present dans l'argument 1
			do															# On
				parcours $elt													# Appel recursivement la fonction "parcours"
			done

			echo "</ul>" >> $PWD/index.html												# Ferme l'emplacement des liens
			
			if [[ `basename $1` != `basename ../$DOSSIER` ]]									# Si l'argument 1 n'a pas le meme nom que le dossier pere
			then															# On
				CHEMIN=$PWD													# Place le chemin courant dans la variable CHEMIN
				cd ..														# Se deplace dans le dossier pere
				NEW=`basename $PWD`												# Place la fin du chemin courant dans NEW
				cd ..														# Se deplace dans le dossier pere

				if [[ -f .$NEW.titre ]]												# Si il y a un fichier .titre avec le meme nom que NEW
				then														# On
					RETITRE=`cat $PWD/.$NEW.titre`										# Place ce qui a marque dans le .titre dans la variable RETITRE
					cd $CHEMIN												# Retourne a CHEMIN
					echo "<a href=../index.html>Retour Vers $RETITRE</a>" >> $PWD/index.html				# Inclus le Retour avec le nom du .titre dans index.html
				else														# Sinon On
					cd $CHEMIN												# Retourne a CHEMIN
					echo "<a href=../index.html>Retour Vers $NEW</a>" >> $PWD/index.html					# Inclus le Retour avec NEW dans index.html
				fi
			fi
			echo "<hr>Hulin Cedric, Fouco Charles -- last date update : `date +%d/%m/%Y`</hr>" >> $PWD/index.html			# Cree le bas de page WEB nom + date

			cd ..															# Sort de l'argument 1

		else 																# Sinon

			if [[ -n $TYPE	]]													# Si le type de fichier est specifier
			then															# On
				for j in $TYPE													# Regarde tous les types specifies
              			do														# Et on Regarde
                 			if [[ ${1##*.} = $j ]]											# Si l'extension de l'argument 1 est egal aux types specifies
                 			then													# Et On Regarde
                   				if [[ -f .$1.titre ]]										# Si il y a un fichier .titre avec le meme nom que l'argument
                   				then												# On
                       					echo "<li><a href=\"$1\" > $(cat $PWD/.$1.titre) </a></li>" >> $PWD/index.html		# Inclus le lien de l'argument 1 avec ce qui est ecrie
																		# dans .titre
                   				else												# Sinon on
                       					echo "<li><a href=\"$1\" > $1 </a></li>" >> $PWD/index.html				# Inclus le lien de l'argument 1 avec le nom de celui-ci
                   				fi
                 			fi
              			done
			else															# Sinon on regarde

				if [[ -f .$fich.titre && $fich != index.html ]]									# Si il y a fichier .titre qui n'est pas index.html
				then														# On
					echo '<li><a href="'$PWD/$1'">'$(cat $PWD/.$1.titre)'</a></li>' >> $PWD/index.html			# Cree le lien du fichier avec ce qui a ecrie dans le .titre
				else														# Sinon on regarde

					if [[ -f $fich && $fich != index.html ]]								# Si il y a un fichier qui est different de index.html
					then													# On
						echo '<li><a href="'$PWD/$1'">'$1'</a>' >> $PWD/index.html					# Cree le lien des fichier avec le nom du fichier
					fi
				fi
			fi
		fi
		
		if [[ -d $1 ]]															# Si le premier argument 1 est un dossier
		then																# On

			if [[ `basename $1` != `basename ../$DOSSIER` ]]									# Si l'argument 1 n'a pas le meme nom que le dossier pere
			then															# On regarde

				if [[ -f .$1.titre ]]												# Si il y a fichier .titre qui qui a le meme nom de l'argument 1
				then														# On
					echo '<li><a href="'$PWD/$1/index.html'">'Dossier $(cat $PWD/.$1.titre)'</a></li>' >> $PWD/index.html	# Inclus un lien du dossier fils avec ce qui est ecrie dans .titr
				else														# Sinon
					echo '<li><a href="'$PWD/$1/index.html'">'Dossier $1'</a></li>' >> $PWD/index.html			# Inclus un lien du dossier fils avec le nom de celui-ci
				fi
					#echo '<br><a href="'$PWD/index.html'">'RETOUR `basename $PWD`'</a>' >> $PWD/$1/index.html		# On fait un lien du Dossier Pere dans le Sous Dossier
					#echo "<a href=javascript:history.back()>Retour</a>" >> $PWD/$1/index.html				# On dit de revenir en arriere
			fi
		fi
	}

# initialise le script

CSS=""																		# Initialise CSS a 0
TYPE=""																		# Initialise TYPE a 0

if [[ -z $1 ]]																	# Si l'argument 1 est vide
then																		# On
	echo 'Erreur usage : creer_index.sh [ Option ] ...'											# Genere une erreur
	exit 5																	# On quitte en renvoyant le valeur 5
fi

while [ $# -ge 1 ]																# Tan que le nombre d'argument est superieur ou egal a 1
do																		# On
	case $1 in																# Regarde dans le menu si l'argument 1 n'est pas egal a
	"--help"|"-h")																# l'aide
		cat help.txt | more														# On lis ce qui est dans help.txt
		exit 0																# Tous c'est bien passer, on renvoi 0
	;;
	
	"--dossier")																# le Dossier
	   	if [[ -z $2 ]] 															# Si l'argument 2 est vide
	    	then																# On
			echo 'Erreur usage : creer_index.sh --dossier "Destination manquante" ...'						# Genere une erreur
			exit 1															# On quitte en renvoyant le valeur 1
		fi
		if [[ -d $2 ]]															# Si l'argument 2 est un dossier
		then																# On Regarde
			if [[ ! -w $2 ]]													# Si on ne peu pas ecrire dedans
			then															# On
				echo 'Erreur usage : creer_index.sh --dossier "Destination" est pas accesible en ecriture'			# Genere un erreur
				exit 8														# On quitte en renvoyant le valeur 8
			fi
			DOSSIER=$2														# Place l'argument 2 dans la variable DOSSIER
			shift															# Fait un pas de 1 dans les arguments
			find $DOSSIER -name index.html -exec rm {} 2>/dev/null \;								# Cherche tous les index.html dans le dossier et les supprimes
			find $DOSSIER -name '*' -exec chmod 777 {} 2>/dev/null \;								# Change les droits de tout l'arborescence
		else																# Sinon On
			echo 'Erreur usage : creer_index.sh --dossier "Destination" est pas un dossier'						# Genere un erreur
			exit 7															# On quitte en renvoyant le valeur 7
		fi
	;;

	"--titre")																# le Titre
		TITRE=$2															# Place l'argument 2 dans la variable Titre
		shift																# Fait un pas de 1 dans les arguments
		if [[ -z $TITRE ]]														# Si la variable TITRE est vide
	    	then																# On
			echo 'Erreur usage : creer_index.sh --titre "Nom manquant" ...'								# Genere une erreur
			exit 2															# On quitte en renvoyant le valeur 2
		fi
	;;
	
	"--type")
		TYPE=$2																# le Type
		if [[ -z $2 ]]															# Si l'argument 2 est vide
	    	then																# On
			echo 'Erreur usage : creer_index.sh --type "Extension manquante" ...'							# Genere une erreur
			exit 3															# On quitte en renvoyant le valeur 3
		fi
		shift																# Fait un pas de 1 dans les arguments
	;;
	
	"--css")																# le Css
		if [[ -z $2 ]]															# Si l'argument 2 est vide
	    	then																# On
			echo 'Erreur usage : creer_index.sh --css "Nom manquant" ...'								# Genere une erreur
			exit 6															# On quitte en renvoyant le valeur 6
		else																# Sinon on
			if [[ -f $2 ]]														# Regarde si l'argument 2 est un fichier
			then															# On
				CSS=`basename $2`												# Place la fin du chemin de l'argument 2 dans la variable CSS
				CSS=$PWD/$CSS													# Rajoute a CSS le chemin courant
				if [[ ! -f $CSS ]]												# Si la variable CSS n'est pas un fichier
				then														# On
					CSS=$2													# Place l'argument 2 dans la variable CSS
				fi
			else															# Sinon
				echo "Erreur usage : le css est non valide"									# On genere une erreur
			fi
		fi
		shift																# Fait un pas de 1 dans les arguments
	;;

	
	*)																	# Tout autre chose
		echo "Erreur usage : l'option $1 n'est pas reconnue, elle a ete ignoree"							# On genere une erreur
        ;;

	esac
	shift																	# Fait un pas de 1 dans les arguments
done

if [[ -d $DOSSIER ]]																# Si le Dossier specifie est un Dossier
then																		# On fait ca
	
	parcours $DOSSIER															# Appel de la fonction parcours avec pour argument DOSSIER 																			# donner par l'utilisateur		
	find $DOSSIER -name '*' -exec chmod 755 {} 2>/dev/null \;										# Securise le site
else																		# Sinon on
	echo 'Erreur usage : creer_index.sh --dossier "Destination manquante" est non valide'							# Genere une erreur
	exit 4																	# On quitte en renvoyant le valeur 4
fi
exit 0																		# tous c'est bien passe, on renvoi 0 