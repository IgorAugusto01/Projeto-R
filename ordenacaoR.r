##########################################################

# Ordenacao R

bubbleSortR <- function(v) {
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

mergeSortR <- function(v) {
  if (length(v) <= 1) return(v)
  meio <- floor(length(v) / 2)
  esquerda <- mergeSortR(v[1:meio])
  direita <- mergeSortR(v[(meio + 1):length(v)])
  return(merge(esquerda, direita))
}

quickSortR <- function(v) {
  if (length(v) <= 1) return(v)
  pivo <- v[1]
  esquerda <- quickSortR(v[v < pivo])
  meio <- v[v == pivo]  # Mantém todas as ocorrências do pivô
  direita <- quickSortR(v[v > pivo])
  return(c(esquerda, meio, direita))  # Junta as três partes
}

##########################################################
