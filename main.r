library(Rcpp)
library(ggplot2)


sourceCpp("mergeSort.cpp")
sourceCpp("quickSort.cpp")
sourceCpp("bubbleSort.cpp")


tam <- 100000
vetor_original <- sample(1:10000, tam, replace = TRUE)


time_results <- data.frame(Algoritmo = character(), Tempo = numeric(), Linguagem = character(), stringsAsFactors = FALSE)

bubble_sort_r <- function(v) {
  for (i in seq_along(v)) {
    for (j in seq_len(length(v) - i)) {
      if (v[j] > v[j + 1]) {
        temp <- v[j]
        v[j] <- v[j + 1]
        v[j + 1] <- temp
      }
    }
  }
  return(v)
}

merge_sort_r <- function(v) {
  if (length(v) <= 1) return(v)
  meio <- floor(length(v) / 2)
  esquerda <- merge_sort_r(v[1:meio])
  direita <- merge_sort_r(v[(meio + 1):length(v)])
  return(merge(esquerda, direita))
}

quick_sort_r <- function(v) {
  if (length(v) <= 1) return(v)
  pivo <- v[1]
  esquerda <- quick_sort_r(v[v < pivo])
  direita <- quick_sort_r(v[v > pivo])
  return(c(esquerda, pivo, v[v == pivo][-1], direita))
}


vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Bubble Sort", Tempo = system.time(bubble_sort_r(vetor))[3], Linguagem = "R"
))

vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Merge Sort", Tempo = system.time(merge_sort_r(vetor))[3], Linguagem = "R"
))

vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Quick Sort", Tempo = system.time(quick_sort_r(vetor))[3], Linguagem = "R"
))


vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Bubble Sort", Tempo = system.time(bubbleSort(vetor))[3], Linguagem = "C++"
))

vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Merge Sort", Tempo = system.time(mergeSortR(vetor))[3], Linguagem = "C++"
))

vetor <- vetor_original
time_results <- rbind(time_results, data.frame(
  Algoritmo = "Quick Sort", Tempo = system.time(quick_sort(vetor))[3], Linguagem = "C++"
))

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