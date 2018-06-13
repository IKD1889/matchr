#' Matching test between two datasets.
#' @note This package support only numeric or integer variable. A factor type variable will be supported later update.
#'
#' @param data1 data.frame. One of two datasets.
#' @param data2 data.frame. The other dataset.
#' @param id1 data1's id. This parameter should be integer.
#' @param id2 data2's id. This parameter should be integer.
#'
#' @return Output on the console about missmatch variable and participant.
#'
#' @examples
#' n <- 20
#' min <- 0
#' max <- 5
#' id <- 1:n
#' id2 <- n:1
#' set.seed(123)
#' var1 <- runif(n = n, min = min, max = max)
#' set.seed(213)
#' var2 <- runif(n = n, min = min, max = max)
#' set.seed(321)
#' var3 <- runif(n = n, min = min, max = max)
#' hoge1 <- data.frame(key = id, var1, var2, var3)
#' hoge2 <- data.frame(id, var1, var2, var3)
#' hoge2$var1[2] <- 6.00
#' hoge2$var2[7] <- -1.00
#' hoge2$var3[8] <- NA
#' data3 <- dplyr::arrange(hoge2, -id)#data3 reversed order data2 dataset
#'
#' matching_test(data1 = hoge1, data2 = hoge2, id1 = hoge1$key, id2 = hoge2$id)
#' matching_test(data1 = hoge1, data2 = data3, id1 = hoge1$key, id2 = data3$id)
#'
#' @export

# define function ----
matching_test <- function(data1, data2, id1 = data1$id, id2 = data2$id) {
data1 <- as.data.frame(data1)
data2 <- as.data.frame(data2)
nrow <- nrow(data1)
id_match <- matrix(nrow = nrow, ncol = 1)

for(k in 1:nrow){
  id_match[k] <- ifelse(id1[k] != id2[k], 1, 0)
}

if(apply(id_match, MARGIN = 2, FUN = "sum") != 0) {
  cat("ID order was not same.\n")
  cat("ID was sorted with 'dplyr::arrange'.\n")
  data2 = dplyr::arrange(data2, id2) %>% as.data.frame()
  temp <- ifelse((data1 - data2) != 0, 1, 0)
  temp <- as.data.frame(temp)
  for(i in 1:ncol(temp)){
    for(j in 1:nrow(temp)){
      if(is.na(temp[j, i])){
        cat(sprintf("participant %s's %s is NA.", row.names.data.frame(temp)[j], colnames(temp)[i]))
        cat(" Please check rawdata.\n")
        j <- j + 1
      }else
        if(temp[j,i] != 0){
          colnames(temp)[i]
          cat(sprintf("participant %s's %s is NOT matching.", row.names.data.frame(temp)[j], colnames(temp)[i]))
          cat(" Please check rawdata.\n")
        }
    }
  }
} else {
  temp <- ifelse((data1 - data2) != 0, 1, 0)
  temp <- as.data.frame(temp)
    for(i in 1:ncol(temp)){
     for(j in 1:nrow(temp)){
       if(is.na(temp[j, i])){
          cat(sprintf("participant %s's %s is NA.", row.names.data.frame(temp)[j], colnames(temp)[i]))
          cat(" Please check rawdata.\n")
          j <- j + 1
        }else
          if(temp[j,i] != 0){
            colnames(temp)[i]
            cat(sprintf("participant %s's %s is NOT matching.", row.names.data.frame(temp)[j], colnames(temp)[i]))
            cat(" Please check rawdata.\n")
          }
      }
    }
  }
cat("....All check was done....\n")
}
