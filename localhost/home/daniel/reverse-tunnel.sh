# Connect to HOST[X]:REMOTE_PORT[X] from localhost:LOCAL_PORT[X] using REMOTE_USER[X]
i=0
HOST[$i]="remotehost1"
REMOTE_PORT[$i]=5555
LOCAL_PORT[$i]=6000
REMOTE_USER[$i]="user1"

i=$i+1
HOST[$i]="remotehost2"
REMOTE_PORT[$i]=5555
LOCAL_PORT[$i]=6001
REMOTE_USER[$i]="user2"