import numpy as np
import re
from matplotlib import pyplot as plt 
import sys 
sys.setrecursionlimit(4000000)
import h5py

major_chroms = ['chr2R', 'chr2L', 'chr3L', 'chr3R', 'chr4', 'chrX', 'chrY']

# CREATES DICTIONARY CHROMES_LEN WHICH CONTAINS CHROMOSOME NAMES AS KEYS AND LENGTH AS VALUES
f_ref = open('dm6.fa', 'r')
chroms_len = {}
current_chrom = ''
for i in f_ref:
    if '>chr' in i:
        if i not in chroms_len:
            #remove '>' and newline character from dictionary key 
            newchrom =i.translate(None, '> \n')
            if newchrom in major_chroms:
                # add new chromosome to dictionary, initialize length to 0
                chroms_len[newchrom] = 0
                print 'new chrom added:', newchrom
                current_chrom = newchrom
    else:
        if newchrom in major_chroms:
            chroms_len[newchrom] += (len(i) - 1)  # \n character needs to be removed from count


# CREATES DICT OF CHROMS -- EACH VALUE IS AN ARRAY OF READS
chroms = {}
for chrom in chroms_len:
    chroms[chrom] = np.zeros(chroms_len[chrom])

# Open transcript sam file    
f = open('150415_SN651_0372_AH3N2YBCXX__Sample_H_L_M1_1Aligned.sortedByCoord.out.sam', 'r')

# Add each read from sam file to the chroms arrays
counter = 0
thrown_out = 0
for i in f:
    if not '@' in i:
        line_array = i.split("\t")
        mapped_chrom = line_array[2]
        if mapped_chrom in chroms_len: 
            start = int(line_array[3])
            read_len = len(line_array[9])
            end = start + read_len - 1
            if counter % 100000 == 0:
                print counter, mapped_chrom, start, end, read_len
            if end > chroms_len[mapped_chrom]-1:
                thrown_out += 1
            else: 
                for position in range(start-1, end):
                    chroms[mapped_chrom][position] += 1
    counter += 1


# WRITE READS TO FILE

for key in chroms:
    h5f = h5py.File('h5py_compressed/reads_sampledata_' + key + '.h5', 'w')
    h5f.create_dataset('reads', data=chroms[key])
    h5f.close()

