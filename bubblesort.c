#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void bubble_sort(int arr[], int len);

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
//       printf("%d ", arr[i]);
    }

    clock_t start_time = clock();
    bubble_sort(arr, tamanho);
    clock_t end_time = clock();

    double total_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

/*    printf("\nArray ordenado:\n");
    for (int i = 0; i < tamanho; i++) {
        printf("%d ", arr[i]);
    }

    printf("\nTempo de execução: %.6f segundos\n", total_time);
*/
    printf("%d,%d,%f,\n", tamanho, tamanho, total_time);

    free(arr); // Libera a memória alocada para o array

    return 0;
}

void bubble_sort(int arr[], int len) {
    for (int i = 0; i < len - 1; i++) {
        for (int j = 0; j < len - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                // Troca os elementos se estiverem fora de ordem
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
