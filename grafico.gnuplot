set terminal pngcairo size 1000,700 enhanced font 'Verdana,12'
set output 'grafico.png'

set title "Comparação de Algoritmos de Ordenação"
set xlabel "Tamanho do vetor"
set ylabel "Tempo (s)"
set key outside right top box
set grid
set datafile separator ","
set logscale x

plot \
    'tempos.csv' every ::1 using (strcol(1) eq "Bubble Sort" && strcol(4) eq "C"      ? $2 : 1/0):($3) with linespoints lt 1 lw 2 pt 7 lc rgb "blue"    title "Bubble Sort (C)", \
    ''           every ::1 using (strcol(1) eq "Merge Sort"  && strcol(4) eq "C"      ? $2 : 1/0):($3) with linespoints lt 1 lw 2 pt 5 lc rgb "green"   title "Merge Sort (C)", \
    ''           every ::1 using (strcol(1) eq "Bubble Sort" && strcol(4) eq "Python" ? $2 : 1/0):($3) with linespoints lt 1 lw 2 pt 9 lc rgb "red"     title "Bubble Sort (Python)", \
    ''           every ::1 using (strcol(1) eq "Merge Sort"  && strcol(4) eq "Python" ? $2 : 1/0):($3) with linespoints lt 1 lw 2 pt 13 lc rgb "violet" title "Merge Sort (Python)"
