Thanks to collector1871 from #archlinux.org.pl @ freenode.net


Użyta instrukcja (zadziałała) - data : 26.06.2019 rok

https://www.rdeeson.com/weblog/157/moving-arch-linux-to-a-new-ssd-with-rsync

Najpierw, pierwszy krok : zapisanie danych jako
ls -l /

Bezpośrednio na knoppix użyłem komendy (wraz z /mnt i /media):
/dev/sda1 - miejsce z którego chcę skopiować dane (stary dysk)

cd /dev/sda1
sudo rsync -aAXv ./* /media/knoppix/tymczasowy_dysk/ZMIANA_DYSKU --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/var/tmp/*,/run/*,/lost+found}

Następnie edycja /etc/fstab na nowym miejscu

ls -l /dev/disk/by-uuid
nano /etc/fstab

Później znowu rsync : przegranie z tymczasowego dysku na nowy
(komenda analogiczna)

A na końcu poprawa gruba, żeby załapał na nowym dysku:

sudo su
cd /mnt/newarch
mount -t proc proc proc/
mount --rbind /sys sys/
mount --rbind /dev dev/
chroot /mnt/newarch /bin/bash

Wszystkie komendy można wykonać bezposrednio na knoppix jako Live USB.

Na końcu sprawdzenie danych - porównanie z danymi z samego początku:
ls -l /
