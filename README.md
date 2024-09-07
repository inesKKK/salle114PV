# salle114PV
Scripts d'installation pour la salle 114.


## Création de comptes

prérequis : installer `pwgen`

`creation_de_comptes.sh` s'utilise sous la forme

```
usage ./creation_de_comptes.sh : ./creation_de_comptes.sh <fichier> <groupe>
    fichier : fichier contenant nom,prenom,login[,passwd] par ligne
    (fichier efface a la fin)
    groupe : groupe d'inscription
```

permet de créer des comptes à partir d'un
fichier dont chaque ligne correspond à un compte et est au format :
* `nom,prenom,login` : dans ce cas le script crée un mot de passe avec
  `pwgen` et ajoute une ligne de la forme `nom,prenom,login,password`
  à la fin du fichier `fichier.passwd`
* `nom,prenom,login,password`

Si toutes les lignes contiennent un mot de passe, le fichier fourni
est détruit. Sinon un fichier `fichier.passwd` est généré (lisible
uniquement par le propriétaire).

Si un utilisateur existe déjà, les informations autres que son login
sont mises à jour.
