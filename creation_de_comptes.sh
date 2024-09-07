liste_groupes () {
    cat /etc/group | grep ":1[0-9][0-9][0-9]:" | cut -d\: -f1 | tr '\n' ' '
    echo ""
}


if [ $# -ne 2 ]
then
    echo "usage $0 : $0 <fichier> <groupe>" >&2
    echo "    fichier : fichier contenant nom,prenom,login[,passwd] par ligne" >&2
    echo "    (fichier efface a la fin)" >&2
    echo "    groupe : groupe d'inscription" >&2
    echo -n "liste des groupes disponibles : " >&2
    liste_groupes >&2
    exit 1
fi

fichier="$1"
chmod go-rwx $fichier
groupe="$2"

ajout_mot_de_passe () {
    passe=`pwgen 10 -1`
    echo "$prenom,$nom,$login,$passe" >> $fichier.passwd
}

creation_compte () {
    echo "Creation du compte pour $prenom $nom ($login:$groupe)"
    if [ -z $passe ]
    then
	ajout_mot_de_passe $fichier.passwd
    fi

    echo "$login:$passe::$groupe:$prenom,$nom:/home/$login:/usr/bin/bash" | sudo newusers
    echo "    ...faite"
}

cat $fichier | while read ligne;
do nom=`echo $ligne | cut -d, -f1 | xargs`;
   prenom=`echo $ligne | cut -d, -f2 | xargs`;
   login=`echo $ligne | cut -d, -f3 | xargs`;
   passe=`echo $ligne | cut -d, -f4 | xargs`;
   creation_compte
done
if [ -e $fichier.passwd ]
then
    chmod go-rwx $fichier.passwd
    echo "!!! Recuperez le fichier $fichier.passwd contenant les mots de passe et supprimez-le !!!"
else
    rm -f $fichier
fi
