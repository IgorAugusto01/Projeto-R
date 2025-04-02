import java.util.Arrays;

public class ordenacaoJava {

    //BUBBLESORT
    public static int[] bubbleSortJava(int[] vetor) {
        int n = vetor.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (vetor[j] > vetor[j + 1]) {
                    int temp = vetor[j];
                    vetor[j] = vetor[j + 1];
                    vetor[j + 1] = temp;
                }
            }
        }
        return vetor;
    }

    //QUICKSORT
    public static int[] quickSortJava(int[] vetor) {
        quickSort(vetor, 0, vetor.length - 1);
        return vetor;
    }

    private static void quickSort(int[] vetor, int inicio, int fim) {
        if (inicio < fim) {
            int pi = partition(vetor, inicio, fim);
            quickSort(vetor, inicio, pi - 1);
            quickSort(vetor, pi + 1, fim);
        }
    }

    private static int partition(int[] vetor, int inicio, int fim) {
        int pivo = vetor[fim];
        int i = inicio - 1;
        for (int j = inicio; j < fim; j++) {
            if (vetor[j] < pivo) {
                i++;
                int temp = vetor[i];
                vetor[i] = vetor[j];
                vetor[j] = temp;
            }
        }
        int temp = vetor[i + 1];
        vetor[i + 1] = vetor[fim];
        vetor[fim] = temp;
        return i + 1;
    }

    //MERGESORT
    public static int[] mergeSortJava(int[] vetor) {
        if (vetor.length <= 1) {
            return vetor;
        }
        int meio = vetor.length / 2;
        int[] esq = Arrays.copyOfRange(vetor, 0, meio);
        int[] dir = Arrays.copyOfRange(vetor, meio, vetor.length);

        mergeSortJava(esq);
        mergeSortJava(dir);

        merge(vetor, esq, dir);
        return vetor;
    }

    private static void merge(int[] vetor, int[] esq, int[] dir) {
        int i = 0, j = 0, k = 0;
        while (i < esq.length && j < dir.length) {
            if (esq[i] <= dir[j]) {
                vetor[k++] = esq[i++];
            } else {
                vetor[k++] = dir[j++];
            }
        }
        while (i < esq.length) {
            vetor[k++] = esq[i++];
        }
        while (j < dir.length) {
            vetor[k++] = dir[j++];
        }
    }
}