import sys;
from array import array
import random;
import time;
import string;
import os.path ## para verificar se existe o arquivo

def mergesort(lista):
    tamanho_da_lista = len(lista) - 1

    for posicao_atual in range(0, tamanho_da_lista):
        posicao_menor = posicao_atual
        menor_nome = lista[posicao_menor]

        for posicao_busca in range(posicao_atual, tamanho_da_lista):
            nome_busca = lista[posicao_busca + 1]

            if menor_nome > nome_busca:
                menor_nome = nome_busca
                posicao_menor = posicao_busca + 1

        if posicao_menor != posicao_atual:
            menor_nome = lista[posicao_menor]
            lista[posicao_menor] = lista[posicao_atual]
            lista[posicao_atual] = menor_nome

    return lista

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
mergesort(alist)
tempo_final=time.time()# em segundos
print(f"Merge Sort;{valor};{tempo_final - tempo_inicial};Python")
#print(alist)
