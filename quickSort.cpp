#include <Rcpp.h>
#include <vector>
using namespace Rcpp;


int partition(std::vector<int>& vetor, int inicio, int fim) {
    int pivot = vetor[fim];
    int i = inicio - 1;

    for (int j = inicio; j < fim; j++) {
        if (vetor[j] < pivot) {
            i++;
            std::swap(vetor[i], vetor[j]);
        }
    }
    std::swap(vetor[i + 1], vetor[fim]);
    return i + 1;
}


void quickSort(std::vector<int>& vetor, int inicio, int fim) {
    if (inicio < fim) {
        int pi = partition(vetor, inicio, fim);

        quickSort(vetor, inicio, pi - 1);
        quickSort(vetor, pi + 1, fim);
    }
}


std::vector<int> quick_sort(std::vector<int> vetor) {
    quickSort(vetor, 0, vetor.size() - 1);
    return vetor;
}