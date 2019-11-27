#!usr/bin/env python3
# -*- coding: utf-8 -*-

from os.path import abspath, dirname, join, normpath
from itertools import chain

src_path = dirname(abspath(__file__))
prj_path = join(src_path, '..')
prj_path = normpath(prj_path)
dat_path = join(prj_path, 'data')
dat_path = normpath(dat_path)
datfile_path = join(dat_path, 'voyna-i-mir-tom-1.txt')
datfile_path = normpath(datfile_path)

word_count = dict()

text_src = open(datfile_path, 'rt', encoding = 'windows-1251')

try:
    seq = map (str.split, text_src)
    seq = chain.from_iterable(seq)
    for word in seq:
        if word in word_count:
            word_count[word] += 1
        else:
            word_count[word] = 1

finally:
    text_src.close()

words_sorted = [ (c, w) for w, c in word_count.items()]
words_sorted.sort() 
words_sorted.reverse()

result_path = join(dat_path, 'freq.data')
result_file = open(result_path, 'wt', encoding = 'utf-8')
try:
    for count, word in words_sorted:
        print(word, count, file = result_file)
finally:
    result_file.close()