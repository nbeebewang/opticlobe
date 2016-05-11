import numpy as np
import re
from matplotlib import pyplot as pltimport 
import sys 
import os
sys.setrecursionlimit(400000)
import cPickle as pickle
import time


# CREATES DICTIONARY CHROMES_LEN WHICH CONTAINS CHROMOSOME NAMES AS KEYS AND LENGTH AS VALUES
print 'Creating dict of chroms_len'
f_ref = open('dm6.fa', 'r')
chroms_len = {}
current_chrom = ''
for i in f_ref:
    if '>chr' in i:
        if i not in chroms_len:
            #remove '>' and newline character from dictionary key 
            newchrom = i.translate(None, '> \n')
            
            # add new chromosome to dictionary, initialize length to 0
            chroms_len[newchrom] = 0
            # print 'new chrom added:', newchrom
            current_chrom = newchrom
    else:
        # add length of line to most recently added chromosome's length
        chroms_len[current_chrom] += (len(i) - 1)  # \n character needs to be removed from count
print 'chroms_len complete'




# CREATE DICTIONARY OF CHROMOSOMES WHERE EACH CHROMOSOME IS A DICT OF KEY-INDICES VALUE-SET OF ANNOTATION STUFF

startTime = time.time()

if not os.path.exists('dm6_annotations'): 
    os.makedirs('dm6_annotations')

chrom_counter = 0
for chrom in chroms_len:
    print '# chrom:', chrom_counter, '\t Name:', chrom
    
    chrom_an_dict = {}
    for i in range(chroms_len[chrom]):
        chrom_an_dict[i] = []
    print len(chrom_an_dict)
    
    f_ref_ann = open('dm6_Ensembl.gtf', 'r')
    counter = 0
    for i in f_ref_ann:
        line_array = i.split("\t")
        chrom_line = line_array[0]
        if chrom != chrom_line:
            continue 
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
            print 'on line', counter, 'of ensembl file'
        counter += 1
    
    filename = chrom + '.pickle'
    filepath = ('dm6_annotations/' + filename)

    print 'creating', filepath

    with open(filepath, 'wb') as handle:
      pickle.dump(chrom_an_dict, handle)

    print filepath, 'created'

    
    
    chrom_counter += 1


elapsedTime = time.time() - startTime
print 'TIMING:', elapsedTime