
```
 sudo journalctl -f --unit devstack@c-vol
 ```

```
#cloud-config
password: XXXxx
chpasswd: { expire: False }
ssh_pwauth: True
```
