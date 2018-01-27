#!/usr/bin/env python

import sys
import re



def read_file(file):
    f = open(file)
    lines = f.readlines()
    f.close()
    return lines


def convert(lines):    
    s = ''
    for line in lines:
        line = re.sub('</p>', '\n', line)
        line = re.sub('<p>', '', line)
        line = re.sub('<br />', '', line)        
        line = re.sub('&#8230;', '...', line)
        line = re.sub('&#821[67];', "'", line)
        line = re.sub('&#822[01];', '"', line)
        line = re.sub('</?strong>', '**', line)
        line = re.sub('</?ul>', '\n', line)
        line = re.sub('<li>(.*)</li>', r'- \1', line)
        line = re.sub('<h2>(.*)</h2>', r'\n\n### \1\n', line)
        line = re.sub('<h3>(.*)</h3>', r'\n\n#### \1\n', line)
        line = re.sub('<code>([^<]*)</code>', r'`\1`', line)
        line = re.sub('https?://rayed.com/wordpress/wp-content', r'/static', line)
        s += line
    return s

def write_file(file, data):
    f = open(file, "wb")
    f.write(data)
    f.close()

def main():
    if len(sys.argv) < 2:
        print "Invalid usage: %s file1 [file2]" % (sys.argv[0])
        return 
    for file in sys.argv[1:]:
        lines = read_file(file)
        data = convert(lines)
        write_file(file, data)

if __name__ == '__main__':
    main()    