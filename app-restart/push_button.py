import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
import time
import os
from subprocess import Popen
#based on https://raspberrypihq.com/use-a-push-button-with-raspberry-pi-gpio/

def do_nothing():
    return ""

def kill_app():
    print("killing app")
    os.system("ps aux | grep -ie chromium-brwoser | awk '{print $2}' | xargs kill -9")
    
def start_app():
    print("starting app")
    Popen(['/bin/bash', '/home/pi/omx/omx-warmstart.sh'])
    print("start!")

def button_callback(channel):
    print("Button was pushed!")
    kill_app()
    start_app()
    
GPIO.setwarnings(False) # Ignore warning for now
GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_DOWN) # Set pin 10 to be an input pin and set initial value to be pulled low (off)

GPIO.add_event_detect(10,GPIO.RISING,callback=button_callback, bouncetime=1500) # Setup event on pin 10 rising edge

try:
    while True:
        # idling around
        do_nothing()
except KeyboardInterrupt:
    #message = input("Press enter to quit\n\n") # Run until someone presses enter
    GPIO.cleanup() # Clean up
