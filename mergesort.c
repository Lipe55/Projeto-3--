#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void merge(int arr[], int left[], int right[], int left_len, int right_len);

void merge_sort(int arr[], int len);

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s <tamanho do array>\n", argv[0]);
        return 1;
    }

    int tamanho = atoi(argv[1]);
    if (tamanho <= 0) {
        printf("Tamanho inválido.\n");
        return 1;
    }

    int *arr = (int *)malloc(tamanho * sizeof(int));
    if (arr == NULL) {
        printf("Erro ao alocar memória.\n");
        return 1;
    }

    srand(time(NULL)); // Inicializa a semente para números aleatórios

//    printf("Array antes da ordenação:\n");
    for (int i = 0; i < tamanho; i++) {
        arr[i] = rand() % tamanho; // Gera números aleatórios entre 0 e 99
//        printf("%d ", arr[i]);
    }

    clock_t start_time = clock();
    merge_sort(arr, tamanho);
    clock_t end_time = clock();

    double total_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

/*    printf("\nArray ordenado:\n");
    for (int i = 0; i < tamanho; i++) {
        printf("%d ", arr[i]);
    }

    printf("\nTempo de execução: %.6f segundos\n", total_time);
*/
    printf("Merge Sort,%d,%f,C\n", tamanho, total_time);

    free(arr); // Libera a memória alocada para o array

    return 0;
}



void merge(int arr[], int left[], int right[], int left_len, int right_len) {
    int i = 0, j = 0, k = 0;

    while (i < left_len && j < right_len) {
        if (left[i] < right[j]) {
            arr[k] = left[i];
            i++;
        } else {
            arr[k] = right[j];
            j++;
        }
        k++;
    }

    while (i < left_len) {
        arr[k] = left[i];
        i++;
        k++;
    }

    while (j < right_len) {
        arr[k] = right[j];
        j++;
        k++;
    }
}

void merge_sort(int arr[], int len) {
    if (len < 2) {
        return;
    }

    int mid = len / 2;
    int left[mid];
    int right[len - mid];

    for (int i = 0; i < mid; i++) {
        left[i] = arr[i];
    }
    for (int i = mid; i < len; i++) {
        right[i - mid] = arr[i];
    }

    merge_sort(left, mid);
    merge_sort(right, len - mid);
    merge(arr, left, right, mid, len - mid);
}
