# Projeto-R

Projeto desenvolvido como trabalho da disciplina de Linguagens de Programação, na UFS, no início da graduação. Na época, o grupo ainda estava aprendendo a usar melhor Git, GitHub e boas práticas de organização de repositório, então este README foi refeito para registrar o projeto de forma mais clara e contextualizada.

## Contexto

O objetivo do trabalho foi comparar o comportamento de algoritmos clássicos de ordenação em três linguagens diferentes: R, C++, e Python. A proposta era observar o tempo de execução de Bubble Sort, Merge Sort e Quick Sort usando a mesma entrada de dados, além de gerar um arquivo com os resultados e um gráfico comparativo.

## Integrantes

- Matheus Calixto
- Igor Augusto
- Paulo Henrique
- Kauan Brilhante
- Leandro Carvalho

## Como o projeto funciona

O arquivo principal do experimento é [main.r](main.r). Ele:

1. Carrega as bibliotecas necessárias.
2. Importa as implementações de ordenação em R, C++ e Python.
3. Solicita ao usuário o tamanho do vetor de entrada.
4. Gera um vetor aleatório.
5. Executa os algoritmos nas três linguagens.
6. Registra os tempos de execução em [resultados_ordenacao.csv](resultados_ordenacao.csv).
7. Gera um gráfico de comparação e salva a imagem em PNG.

## Estrutura do repositório

- [main.r](main.r): script principal que executa a comparação.
- [ordenacaoR.r](ordenacaoR.r): implementações de Bubble Sort, Merge Sort e Quick Sort em R.
- [ordenacaoCpp.cpp](ordenacaoCpp.cpp): implementações em C++ integradas ao R com Rcpp.
- [ordenacaoPython.py](ordenacaoPython.py): implementações em Python integradas ao R com reticulate.
- [resultados_ordenacao.csv](resultados_ordenacao.csv): arquivo com os tempos registrados.

## Requisitos

- R instalado.
- Pacotes R: ggplot2, Rcpp e reticulate.
- Python instalado e acessível para o reticulate.
- Compilador compatível com Rcpp, para carregar o código em C++.

## Execução

1. Abra o projeto no R ou no RStudio.
2. Verifique se os pacotes necessários estão instalados.
3. Execute o arquivo [main.r](main.r).
4. Informe o tamanho do vetor quando solicitado.

Ao final, o script salva os tempos de execução e gera o gráfico de comparação.

## Observação

Este projeto foi feito em uma fase inicial do curso. Por isso, ele foi mantido mais como registro acadêmico e aprendizado prático do que como um repositório com padrão moderno de produção.
