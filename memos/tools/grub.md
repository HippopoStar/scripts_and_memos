===== ===== ===== ===== =====  
===== GRUB  
===== ===== ===== ===== =====  

https://directory.fsf.org/wiki/Grub  
https://www.gnu.org/software/grub/manual/grub/html_node/Configuration.html  
https://git.savannah.gnu.org/gitweb/?p=grub.git;a=tree;hb=HEAD  

https://manpages.debian.org/buster/grub2-common/update-grub.8.en.html  

Configuration du gestionnaire d'amorcage Grub :  
```
GRUB_TIMEOUT=300
```
```
sudo vim /etc/default/grub
sudo update-grub
```

