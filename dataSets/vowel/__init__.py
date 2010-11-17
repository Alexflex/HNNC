# -*- coding: utf-8 -*-

#@hide
import numpy as np

"""
.. _vowel-dataset:

*****
Vowel
*****

This data set is for speaker independent recognition of the eleven steady state
vowels of British English using a specified training set of lpc derived log area
ratios. The data is divided into a training set ("vowel.train", 528
instances) and a testing set ("vowel.test", 462 instances). Each instance has
10 features.

The file is in a comma-separated CSV format. The first line is the headers. The
first column is the line number. The second is the class. ::

    row.names,y,x.1,x.2,x.3,x.4,x.5,x.6,x.7,x.8,x.9,x.10
    1,1,-3.639,0.418,-0.67,1.779,-0.168,1.627,-0.388,0.529,-0.874,-0.814
    2,2,-3.327,0.496,-0.694,1.365,-0.265,1.933,-0.363,0.51,-0.621,-0.488
    3,3,-2.12,0.894,-1.576,0.147,-0.707,1.559,-0.579,0.676,-0.809,-0.049
    4,4,-2.287,1.809,-1.498,1.012,-1.053,1.06,-0.567,0.235,-0.091,-0.795
    5,5,-2.598,1.938,-0.846,1.062,-1.633,0.764,0.394,-0.15,0.277,-0.396
    [...]
    528,11,-4.261,1.827,-0.482,-0.194,0.731,0.354,-0.478,0.05,-0.112,0.321

The **read_data** function reads a data file and outputs a NxK matrix :math:`X
= (\overrightarrow{x}_1, \dots, \overrightarrow{x}_N)` (rows are samples,
columns are features) and a N-vector of the corresponding vowel labels :math:`Y
= (y_1, \dots, y_N)`. ::
"""
def read_data(filename):
    XY = np.loadtxt(filename, dtype=np.double, delimiter=",", skiprows=1)
    X = XY[:, 2:]
    Y = XY[:, 1].astype(int)
    return X, Y