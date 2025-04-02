library(ggplot2)

library(Rcpp)
library(reticulate)


# Carregar os scripts de ordenação
source("ordenacaoR.r")
sourceCpp("ordenacaoCpp.cpp")
source_python("ordenacaoPython.py")

# Tamanho do vetor e geração do vetor original
tam <- 100
vetor_original <- sample(1:10000, tam, replace = TRUE)

# DataFrame para armazenar os resultados
time_results <- data.frame(Algoritmo = character(), Tempo = numeric(), Linguagem = character(), stringsAsFactors = FALSE)

# Função para medir o tempo de execução e registrar os resultados
registrar_tempo <- function(algoritmo, linguagem, funcao, vetor) {
  tempo <- system.time(funcao(vetor))[3]  # Tempo de execução (em segundos)
  time_results <<- rbind(time_results, data.frame(Algoritmo = algoritmo, Tempo = tempo, Linguagem = linguagem))
}

# Comparação em R
registrar_tempo("Bubble Sort", "R", bubbleSortR, vetor_original)
registrar_tempo("Merge Sort", "R", mergeSortR, vetor_original)
registrar_tempo("Quick Sort", "R", quickSortR, vetor_original)

# Comparação em C++
registrar_tempo("Bubble Sort", "C++", bubbleSortCpp, vetor_original)
registrar_tempo("Merge Sort", "C++", mergeSortCpp, vetor_original)
registrar_tempo("Quick Sort", "C++", quickSortCpp, vetor_original)

# Comparação em Python
registrar_tempo("Bubble Sort", "Python", bubbleSortPython, r_to_py(vetor_original))
registrar_tempo("Merge Sort", "Python", mergeSortPython, r_to_py(vetor_original))
registrar_tempo("Quick Sort", "Python", quickSortPython, r_to_py(vetor_original))

# Plot dos resultados
print(
  ggplot(time_results, aes(x = Algoritmo, y = Tempo, group = Linguagem, color = Linguagem)) +
    geom_line(size = 1) +
    geom_point(size = 3) +
    geom_text(aes(label = round(Tempo, 2)), vjust = -0.5, size = 3) +
    labs(
      title = "Comparação de Tempo de Execução dos Algoritmos de Ordenação",
      x = "Algoritmo",
      y = "Tempo (segundos)"
    ) +
    theme_minimal()
)