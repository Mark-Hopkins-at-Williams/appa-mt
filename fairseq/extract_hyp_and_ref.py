
import sys

output_file = sys.argv[1]
ref_file = f'{sys.argv[1]}.ref'
hyp_file = f'{sys.argv[1]}.hyp'
src_file = f'{sys.argv[1]}.src'
with open(output_file) as reader:
    with open(ref_file, 'w') as refs:
        with open(hyp_file, 'w') as hyps:
            with open(src_file, 'w') as srcs:
                for line in reader:
                    line = line.strip()
                    fields = line.split()
                    if fields[0].startswith("T-"):
                        refs.write(f"{' '.join(fields[1:])}\n")
                    elif fields[0].startswith("D-"):
                        hyps.write(f"{' '.join(fields[2:])}\n")
                    elif fields[0].startswith("S-"):
                        srcs.write(f"{' '.join(fields[1:])}\n")