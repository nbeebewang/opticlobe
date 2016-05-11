import numpy as np
import re
from matplotlib import pyplot as pltimport 
import sys 
import os
sys.setrecursionlimit(4000000)
import h5py
import time

# SPECIFY WANTED CHROMOSOMES
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





# CREATE ANNOTATIONS FILE FOR EACH CHROMOSOME SPECIFIED IN MAJOR CHROMS

startTime = time.time()

if not os.path.exists('h5py_compressed/dm6_annotations'): 
    os.makedirs('h5py_compressed/dm6_annotations')


chrom_counter = 0
for chrom in chroms_len:
    print chrom_counter, chrom
    
    chrom_an_dict = {}
    
    # create new h5py file for each chrom
    filename = chrom + '.h5'
    filepath = ('h5py_compressed/dm6_annotations/' + filename)
    h5f = h5py.File(filepath, 'w')
    
    for i in range(chroms_len[chrom]):
        chrom_an_dict[i] = []    
    
    f_ref_ann = open('dm6_Ensembl.gtf', 'r')
    counter = 0
    reached = False
    for i in f_ref_ann:
        line_array = i.split("\t")
        chrom_line = line_array[0]
        if chrom == chrom_line:
            reached = True
        if chrom != chrom_line:
            if not reached:
                continue
            else:
                break
        seg_type = line_array[2]
        start = int(line_array[3])
        stop = int(line_array[4])
        gene_id_string = line_array[8]
        split_gene_id_string = re.split('\"', gene_id_string)
        gene_id = split_gene_id_string[1]

            
        # Note that gtf files are 1 indexed whereas our reads are 0 indexed
        for i in range(start-1, stop):
            chrom_an_dict[i].append((seg_type,gene_id))


        if counter % 1000 == 0:
            print counter
        counter += 1
    
    for key in chrom_an_dict:
        h5f.create_dataset(str(key), data=chrom_an_dict[key])
    h5f.close()

    print "CHROM " + chrom + " COMPLETED" 
    chrom_counter += 1



elapsedTime = time.time() - startTime
print elapsedTime