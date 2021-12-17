# FLIRPolarizationCam
FLIRCamOperation_Acquisition_and_Postprocessing
## Installation
- To install FLIRCam Python SDK Spinnaker visit https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73501875299.
- Create new conda environment using `conda create -n flircam python = 3.8` or `conda env create -n flircam --file=flircamenvironment.yml`
- Install the downloaded wheel by running `pip install C:\Users\path_to_downlpoad\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64.whl` skip if installed using .yml file
- Install simple-pyspin by running `pip install simple-pyspin` for instructions visit https://pypi.org/project/simple-pyspin/ skip if installed using .yml file
- Open `AcqusitionFinal.py` to capture the images using FLIR Blackfly USB BFS-U3-51S5PC-C, default acquisition format is 'BayerRG8'
- Alternatively you can capture using SpinView, download .exe file from https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73503062578
- For post processing follow the algorithm stated in `Processing.m`. 

