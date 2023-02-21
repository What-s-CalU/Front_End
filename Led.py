#! /usr/bin/env python

# Simple string program. Writes and updates strings.
# Demo program for the I2C 16x2 Display with leds and buttons 
################################################################################
# Import necessary libraries for communication and display use
from time import sleep
import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)
import drivers
GPIO.setwarnings(False) #to stop warings 
#################################################################

# Load the driver and set it to "display"
# If you use something from the driver library use the "display." prefix first
display = drivers.Lcd() 
#################################################################
#GPIO connections 
Bnpin = 17
Ledpin = 4

Bnpin2 = 27
Ledpin2 = 22
# set up for first led pin
GPIO.setup(Ledpin,GPIO.OUT)
GPIO.setup(Bnpin,GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.output(Ledpin,False)
# set up forsecond led pin
GPIO.setup(Ledpin2,GPIO.OUT)
GPIO.setup(Bnpin2,GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.output(Ledpin2,False)
#################################################################

#define functions for buttons 1&2
def Bnpin_callback(channel):
    GPIO.output(Ledpin, True)
    sleep(1)
    GPIO.output(Ledpin,False)
   
    
def Bnpin2_callback(channel):
    GPIO.output(Ledpin2, True)
    sleep(1)
    GPIO.output(Ledpin2,False) # led off
    display.lcd_clear()
    display.lcd_display_string("clearing", 1) 
    display.lcd_display_string("everything", 2)
    sleep(2)
    display.lcd_clear()
    sleep(1)
    
# for long string Parameters: (driver, string to print, number of line to print, number of columns of your display) 
#Return: This function send to display your scrolling string.
def long_string(display, text='', num_line=1, num_cols=16):

		if len(text) > num_cols:
			display.lcd_display_string(text[:num_cols], num_line)
			sleep(1)
			for i in range(len(text) - num_cols + 1):
				text_to_print = text[i:i+num_cols]
				display.lcd_display_string(text_to_print, num_line)
				sleep(1)
			sleep(1)
		else:
			display.lcd_display_string(text, num_line)

####################################################################

#add event detection for buttons 1&2
GPIO.add_event_detect(Bnpin,GPIO.FALLING,callback=Bnpin_callback,bouncetime=200)
GPIO.add_event_detect(Bnpin2,GPIO.FALLING,callback=Bnpin2_callback,bouncetime=200)
######################################################################
#continous loop for LCD display
#######################################################################
try:
    while True:
        # Remember that your sentences can only be 16 characters long!
        print("Writing to display") # to make sure that it is printing to the LCD
        display.lcd_display_string(" What's @ CALU!", 1)  # Write line of text to first line of display
        sleep(2)
        display.lcd_clear()
        long_string(display,"upcoming notifications:", 2)  # Write line of text to first line of display
        sleep(2)
        display.lcd_clear()
        sleep(1)
        display.lcd_display_string("Notifications:", 1)  # Write line of text to second line of display
        sleep(3)                                           # Give time for the message to be read
        #long_string(display,"most recent notification was: ", 2)   # Refresh the first line of display with a different message
        #sleep(2)                                           # Give time for the message to be read
        display.lcd_clear()                                # Clear the display of any data
        sleep(3)          # Give time for the message to be read	
                
		
		
except KeyboardInterrupt as e:
    print(e)
    display.lcd_clear()	 
    GPIO.cleanup()	
   
