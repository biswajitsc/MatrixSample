import csv
import numpy as np
import matplotlib.pyplot as plt


def main():
    filename = 'ExpData_500.csv'
    data = []
    with open(filename, 'rb') as reader:
        csvread = csv.reader(reader)
        for line in csvread:
            data.append(line)
     
    for i in xrange(0, len(data)) :
        data[i] = map(float, data[i])

    data = np.array(data)

    x = data[:,4]
    y = data[:,8]
    yerr = data[:,9]

    plt.figure()
    plt.errorbar(x, y, yerr)
    plt.show()


if __name__ == __main__ :
    main()
     
