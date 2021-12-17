# FLIRPolarizationCam
FLIRCamOperation_Acquisition_and_Postprocessing
## Installation
[a)] To install FLIRCam Python SDK Spinnaker visit https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73501875299.
[b)] create new conda environment using `conda create -n flircam`
[c)] Install the downloaded wheel by running `pip install C:\Users\path_to_downlpoad\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64\spinnaker_python-2.5.0.80-cp38-cp38-win_amd64.whl`
[d)] install simple-pyspin by running `pip install simple-pyspin` for instructions visit https://pypi.org/project/simple-pyspin/
[e)] Open Acqusition.py to capture the images using FLIR Blackfly USB BFS-U3-51S5PC-C, default acquisition format is 'BayerRG8'
[e] Alternatively you can capture using SpinView, download .exe file from https://flir.app.boxcn.net/v/SpinnakerSDK/folder/73503062578
[d] For post processing follow the algorithm stated in 'Processing.m'. 

