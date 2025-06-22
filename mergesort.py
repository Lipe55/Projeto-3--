import sys
from array import array
import random
import time

def mergesort(arr, inicio, fim):
    if inicio < fim:
        meio = (inicio + fim) // 2
        mergesort(arr, inicio, meio)
        mergesort(arr, meio + 1, fim)
        merge(arr, inicio, meio, fim)

def merge(arr, inicio, meio, fim):
    esquerda = arr[inicio:meio + 1]
    direita = arr[meio + 1:fim + 1]

    i = j = 0
    k = inicio

    while i < len(esquerda) and j < len(direita):
        if esquerda[i] <= direita[j]:
            arr[k] = esquerda[i]
            i += 1
        else:
            arr[k] = direita[j]
            j += 1
        k += 1

    while i < len(esquerda):
        arr[k] = esquerda[i]
        i += 1
        k += 1

    while j < len(direita):
        arr[k] = direita[j]
        j += 1
        k += 1

#------------------------Main
parameters = []
for param in sys.argv:
    parameters.append(param)

if len(parameters) > 1:
    valor = int(parameters[1])
else:
    print("Digitado " + str(len(parameters)) + " parâmetros, é preciso 2.")
    print("ERRO nos parâmetros: python mergesort.py [numero_de_entradas]")
    print("EXEMPLO: python mergesort.py 200")
    exit()

# Gera array de inteiros com valores aleatórios
alist = array('i', [random.randrange(0, valor) for _ in range(valor)])

tempo_inicial = time.time()
mergesort(alist, 0, len(alist) - 1)
tempo_final = time.time()

print(f"{valor},{valor},{tempo_final - tempo_inicial},")

# print(alist)  # Descomente para imprimir a lista ordenada
