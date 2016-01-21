import nanorv32_impl as nrv
import pprint as pp

# from http://stackoverflow.com/questions/7204805/dictionaries-of-dictionaries-merge/7205107#7205107
def merge_dict(a, b, path=None):
    "merges b into a"
    if path is None: path = []
    for key in b:
        if key in a:
            if isinstance(a[key], dict) and isinstance(b[key], dict):
                merge_dict(a[key], b[key], path + [str(key)])
            elif a[key] == b[key]:
                pass # same leaf value
            else:
                raise Exception('Conflict at %s' % '.'.join(path + [str(key)]))
        else:
            a[key] = b[key]
    return a


d1 = nrv.spec['nanorv32']['rv32i']['impl']['inst_type']['R-type']
print "="*80
pp.pprint(d1)
d2 = nrv.spec['nanorv32']['rv32i']['impl']['inst']['add']
print "="*80
pp.pprint(d2)

d3 = d1.copy()
merge_dict(d3,d2)

print "="*80
pp.pprint(d3)
