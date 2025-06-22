import sys;
from array import array
import random;
import time;
import string;
import os.path ## para verificar se existe o arquivo

def bubbleSort(alist):
    for passnum in range(len(alist)-1,0,-1):
        for i in range(passnum):
            if alist[i]>alist[i+1]:
                temp = alist[i]
                alist[i] = alist[i+1]
                alist[i+1] = temp
                
#------------------------Main
parameters = [];
for param in sys.argv:
	parameters.append(param)
#print (parameters)	
if (len(parameters)) > 1:
	valor 	= int(parameters[1]) 	#---numero de elementos do vetor
else:
	print ("Digitado "+str(len(parameters))+" parametros, é preciso 2 ")
	print ("ERROR nos parametros: python merge.py [numero_de_entradas]")
	print ("EXEMPLO python merge.py 200")
	exit()
##----------------------------------------------------------------------
i=0
alist = []
for i in range (valor):
	alist.append(random.randrange(0,valor))	
	i=i+1
tempo_inicial = time.time() # em segundos
bubbleSort(alist)
tempo_final=time.time()# em segundos
print(f"Bubblesort,{valor},{tempo_final - tempo_inicial},Python")
#print(alist)
