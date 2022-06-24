# Rsyslog

Ogni volta che facciamo cambiamenti ristartiamo con

```bash
systemctl restart rsyslog
```

Usando il **logger** mandiamo a rsyslog un determinato messaggio con una determinata priority

```bash
echo "ciao" | logger -p local1.info
```

Nel file /etc/rsyslog.conf ci sono tutte le conf oppure nella cartella rsyslog.d inseriamo i nostri file .conf

Se vuoi mandare ad un server remoto metti in un `.conf`

```bash
local0.=info @server:port # UDP
local0.=info @@server:port # TCO
```

Poi devi abilitare la porta di rsyslog per ascoltare in udp o tcp (`rsyslog.conf` o guarda ansible)

# Systemd

[https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)

Fa in modo che al boot venga fatto partire

```bash
[Install]
Wanted-by=basic.target
```

Restart on failure

```bash
[Service]
Restart=on-failure
```