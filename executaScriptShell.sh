#!/bin/bash

export LC_NUMERIC=C

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

# Nome amigável do algoritmo
if [ "$algoritmo" = "merge" ]; then
    nome_algoritmo="Mergesort"
    base_algoritmo="mergesort"
elif [ "$algoritmo" = "bubble" ]; then
    nome_algoritmo="Bubblesort"
    base_algoritmo="bubblesort"
else
    nome_algoritmo="${algoritmo^}"
    base_algoritmo="${algoritmo,,}"
fi

saida_csv="tempos.csv"

# Criar cabeçalho se o CSV ainda não existir
if [ ! -f "$saida_csv" ]; then
    echo "Algoritmo,Tamanho,Tempo,Linguagem" > "$saida_csv"
fi

# Resetar soma com precisão
soma="0.0"

for ((i=1; i<=execucoes; i++)); do
    if [ "$linguagem" = "python" ]; then
        saida=$(python3 ${algoritmo}.py $tamanho)
        tempo=$(echo "$saida" | cut -d',' -f3 | tr -d '[:space:]')
    elif [ "$linguagem" = "c" ]; then
        ./a.out $tamanho > .temp_saida
        saida=$(cat .temp_saida)
        tempo=$(echo "$saida" | cut -d';' -f2 | tr -d ';')
    else
        echo "Linguagem inválida: $linguagem"
        exit 1
    fi

    echo ">> Tempo capturado: $tempo"

    echo "$nome_algoritmo,$tamanho,$tempo,${linguagem^}" >> "$saida_csv"

    # Converte tempo para decimal puro
    tempo_decimal=$(printf "%.20f\n" "$tempo")
    soma=$(echo "$soma + $tempo_decimal" | bc -l)
done

media=$(echo "$soma / $execucoes" | bc -l)
echo "Tamanho: $tamanho | Execuções: $execucoes | Tempo médio: $media s"

# Arquivo da média
arquivo_saida="media_${linguagem}_${base_algoritmo}.csv"

# Cabeçalho do arquivo de média
if [ ! -f "$arquivo_saida" ]; then
    echo "Algoritmo,Tamanho,Media,Linguagem" > "$arquivo_saida"
fi

echo "$nome_algoritmo,$tamanho,$media,${linguagem^}" >> "$arquivo_saida"
echo "Média salva em: $arquivo_saida"

# Gera gráfico (opcional)
gnuplot grafico.gnuplot
echo "Gráfico atualizado: grafico.png"
