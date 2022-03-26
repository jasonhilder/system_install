#system install scripts

initial steps for system install script

* Generate ssh key and copy cat output
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
```

* log into github and add ssh key

* clone system install repo

* update the system
```
 sudo apt update

 sudo apt upgrade -y
```

WbuSHUQcr2
