#!/bin/bash

export LC_NUMERIC=C

usage() {
    echo "Uso: $0 -l [c|python] -a [bubble|merge] -n [n_execucoes] -t [tamanho_entrada]"
    echo "     -c : limpar arquivos CSV e gráfico antes de rodar (opcional)"
    exit 1
}

limpar=false

while getopts ":l:a:n:t:c" opt; do
  case $opt in
    l) linguagem="$OPTARG" ;;
    a) algoritmo="$OPTARG" ;;
    n) execucoes="$OPTARG" ;;
    t) tamanho="$OPTARG" ;;
    c) limpar=true ;;
    \?) echo "Opção inválida: -$OPTARG" >&2; usage ;;
    :) echo "Opção -$OPTARG requer um argumento." >&2; usage ;;
  esac
done

if [[ -z "$linguagem" || -z "$algoritmo" || -z "$execucoes" || -z "$tamanho" ]]; then
    usage
fi

if $limpar; then
    echo " Limpando arquivos antigos..."
    rm -f tempos.csv media_*.csv grafico.png
fi

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

if [ ! -f "$saida_csv" ]; then
    echo "Algoritmo,Tamanho,Tempo,Linguagem" > "$saida_csv"
fi

soma="0.0"

for ((i=1; i<=execucoes; i++)); do
    if [ "$linguagem" = "python" ]; then
        if [ ! -f "${algoritmo}.py" ]; then
            echo "Erro: Arquivo ${algoritmo}.py não encontrado!"
            exit 1
        fi
        saida=$(python3 ${algoritmo}.py $tamanho)
        tempo=$(echo "$saida" | cut -d',' -f3 | tr -d '[:space:]')
    elif [ "$linguagem" = "c" ]; then
        if [ ! -f "./a.out" ]; then
            echo " Erro: Arquivo a.out não encontrado! Compile seu código C primeiro."
            exit 1
        fi
        ./a.out $tamanho > .temp_saida
        saida=$(cat .temp_saida)
        tempo=$(echo "$saida" | cut -d';' -f2 | tr -d ';')
    else
        echo " Linguagem inválida: $linguagem"
        exit 1
    fi

    echo ">> Tempo capturado: $tempo"

    echo "$nome_algoritmo,$tamanho,$tempo,${linguagem^}" >> "$saida_csv"

    tempo_decimal=$(printf "%.20f\n" "$tempo")
    soma=$(echo "$soma + $tempo_decimal" | bc -l)
done

media=$(echo "$soma / $execucoes" | bc -l)
echo "Tamanho: $tamanho | Execuções: $execucoes | Tempo médio: $media s"

arquivo_saida="media_${linguagem}_${base_algoritmo}.csv"

if [ ! -f "$arquivo_saida" ]; then
    echo "Algoritmo,Tamanho,Media,Linguagem" > "$arquivo_saida"
fi


grep -v "^$nome_algoritmo,$tamanho," "$arquivo_saida" > temp.csv || true
mv temp.csv "$arquivo_saida"

echo "$nome_algoritmo,$tamanho,$media,${linguagem^}" >> "$arquivo_saida"
echo "Média salva em: $arquivo_saida"

gnuplot grafico.gnuplot
echo "Gráfico atualizado: grafico.png"
