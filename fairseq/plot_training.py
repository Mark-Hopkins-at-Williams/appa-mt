import sys
import matplotlib.pyplot as plt

def plot_bleu(outfile):
    with open(outfile) as reader:
        xvals = []
        yvals = []
        counter = 1
        for line in reader:
            line = line.strip()
            if "best_bleu" in line:                
                fields = line.split("best_bleu")
                bleu = float(fields[1])
                xvals.append(counter)
                counter += 1
                yvals.append(bleu)
    plt.plot(xvals, yvals)    
    print(yvals)
    plt.show()    

if __name__ == '__main__':
    plot_bleu(sys.argv[1])