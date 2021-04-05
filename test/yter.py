from gpiozero import LED
from gpiozero import MotionSensor

red_led = LED(21)
er = MotionSensor(20)
red_led.off()

while True:
    er.wait_for_motion()
    print("Motion detected")
    red_led.on()
    er.wait_for_no_motion()
    red_led.off()
    print("Motion stopped")
