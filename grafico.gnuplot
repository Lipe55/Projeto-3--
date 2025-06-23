set terminal pngcairo size 1000,600 enhanced font "Verdana,10"
set output "grafico.png"

set title "Tempo médio de execução por algoritmo"
set xlabel "Tamanho da entrada"
set ylabel "Tempo médio (s)"
set grid
set key outside
set datafile separator ","

set logscale y 10
set logscale x 10  # <<< Coloque também log no eixo X (opcional)

set xtics ("1" 1, "10" 10, "100" 100, "1k" 1000, "10k" 10000, "1M" 1000000)

plot \
    'media_c_bubblesort.csv'               using 2:3 with linespoints lt 1 pt 7 lc rgb "blue"    title "Bubblesort (C)", \
    'media_c_mergesort.csv'                using 2:3 with linespoints lt 1 pt 5 lc rgb "green"   title "Mergesort (C)", \
    'media_python_bubblesort.csv'          using 2:3 with linespoints lt 1 pt 9 lc rgb "red"     title "Bubblesort (Python)", \
    'media_python_mergesort.csv'           using 2:3 with linespoints lt 1 pt 13 lc rgb "violet" title "Mergesort (Python)"
