
import re, pprint

def read_file(file_name):
    """Return a list of the lines of a file."""
    f = open(file_name, 'r')
    file_lines = [line.rstrip("\n") for line in f.readlines()]
    f.close()
    return file_lines

def get_lines(file_name, lower_bound = None, upper_bound = None):
    """ Gets all of the lines between the regex lower bound and upper bound. """

    toReturn = []

    # Get the file
    f = open(file_name, 'r')
    file_lines = [line.rstrip("\n") for line in f.readlines()]
    f.close()

    if not lower_bound:
        accepting = True
    else:
        accepting = False
        pattern_low = re.compile(lower_bound, re.MULTILINE)

    if not upper_bound:
        upper_bound = 'THIS IS SOME CRAZY STRING THAT NOONE SHOULD EVER HAVE -- NARF!'

    pattern_high = re.compile(upper_bound, re.MULTILINE)

    for line in file_lines:
        if accepting:
            if pattern_high.search(line):
                return toReturn

            toReturn.append(line)
        else:
            if pattern_low.search(line):
                accepting = True

    return toReturn

index = 0
var_lines = get_lines('output', lower_bound = 'end_metric', upper_bound = 'begin_state')

num_vars = int(var_lines[index])
index += 1

def process_unreachable_facts_or_mutexes(vals):

    positive = True
    for val in vals:
    
        if "not(" in val:
            positive = False
        else:
            # Cannot have a mixture of positive and negative values
            # in a mutex currently.
            assert positive


    if len(vals) == 2:
        if '<none of those>' == vals[0]:
            assert not positive
            vals[0] = "%s" % vals[1]
        elif '<none of those>' == vals[1]:
            assert positive
            vals[1] = "not(%s)" % vals[0]


    if len(vals) > 2:
        print("ALERT! experimental code for mutex QACE handling")
        
        # Currently, none of those can only appear at idx 0 or the end.
        found = vals[0] == "<none of those>" or vals[len(vals) - 1]  == "<none of those>"
               
        if found:

            idx = 0 if vals[0] == "<none of those>" else len(vals) - 1
            vals[idx] = ""
            for i in range(len(vals)):
            
                if i == idx:
                    continue
            
                assert vals[i] != "<none of those>"
                if positive:
                
                    vals[idx] += "not(%s)/" % (vals[i])
                else:
                    vals[idx] += "%s/" % (vals[i])
                    
            vals[idx] = vals[idx][:-1]

    return vals

def parse_var(lines, index):

    assert 'begin_variable' == lines[index]
    index += 1

    name = lines[index]
    index += 1

    assert '-1' == lines[index]
    index += 1

    num_vals = int(lines[index])
    index += 1

    vals = []
    for i in range(num_vals):
        if 'NegatedAtom' == lines[index][:11]:
            vals.append("not(%s)" % lines[index].split('Atom ')[-1])
        else:
            vals.append(lines[index].split('Atom ')[-1])
        index += 1

    assert 'end_variable' == lines[index]
    index += 1

    vals = process_unreachable_facts_or_mutexes(vals)

    # if 2 == len(vals):
        # if '<none of those>' == vals[0]:
            # vals[0] = "!%s" % vals[1]
        # elif '<none of those>' == vals[1]:
            # vals[1] = "!%s" % vals[0]

    return (name, vals, index)


mapping = {}

for i in range(num_vars):
    (name, vals, index) = parse_var(var_lines, index)
    for j in range(len(vals)):
        mapping["%s:%s" % (name, j)] = vals[j]

print("Mapping:\n")
print('\n'.join(["  %s\t<-> \t %s" % (k,mapping[k]) for k in sorted(mapping.keys())]))
print()

def translate_lines(lines):
    for line in lines:
        if 'If' == line[:2]:
            print("If holds: %s" % '/'.join([mapping[item] for item in line.split(' ')[2:]]))
        else:
            print(line)

print("Policy:")
policy_lines = read_file('policy.out')
translate_lines(policy_lines)
print()

print("FSAP:")
fsap_lines = read_file('policy.fsap')
translate_lines(fsap_lines)
print()
