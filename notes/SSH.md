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

Una volta generate le chiavi in files/keys/ facciamo questo

- Dentro al client mettiamo la chiave privata usando questi script ansible cambiando "temp" con l'utente necessario

#- name: Check for directory
#  ansible.builtin.file:
#    path:  "{{ item }}"
#    mode: 0700
#    group: temp
#    owner: temp
#    state: directory
#  with_items:
#    - "/home/temp/"
#    - "/home/temp/.ssh/"
#
#- name: copy ssh config
#  ansible.builtin.copy:
#    src: "files/keys/ssh-config"
#    dest: "/home/temp/.ssh/config"
#    mode: 0600
#    owner: temp
#    group: temp
#
#- name: Add ssh key for temp user
#  ansible.builtin.copy:
#    src: "files/keys/id_rsa"
#    dest: "/home/temp/.ssh/"


- Dentro al server mettiamo la chiave pubblica con questi script cambiando "temp" con l'utente necessario

#ssh stuff  for nerds
#    - name: Check for directory
#      ansible.builtin.file:
#        path:  "{{ item }}"
#        mode: 0700
#        group: temp
#        owner: temp
#        state: directory
#      with_items:
#       - "/home/temp/"
#       - "/home/temp/.ssh"
#
#    - name: update public keys
#      ansible.posix.authorized_key:
#        user: temp
#        state: present
#        key: "{{ lookup('file', 'files/keys/id_rsa.pub' ) }}"


