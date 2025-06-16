#!/bin/bash

# Função de ajuda
usage() {
    echo "Uso: $0 -l [c|python] -a [bubble|merge] -n [n_execucoes] -t [tamanho_entrada]"
    exit 1
}

# Leitura dos parâmetros
while getopts ":l:a:n:t:" opt; do
  case $opt in
    l) linguagem="$OPTARG" ;;
    a) algoritmo="$OPTARG" ;;
    n) execucoes="$OPTARG" ;;
    t) tamanho="$OPTARG" ;;
    \?) echo "Opção inválida: -$OPTARG" >&2; usage ;;
    :) echo "Opção -$OPTARG requer um argumento." >&2; usage ;;
  esac
done

# Verifica se todos os parâmetros foram passados
if [[ -z "$linguagem" || -z "$algoritmo" || -z "$execucoes" || -z "$tamanho" ]]; then
    usage
fi

# Define o nome do algoritmo formatado
if [ "$algoritmo" = "merge" ]; then
    nome_algoritmo="Merge Sort"
elif [ "$algoritmo" = "bubble" ]; then
    nome_algoritmo="Bubble Sort"
else
    nome_algoritmo="${algoritmo^}"
fi

# Arquivo CSV onde serão salvos os dados
saida_csv="tempos.csv"

# Se não existir, cria com cabeçalho
if [ ! -f "$saida_csv" ]; then
    echo "Algoritmo,Tamanho,Tempo,Linguagem" > "$saida_csv"
fi

# Variável para somar tempos
soma=0

# Loop de execuções
for ((i=1; i<=execucoes; i++)); do
    if [ "$linguagem" = "python" ]; then
        saida=$(python3 ${algoritmo}.py $tamanho)
    elif [ "$linguagem" = "c" ]; then
        ./a.out $tamanho > .temp_saida
        saida=$(cat .temp_saida)
    else
        echo "Linguagem inválida: $linguagem"
        exit 1
    fi

    # Extrai apenas o tempo da saída
    tempo=$(echo "$saida" | cut -d';' -f2 | tr -d ';')

    # Salva no CSV com vírgula como separador
    echo "$nome_algoritmo,$tamanho,$tempo,${linguagem^}" >> "$saida_csv"

    # Soma para média
    soma=$(echo "$soma + $tempo" | bc -l)
done

# Calcula média
media=$(echo "$soma / $execucoes" | bc -l)

# Mostra resultado no terminal
echo "Tamanho: $tamanho | Execuções: $execucoes | Tempo médio: $media s"

# Gera o gráfico
gnuplot grafico.gnuplot

echo "Gráfico atualizado: grafico.png"
