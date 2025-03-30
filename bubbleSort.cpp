#include <Rcpp.h>
using namespace Rcpp;


void bubbleSort(std::vector<int> &vetor) {
    int n = vetor.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (vetor[j] > vetor[j + 1]) {
                std::swap(vetor[j], vetor[j + 1]);
            }
        }
    }
}