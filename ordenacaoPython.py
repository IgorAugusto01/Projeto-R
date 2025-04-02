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
        return vetor  # Retorna o vetor diretamente se ele tiver 0 ou 1 elemento (já está ordenado)

    meio = len(vetor) // 2
    esq = mergeSortPython(vetor[:meio])  # Divide e ordena a metade esquerda
    dir = mergeSortPython(vetor[meio:])  # Divide e ordena a metade direita

    return merge(esq, dir)  # Combina as duas metades ordenadas

def merge(esq, dir):
    # Certifique-se de que 'esq' e 'dir' são listas
    if not isinstance(esq, list):
        esq = [esq]
    if not isinstance(dir, list):
        dir = [dir]

    vetorOrdenado = []
    i = j = 0

    # Combina as duas listas ordenadas
    while i < len(esq) and j < len(dir):
        if esq[i] < dir[j]:
            vetorOrdenado.append(esq[i])
            i += 1
        else:
            vetorOrdenado.append(dir[j])
            j += 1

    # Adiciona os elementos restantes
    vetorOrdenado.extend(esq[i:])
    vetorOrdenado.extend(dir[j:])
    
    return vetorOrdenado
