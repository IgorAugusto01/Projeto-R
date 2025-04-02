library(ggplot2)

library(Rcpp)
library(reticulate)

# Carregar os scripts de ordenação
source("ordenacaoR.r")
sourceCpp("ordenacaoCpp.cpp")
source_python("ordenacaoPython.py")

# Solicitar tamanho do vetor ao usuário
tam <- as.integer(readline(prompt = "Digite o tamanho do vetor: "))

# Gerar vetor aleatório
vetor_original <- sample(1:20000, tam, replace = TRUE)

# DataFrame para armazenar os resultados
time_results <- data.frame(Algoritmo = character(), Tempo = numeric(), Linguagem = character(), Tamanho = integer(), stringsAsFactors = FALSE)

# Função para medir o tempo de execução e registrar os resultados
registrar_tempo <- function(algoritmo, linguagem, funcao, vetor) {
  tempo <- system.time(funcao(vetor))[3] * 1000 # Tempo de execução (em segundos)
  time_results <<- rbind(time_results, data.frame(Algoritmo = algoritmo, Tempo = tempo, Linguagem = linguagem, Tamanho = tam))
}

# Comparação em R
registrar_tempo("Selection Sort", "R", selectionSortR, vetor_original)
registrar_tempo("Bubble Sort", "R", bubbleSortR, vetor_original)
registrar_tempo("Merge Sort", "R", mergeSortR, vetor_original)
registrar_tempo("Quick Sort", "R", quickSortR, vetor_original)

# Comparação em C++
registrar_tempo("Selection Sort", "C++", selectionSortCpp, vetor_original)
registrar_tempo("Bubble Sort", "C++", bubbleSortCpp, vetor_original)
registrar_tempo("Merge Sort", "C++", mergeSortCpp, vetor_original)
registrar_tempo("Quick Sort", "C++", quickSortCpp, vetor_original)

# Comparação em Python
registrar_tempo("Selection Sort", "Python", selectionSortPython, r_to_py(vetor_original))
registrar_tempo("Bubble Sort", "Python", bubbleSortPython, r_to_py(vetor_original))
registrar_tempo("Merge Sort", "Python", mergeSortPython, r_to_py(vetor_original))
registrar_tempo("Quick Sort", "Python", quickSortPython, r_to_py(vetor_original))

# Salvar os resultados sem sobrescrever o arquivo
file_name <- "resultados_ordenacao.csv"

# Criar um cabeçalho com o tamanho do vetor e a data/hora da execução
header <- paste("\nTamanho do Vetor:", tam, "- Execução em:", Sys.time(), "\n")

# Escrever o cabeçalho no arquivo CSV (sempre adicionando)
write(header, file = file_name, append = TRUE)

# Escrever os resultados da ordenação no arquivo CSV (sempre adicionando)
write.table(time_results, file = file_name, row.names = FALSE, sep = ",", append = TRUE, col.names = !file.exists(file_name))

# Exibir mensagem de confirmação
cat("Resultados salvos com sucesso no arquivo:", file_name, "\n")

# Gerar gráfico
ggplot(time_results, aes(x = Algoritmo, y = Tempo, fill = Linguagem)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +  # Barras agrupadas
  geom_text(
    aes(label = paste0(round(Tempo, 1), "ms")),  # Adiciona "ms" nos rótulos
    position = position_dodge(width = 0.8), 
    vjust = -0.5, 
    size = 3
  ) +
  labs(
    title = paste("Comparação de Tempo de Execução Vetor de  ", tam," (em Milissegundos)"),
    x = "Algoritmo",
    y = "Tempo (ms)"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")  # Melhora a paleta de cores

