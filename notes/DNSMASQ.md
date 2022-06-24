### Example conf

```bash
dhcp-range=interface:eth1,10.10.10.1,10.10.10.10,12h
#dhcp-range=interface:eth2,10.20.20.1,10.20.20.10,12h

# dhcp-option=3

dhcp-option=6,10.0.2.2

#dhcp-option=121,10.10.10.0/24,10.20.20.254,10.20.20.0/24,10.10.10.254

dhcp-host=08:00:27:0c:a5:2a,10.10.10.101,12h #agent1
dhcp-host=08:00:27:0c:a5:2b,10.10.10.102,12h #agent2
```

---

Se vuoi sapere gli ip con un lease attivo, guarda  `/var/lib/misc/dnsmasq.leases`:

```
$ cat /var/lib/misc/dnsmasq.leases

1417132679 78:c5:e5:b4:4d:07 172.16.2.153 android-fbe390b0bb404da *
1417134678 20:54:76:e4:d8:a5 172.16.2.125 android-ab6e5d0a524c9c7d *

```

Se vuoi resettare una interface per forzare il dhcp release:

```bash
sudo dhclient -v -r
```

```bash
sudo ifdown eth1
sudo ifup eth1
```