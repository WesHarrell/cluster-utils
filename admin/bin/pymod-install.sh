#!/bin/bash
#
module load engaging/python/2.7.11
module load sloan/py27-modules
#
pip2.7 install numpy --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install pandas --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install matplotlib --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install scipy --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install mpmath --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install csvkit --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install prettyplotlib --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install plotly --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install ggplot --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install Bokeh --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install PyMC --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install Scikit-learn --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install SymPy --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install Statsmodels --target=/home/software/sloan/local/lib/py27 --upgrade
pip2.7 install jupyter-core --target=/home/software/sloan/local/lib/py27 --upgrade

