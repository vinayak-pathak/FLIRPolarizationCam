# FLIRPolarizationCam
FLIRCamOperation_Acquisition_and_Postprocessing
## Installation
- To install FLIRCam Python SDK Spinnaker visit https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73501875299.
- Create new conda environment using `conda create -n flircam python = 3.8` or `conda env create -n flircam --file=flircamenvironment.yml`
- Install the downloaded wheel by running `pip install C:\Users\path_to_downlpoad\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64.whl` skip if installed using .yml file
- Install simple-pyspin by running `pip install simple-pyspin` for instructions visit https://pypi.org/project/simple-pyspin/ skip if installed using .yml file
- Open `AcqusitionFinal.py` to capture the images using FLIR Blackfly USB BFS-U3-51S5PC-C, default acquisition pixel format is 'BayerRG8'
- Alternatively you can capture using SpinView, download .exe file from https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73503062578
- For post processing follow the algorithm stated in `Processing_code.m`. 
- For computer at COL COLDD04 the default environment is `flircam' to activate it write `conda activate flircam`

Presentations:

1. https://prodduke-my.sharepoint.com/:p:/g/personal/vp108_duke_edu/EY8OLI70TI9CvQmwhFNZS50B-9k65GQToIqJ6r9c0dZhHg?e=9nWoEd
2. https://prodduke-my.sharepoint.com/:p:/g/personal/vp108_duke_edu/EbvqbhKZYxZOrN6h2XbrCEMBbzvm3oIBS8chpwXN8EFdow?e=bhltGb





