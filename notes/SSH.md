# SSH

Struttura e permessi dei file

```
[drwx------]  .ssh
├── [-rw-r--r--]  authorized_keys
├── [-rw-------]  config
├── [-rw-------]  id_rsa
├── [-rw-r--r--]  id_rsa.pub
```

Generare coppia di chiavi

```
ssh-keygen -t rsa -b 2048
```

Poi copiare la pubblica su macchina remota

```
ssh-copy-id -i ~/.ssh/id_rsa.pub user@host
```

