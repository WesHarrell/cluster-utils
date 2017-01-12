#!/bin/bash
#
#
# CFLAGS required to build some modules, eg cffi, which is a requirement for scrapy
export CFLAGS="-I/home/software/sloan/local/lib/libffi-3.2.1/include -L/home/software/sloan/local/lib64"
#
module load engaging/python/2.7.10+ucs4
module load sloan/python/2.7-ucs4-modules
#
pip2.7 install numpy --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install pandas --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install matplotlib --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install scipy --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install mpmath --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install csvkit --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install prettyplotlib --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install plotly --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install ggplot --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install Bokeh --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install PyMC --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install Scikit-learn --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install Scikit-image --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install SymPy --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install Statsmodels --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install jupyter-core --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install Scrapy --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install networkx --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install tensorflow --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade
pip2.7 install selenium --target=/home/software/sloan/local/lib/py27-ucs4 --upgrade

