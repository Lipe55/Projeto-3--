set terminal pngcairo size 1000,700 enhanced font 'Verdana,12'
set output 'grafico.png'

set title "Comparação de Algoritmos de Ordenação"
set xlabel "Tamanho do vetor"
set ylabel "Tempo (s)"
set key outside right top box
set grid
set datafile separator ","
set logscale x
set datafile columnheaders

plot \
    'tempos.csv' using (stringcolumn("Algoritmo") eq "Bubble Sort" && stringcolumn("Linguagem") eq "C" ? column("Tamanho") : 1/0):(column("Tempo")) with linespoints lt 1 lw 2 pt 7 lc rgb "blue" title "Bubble Sort (C)", \
    '' using (stringcolumn("Algoritmo") eq "Merge Sort" && stringcolumn("Linguagem") eq "C" ? column("Tamanho") : 1/0):(column("Tempo")) with linespoints lt 1 lw 2 pt 5 lc rgb "green" title "Merge Sort (C)", \
    '' using (stringcolumn("Algoritmo") eq "Bubble Sort" && stringcolumn("Linguagem") eq "Python" ? column("Tamanho") : 1/0):(column("Tempo")) with linespoints lt 1 lw 2 pt 9 lc rgb "red" title "Bubble Sort (Python)", \
    '' using (stringcolumn("Algoritmo") eq "Merge Sort" && stringcolumn("Linguagem") eq "Python" ? column("Tamanho") : 1/0):(column("Tempo")) with linespoints lt 1 lw 2 pt 13 lc rgb "violet" title "Merge Sort (Python)"
