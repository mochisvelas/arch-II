import sys
import time

stop_countdown = False

def countdown():
    global stop_countdown
    for i in range(10,0,-1):
        print(i)
        if stop_countdown:
            break
        # sys.stdout.write(str(i)+' ')
        # sys.stdout.flush()
        time.sleep(1)
    return

countdown()
