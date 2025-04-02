#BUBBLESORT
def bubbleSortPython(vetor):
    n = len(vetor)
    for i in range(n):
        trocado = False
        for j in range(n - i - 1):
            if vetor[j] > vetor[j + 1]:
                vetor[j], vetor[j + 1] = vetor[j + 1], vetor[j]  
                trocado = True
        if not trocado:
            break  
    return vetor


#QUICKSORT
def quickSortPython(vetor):
    if len(vetor) <= 1:
        return vetor 
    else:
        pivo = vetor[len(vetor) // 2] 
        esq = [x for x in vetor if x < pivo]  
        meio = [x for x in vetor if x == pivo]  
        dir = [x for x in vetor if x > pivo] 
        return quickSortPython(esq) + meio + quickSortPython(dir) 


#MERGESORT
def mergeSortPython(vetor):
    if len(vetor) <= 1:
        return vetor  

    meio = len(vetor) // 2
    esq = mergeSortPython(vetor[:meio])  
    dir = mergeSortPython(vetor[meio:])  

    return merge(esq, dir)  

def merge(esq, dir):
    if not isinstance(esq, list):
        esq = [esq]
    if not isinstance(dir, list):
        dir = [dir]

    vetorOrdenado = []
    i = j = 0

    while i < len(esq) and j < len(dir):
        if esq[i] < dir[j]:
            vetorOrdenado.append(esq[i])
            i += 1
        else:
            vetorOrdenado.append(dir[j])
            j += 1

    vetorOrdenado.extend(esq[i:])
    vetorOrdenado.extend(dir[j:])
    
    return vetorOrdenado
