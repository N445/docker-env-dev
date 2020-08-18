# Docker env

## Installation

### Conf file

Copier `docker-compose.yml.dist` en `docker-compose.yml`

Copier `.env.dist` en `.env`

Remplir `DEV_PATH` vers le dossier de dévelopement (les sites)

Dans le dossier php/conf

Copier `.gitconfig.dist` en `.gitconfig`

Copier `composer_auth.json.dist` en `composer_auth.json`

Copier `crontab.dist` en `crontab`

Copier `docker-php-ext-xdebug.ini.dist` en `docker-php-ext-xdebug.ini` and edit for you

### SSH

Copier les fichiers SSH de la machine reconnue par Gitlab dans `php/.ssh`

- id_rsa
- id_rsa.pub

`docker-compose up`

## Maildev 

Pour utiliser maildev avec symfony, voici l'url du .env.local

`MAILER_URL=smtp://maildev:25`

url pour voir les mails `127.0.0.1:1080`

## PHPMYADMIN 

url `127.0.0.1:8080`
login : root
psw : 0000

## DATABASE

pour se connecter sur la base de donnée

en host mettre `mysql`

login : root
psw : 0000

## Wkhtmltoimage  Wkhtmltopdf

A la suite de l'installation les executables de `wkhtmltoimage` et `wkhtmltopdf` se trouvent dans :

- wkhtmltoimage : `/usr/bin/wkhtmltoimage`
- wkhtmltopdf : `/usr/bin/wkhtmltopdf`

### Mise a jour de NodeJs et NPM

- apt-get update && curl -sL https://deb.nodesource.com/setup_12.x | bash -
- apt-get install -y nodejs && npm install npm@latest -g
- nodejs -v && npm -v

### Xdebug

In PhpStorm

- 1 : File | Settings | Build, Execution, Deployment | Docker and add your docker
- 2 : File | Settings | Languages & Frameworks | PHP and add your cli interpreter
- 3 : File | Settings | Languages & Frameworks | PHP | Servers

(host = php ; port = 80 ; and match local path with docker path)
    
- 4 : On top right of phpstorm add a new configuration `PHP Remote Debug`
(Server = Docker ; IDE key the value in `docker-php-ext-xdebug.ini` `xdebug.idekey`)
- 5 : run debug + listening

http://urk.local/?XDEBUG_SESSION_START=xdebug

----------------------

# Options

Pour ajouter des hosts sur nginx

```yaml
    networks:
      frontend:
        aliases:
          - host.host
```

----------------------
# Erreurs et solutions

### Elasticsearch
##### Probleme au lancement
    elastic    | ERROR: [1] bootstrap checks failed
    elastic    | [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

Lancer cette commande :  
`sudo sysctl -w vm.max_map_count=262144`

pour que ca soit persistant :  
nano `/etc/sysctl.conf` et coller a la fin : `vm.max_map_count=262144`

### Donner les droits pour Magento2

chown www-data * -R
find var vendor pub/static pub/media app/etc -type f -exec chmod u+w {} \;
find var vendor pub/static pub/media app/etc -type d -exec chmod u+w {} \;
chmod u+x bin/magento

### Nginx
#### Entity too large

rajouter ca dans le server {} de votre vhost :  

`client_max_body_size 500M;`

-----------------------
