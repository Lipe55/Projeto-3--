#!/bin/bash

usage() {
    echo "Uso: $0 -l [c|python] -a [bubble|merge] -n [n_execucoes] -t [tamanho_entrada]"
    exit 1
}

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

if [[ -z "$linguagem" || -z "$algoritmo" || -z "$execucoes" || -z "$tamanho" ]]; then
    usage
fi


if [ "$algoritmo" = "merge" ]; then
    nome_algoritmo="Merge Sort"
    base_algoritmo="mergesort"
elif [ "$algoritmo" = "bubble" ]; then
    nome_algoritmo="Bubble Sort"
    base_algoritmo="bubblesort"
else
    nome_algoritmo="${algoritmo^}"
    base_algoritmo="${algoritmo,,}"
fi

saida_csv="tempos.csv"
[ ! -f "$saida_csv" ] && echo "Algoritmo,Tamanho,Tempo,Linguagem" > "$saida_csv"

soma=0

for ((i=1; i<=execucoes; i++)); do
    if [ "$linguagem" = "python" ]; then
        saida=$(python3 ${base_algoritmo}.py $tamanho)
        tempo=$(echo "$saida" | cut -d',' -f3)
    elif [ "$linguagem" = "c" ]; then
        ./a.out $tamanho > .temp_saida
        saida=$(cat .temp_saida)
        tempo=$(echo "$saida" | cut -d',' -f3)
    else
        echo "Linguagem inválida: $linguagem"
        exit 1
    fi

    echo ">> Tempo capturado: $tempo"
    echo "$nome_algoritmo,$tamanho,$tempo,${linguagem^}" >> "$saida_csv"
    soma=$(awk "BEGIN {print $soma + $tempo}")
done

media=$(awk "BEGIN {print $soma / $execucoes}")
echo "Tamanho: $tamanho | Execuções: $execucoes | Tempo médio: $media s"


arquivo_saida="media_${linguagem}_${base_algoritmo}.csv"
[ ! -f "$arquivo_saida" ] && echo "Algoritmo,Tamanho,Media,Linguagem" > "$arquivo_saida"
echo "$nome_algoritmo,$tamanho,$media,${linguagem^}" >> "$arquivo_saida"
echo "Média salva em: $arquivo_saida"


gnuplot grafico.gnuplot
echo "Gráfico atualizado: grafico.png"
