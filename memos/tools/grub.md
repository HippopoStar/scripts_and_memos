===== ===== ===== ===== =====  
===== GRUB  
===== ===== ===== ===== =====  

https://directory.fsf.org/wiki/Grub  
https://www.gnu.org/software/grub/manual/grub/html_node/Configuration.html  
https://git.savannah.gnu.org/gitweb/?p=grub.git;a=tree;hb=HEAD  

Configuration du gestionnaire d'amorcage Grub : voir `/etc/default/grub`:  
```
GRUB_TIMEOUT=300
```
```
grub2-mkconfig -o /boot/grub2/grub.cfg
```

