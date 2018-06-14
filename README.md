matchr
------

Undergraduate students usually input data to splead seet from paper
media with their own hands. Inputting data, however, is sometimes
uncorrect. So double check like two input independently is better
choice.

### what can the function can?

Test whether two datasets is matching or not.  
`matching_test()` return participant and variable name when the datasets
are not matching. And the dataset which is assigned `data2` is sorted if
the arrange of `id2` is different from `id1`. This package support
**numeric or integer only**. A factor type variable will be supported
later update.

### Usage

Install `matchr` package via GitHub.

    #install.packages("devtools")
    library("devtools")
    devtools::install_github("IKD1889/matchr")
    library("matchr")

Dummy datasets.

    n <- 20
    min <- 0
    max <- 5
    id <- 1:n
    id2 <- n:1
    set.seed(123)
    var1 <- runif(n = n, min = min, max = max)
    set.seed(213)
    var2 <- runif(n = n, min = min, max = max)
    set.seed(321)
    var3 <- runif(n = n, min = min, max = max)
    data1 <- data.frame(id, var1, var2, var3)
    data2 <- data.frame(key = id, var1, var2, var3)
    data2$var1[2] <- 6.00
    data2$var2[7] <- -1.00
    data2$var3[8] <- NA
    data3 <- dplyr::arrange(data2, -id)#data3 reversed order data2 dataset

`data1` doesn't have any NA. This dataset is true dataset.  
`data2` have a missing cell in `var3`, missinputs in `var1` and `var2`.
This dataset also has `key` instead of `id`. `data3` is ordered reverse
with `data2`.

    matching_test(data1 = data1, data2 = data2, id1 = data1$id, id2 = data2$key)

    ## participant 2's var1 is NOT matching. Please check rawdata.
    ## participant 7's var2 is NOT matching. Please check rawdata.
    ## participant 8's var3 is NA. Please check rawdata.
    ## ....All check was done....

    matching_test(data1 = data1, data2 = data3, id1 = data1$id, id2 = data3$key)

    ## ID order was not same.
    ## ID was sorted with 'dplyr::arrange'.
    ## participant 2's var1 is NOT matching. Please check rawdata.
    ## participant 7's var2 is NOT matching. Please check rawdata.
    ## participant 8's var3 is NA. Please check rawdata.
    ## ....All check was done....
