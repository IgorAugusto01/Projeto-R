##########################################################

# Ordenacao R

selectionSort <- function(array) {
  n <- length(array)
  
  for (i in 1:(n - 1)) {
    minor <- i
    
    for (j in (i + 1):n) {
      if (array[j] < array[minor]) {
        minor <- j
      }
    }
    
    if (minor != i) {
      key <- array[minor]
      array[minor] <- array[i]
      array[i] <- key
    }
  }
  
  return(array)
}

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
  direita <- quickSortR(v[v > pivo])
  return(c(esquerda, pivo, v[v == pivo][-1], direita))
}

##########################################################