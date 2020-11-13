import sys
try:
    import sim

except Exception:
    print('\n[ERROR] It seems the sim.py OR simConst.py files are not found!')
    print('\n[WARNING] Make sure to have following files in the directory:')
    print(
        'sim.py, simConst.py and appropriate library - remoteApi.dll (if on Windows), remoteApi.so (if on Linux) or remoteApi.dylib (if on Mac).\n')
    sys.exit()

sim.simxFinish(-1)  # just in case, close all opened connections
client_id = sim.simxStart("127.0.0.1", 19997, True, True, 5000, 5)  # start aconnection
if client_id != -1:
    print("Connected to remote API server")
else:
    print("Not connected to remote API server")
sys.exit("Could not connect")