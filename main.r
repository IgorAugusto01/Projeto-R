library(ggplot2)
library(Rcpp)
library(reticulate)

source("ordenacaoR.r")
sourceCpp("ordenacaoCpp.cpp")
source_python("ordenacaoPython.py")

# solicitar o tamanho do vetor ao usuário
tam <- as.integer(readline(prompt = "Digite o tamanho do vetor: "))

# gera o vetor 
vetor_original <- sample(1:10000, tam, replace = TRUE)


# DataFrame para armazenar os resultados
time_results <- data.frame(Algoritmo = character(), Tempo = numeric(), Linguagem = character(),
                           stringsAsFactors = FALSE)
#stringAsFactors -> impede que os textos sejam automaticamente convertidos para fatores

# função para medir o tempo de execução e registrar os resultados
registrar_tempo <- function(algoritmo, linguagem, funcao, vetor) {
  tempo <- system.time(funcao(vetor))[3] * 1000  # tempo de execução, [3] -> tempo decorrido 
  time_results <<- rbind(time_results, data.frame(Algoritmo = algoritmo, Tempo = tempo,
                                                  Linguagem = linguagem))
}


# comparação em R
registrar_tempo("Bubble Sort", "R", bubbleSortR, vetor_original)
registrar_tempo("Merge Sort", "R", mergeSortR, vetor_original)
registrar_tempo("Quick Sort", "R", quickSortR, vetor_original)

# comparação em C++
registrar_tempo("Bubble Sort", "C++", bubbleSortCpp, vetor_original)
registrar_tempo("Merge Sort", "C++", mergeSortCpp, vetor_original)
registrar_tempo("Quick Sort", "C++", quickSortCpp, vetor_original)

# comparação em python
registrar_tempo("Bubble Sort", "Python", bubbleSortPython, r_to_py(vetor_original))
registrar_tempo("Merge Sort", "Python", mergeSortPython, r_to_py(vetor_original))
registrar_tempo("Quick Sort", "Python", quickSortPython, r_to_py(vetor_original))


file_name <- "resultados_ordenacao.csv"

# criar um cabeçalho 
header <- paste("\nTamanho do Vetor:", tam, "- Execução em:", Sys.time(), "\n")

# escrever o cabeçalho no arquivo CSV 
write(header, file = file_name, append = TRUE)

# escrever os resultados da ordenação no arquivo CSV 
write.table(time_results, 
            file = file_name, #onde sera salvo
            row.names = FALSE, #remove os indices das linhas
            sep = ",", 
            append = TRUE, 
            col.names = !file.exists(file_name)) #se o arquivo n existir, escreve os nomes

cat("Resultados salvos com sucesso no arquivo:", file_name, "\n")

# gerar gráfico
grafico <- ggplot(time_results, aes(x = Algoritmo, y = Tempo, fill = Linguagem)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +  # barras agrupadas
# scale_fill_manual(values = c("R" = "blue", "C++" = "red", "Python" = "green"))
  geom_text(
    aes(label = paste0(round(Tempo, 1), "ms")),  # adiciona ms nos rótulos
    position = position_dodge(width = 0.8),
    vjust = -0.5,
    size = 3
  ) +
  labs(
    title = paste("Comparação de Tempo de Execução Vetor de", tam, "(em Milissegundos)"),
    x = "Algoritmo",
    y = "Tempo (ms)"
  ) +
  theme_classic() +
  scale_fill_brewer(palette = "Set1")  # melhora a paleta de cores

print(grafico)

# salvar o gráfico em um arquivo .png
ggsave("grafico_comparacao.png", plot = grafico, width = 10, height = 6, dpi = 300)
