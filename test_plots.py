import numpy as np
import re
from matplotlib import pyplot as plt

import sys 
sys.setrecursionlimit(4000000)

import pickle



# with open('dm6_annotations/chr4.pickle', 'rb') as handle:
#   annos = pickle.load(handle)

# print annos[891]

with open('CHROMS_reads.pickle', 'rb') as handle:
    chroms = pickle.load(handle)

length = len(chroms['chr2L'])
plt.plot(chroms['chr2L'][40000:50000])
plt.show()


# Very rudimentary graph of reads from location 5000 to 8000
# plt.plot(chroms['chr2L'][0:chroms_len['chr2L']])

