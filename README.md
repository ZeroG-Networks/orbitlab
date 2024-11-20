# Orbitlab - Dockerized Jupyterlab for Orbit Analysis

Build docker image and run on port 8888:

```
docker build -t orbitlab .
docker run -d -p 8888:8888 --name=my_orbitlab orbitlab
```

Test by connecting a web-browser to port 8888, and running e.g.:

```
import orekit
vm = orekit.initVM()
print('Java version:', vm.java_version)
print('Orekit version:', orekit.VERSION)

from orekit.pyhelpers import setup_orekit_curdir
setup_orekit_curdir()
from org.orekit.utils import Constants
print("Earth radius:", Constants.WGS84_EARTH_EQUATORIAL_RADIUS)
```
