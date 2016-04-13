#!/usr/bin/env python

from xml.etree import ElementTree as ET
import pprint as pp
import argparse
from collections import defaultdict

# From http://stackoverflow.com/questions/2148119/how-to-convert-an-xml-string-to-a-dictionary-in-python/10077069#10077069
def etree_to_dict(t):
    d = {t.tag: {} if t.attrib else None}
    children = list(t)
    if children:
        dd = defaultdict(list)
        for dc in map(etree_to_dict, children):
            for k, v in dc.iteritems():
                dd[k].append(v)
        d = {t.tag: {k:v[0] if len(v) == 1 else v for k, v in dd.iteritems()}}
    if t.attrib:
        d[t.tag].update(('@' + k, v) for k, v in t.attrib.iteritems())
    if t.text:
        text = t.text.strip()
        if children or t.attrib:
            if text:
              d[t.tag]['#text'] = text
        else:
            d[t.tag] = text
    return d


def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
Help converting Keil project to a runtest.py compatible file
                   """)
    parser.add_argument('--keil', action='store', dest='keil',
                        help='Keil project file')


    parser.add_argument('-v', '--verbosity', action="count", help='Increase output verbosity')



    parser.add_argument('--version', action='version', version='%(prog)s 0.1')

    return parser.parse_args()


if __name__ == '__main__':
    args = get_args()
    e = ET.parse(args.keil)

    keilproj = etree_to_dict(e.getroot())
    # pp.pprint(keilproj)
    group_array = keilproj['Project']['Targets']['Target']['Groups']['Group']
    for g in  group_array:
        print "="*80

        group_name = g['GroupName']
        pp.pprint(group_name)
        files = g['Files']['File']
        pp.pprint(files)
