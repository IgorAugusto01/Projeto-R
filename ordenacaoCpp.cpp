#include <Rcpp.h>
#include <vector>

using namespace Rcpp;

// BUBLESORT

// [[Rcpp::export]]
void bubbleSortCpp(std::vector<int> &vetor) {
    int n = vetor.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (vetor[j] > vetor[j + 1]) {
                std::swap(vetor[j], vetor[j + 1]);
            }
        }
    }
}

// QUICKSORT

int partition(std::vector<int>& vetor, int inicio, int fim) {
    int pivo = vetor[fim];
    int i = inicio - 1;

    for (int j = inicio; j < fim; j++) {
        if (vetor[j] < pivo) {
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

// [[Rcpp::export]]
std::vector<int> quickSortCpp(std::vector<int> vetor) {
    quickSort(vetor, 0, vetor.size() - 1);
    return vetor;
}

// MERGESORT

void merge(std::vector<int>& vetor, int l, int m, int r) {
    int n1 = m - l + 1;
    int n2 = r - m;

    std::vector<int> L(n1), R(n2);

    
    for (int i = 0; i < n1; i++) {
        L[i] = vetor[l + i];
    }
    for (int j = 0; j < n2; j++) {
        R[j] = vetor[m + 1 + j];
    }

    
    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            vetor[k] = L[i];
            i++;
        } else {
            vetor[k] = R[j];
            j++;
        }
        k++;
    }

    
    while (i < n1) {
        vetor[k] = L[i];
        i++;
        k++;
    }

  
    while (j < n2) {
        vetor[k] = R[j];
        j++;
        k++;
    }
}


void mergeSort(std::vector<int>& vetor, int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;

        mergeSort(vetor, l, m);
        mergeSort(vetor, m + 1, r);

        merge(vetor, l, m, r);
    }
}


// [[Rcpp::export]]
std::vector<int> mergeSortCpp(std::vector<int> vetor) {
    mergeSort(vetor, 0, vetor.size() - 1);
    return vetor;
}

