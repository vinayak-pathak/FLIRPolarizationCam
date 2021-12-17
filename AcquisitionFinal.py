# -*- coding: utf-8 -*-
"""
Created on Thu Dec 16 13:27:01 2021

@author: Vinayak Pathak
@final acquisition pipeline for FLIR polarization camera

"""

#%%
from simple_pyspin import Camera
from PIL import Image
import os
import serial
import time
#%% Initialize the camera LED for illumination
COM_PORT = 'COM3' # COM port for RPI Pico
    
BAUD_RATE = 115200
    # GPIO pin number on RPI Pico where the array is connected
LED_PIN = 2
LEDport = serial.Serial(COM_PORT, BAUD_RATE)
LEDport.write(("INIT PIN "+str(LED_PIN)+"\r").encode("ascii"))
#%% Switch everything off
time.sleep(0.5)
LEDport.write(("ALL OFF\n").encode("ascii"))
#%% camera.set_exposure_time(12500)
LEDport.write(("CIRCLE 2 0xFFFFFF\n").encode("ascii"))
time.sleep(0.5)

#%% Capture using the camera

with Camera() as cam: # Initialize Camera
    # Set the area of interest (AOI) to the middle half
    #cam.Width = cam.SensorWidth // 2
    #cam.Height = cam.SensorHeight // 2
    #cam.OffsetX = 0 #cam.SensorWidth // 4
    #cam.OffsetY = 0#cam.SensorHeight // 4

    # If this is a color camera, get the image in RGB format.
    #if 'Bayer' in cam.PixelFormat:
       # cam.PixelFormat = 'RGB8'

    # To change the frame rate, we need to enable manual control
    #cam.AcquisitionFrameRateAuto = 'Off'
    #cam.AcquisitionFrameRateEnabled = True
    #cam.AcquisitionFrameRate = 20
    print(cam.PixelFormat)
    # To control the exposure settings, we need to turn off auto
    cam.GainAuto = 'Off'
    # Set the gain to 20 dB or the maximum of the camera.
    gain = min(20, cam.get_info('Gain')['max'])
    print("Setting gain to %.1f dB" % gain)
    cam.Gain = gain
    #cam.ExposureAuto = 'On'
    cam.ExposureTime = 5000  #croseconds

    # If we want an easily viewable image, turn on gamma correction.
    # NOTE: for scientific image processing, you probably want to
    #    _disable_ gamma correction!
    #try:
       # cam.GammaEnabled = True
       # cam.Gamma = 2.2
    #except:
        #print("Failed to change Gamma correction (not avaiable on some cameras).")

    cam.start() # Start recording
    imgs = [cam.get_array() for n in range(10)] # Get 10 frames
    cam.stop() # Stop recording
# Save image into a directory
# Make a directory to save some images
output_dir = 'C:\\Users\\COLD004\\Desktop\\Vinayak_Leukemia\\Codes\\test2'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

print("Saving images to: %s" % output_dir)

# Save them
# NOTE: images may be very dark or bright, depending on the camera lens and
#   room conditions!
#for n, img in enumerate(imgs):
Image.fromarray(imgs[-1]).save(os.path.join(output_dir, 'img3.tiff'))