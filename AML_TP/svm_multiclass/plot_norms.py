from matplotlib import pyplot as plt
import csv
from collections import defaultdict

columns = defaultdict(list)

with open('Experiments_Data_Norm.csv') as f:
    reader = csv.DictReader(f) # read rows into a dictionary format
    for row in reader: # read a row as {column1: value1, column2: value2,...}
        for (k,v) in row.items(): # go over each column name and value 
            columns[k].append(v) # append the value into the appropriate list
                                 # based on column name k

for key in columns.keys() :
	columns[key] = map(float, columns[key])

columns['D'] = columns[' D ']
columns['N'] = columns['N  ']

# fix N to 100
N = [100,200,300,400]
for n in N :
	data = defaultdict(list)
	ind = [i for (i,x) in enumerate(columns['N']) if x==n]
	for key in columns.keys() :
		data[key] = [columns[key][i] for i in ind]
	plt.figure()
	plt.plot(data['D'], data['M_CW'],'r',label='CW')
	plt.plot(data['D'], data['M_NT'],'g',label='NT')
	# plt.plot(data['D'], data['M_LS'],'b',label='LS')
	plt.plot(data['D'], data['M_PCA'],'k',label='PCA')
	plt.legend()
	plt.savefig('norm_mean_error_N_'+str(n)+'.pdf')
	plt.close()

D = [400, 600, 800, 1000]
for d in D :
	data = defaultdict(list)
	ind = [i for (i,x) in enumerate(columns['D']) if x==d]
	for key in columns.keys() :
		data[key] = [columns[key][i] for i in ind]
	plt.figure()
	plt.plot(data['N'], data['M_CW'],'r',label='CW')
	plt.plot(data['N'], data['M_NT'],'g',label='NT')
	# plt.plot(data['N'], data['M_LS'],'b',label='LS')
	plt.plot(data['N'], data['M_PCA'],'k',label='PCA')
	plt.legend()	
	plt.savefig('norm_mean_error_D_'+str(d)+'.pdf')
	plt.close()


N = [100,200,300,400]
for n in N :
	data = defaultdict(list)
	ind = [i for (i,x) in enumerate(columns['N']) if x==n]
	for key in columns.keys() :
		data[key] = [columns[key][i] for i in ind]
	plt.figure()
	plt.plot(data['D'], data['V_CW'],'r',label='CW')
	plt.plot(data['D'], data['V_NT'],'g',label='NT')
	# plt.plot(data['D'], data['V_LS'],'b',label='LS')
	plt.plot(data['D'], data['V_PCA'],'k',label='PCA')
	plt.legend()	
	plt.savefig('norm_variance_N_'+str(n)+'.pdf')
	plt.close()


D = [400, 600, 800, 1000]
for d in D :
	data = defaultdict(list)
	ind = [i for (i,x) in enumerate(columns['D']) if x==d]
	for key in columns.keys() :
		data[key] = [columns[key][i] for i in ind]
	plt.figure()
	plt.plot(data['N'], data['V_CW'],'r',label='CW')
	plt.plot(data['N'], data['V_NT'],'g',label='NT')
	# plt.plot(data['N'], data['V_LS'],'b',label='LS')
	plt.plot(data['N'], data['V_PCA'],'k',label='PCA')	
	plt.legend()
	plt.savefig('norm_variance_D_'+str(d)+'.pdf')
	plt.close()