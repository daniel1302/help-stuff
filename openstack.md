
```
 sudo journalctl -f --unit devstack@c-vol
 ```

```
#cloud-config
password: XXXxx
chpasswd: { expire: False }
ssh_pwauth: True
```

```
rm -rf /opt/stack
rm -rf /usr/local/bin/

./clean.sh
./unstack.sh
```
