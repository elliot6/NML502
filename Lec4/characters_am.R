


## Read in the matrix

file <- "~/Documents/Rice_University/Spring_2018/NML502/Lec4/characters.ascii.txt"
data <- read.table(file)
data <- as.matrix(data)

## Load necessary packages

library(fields)

## Load in the err_corr function

source("~/Documents/Rice_University/Spring_2018/NML502/Lec4/err_corr.R")

## Load in a function to rotate the output

rotate <- function(x) t(apply(x, 2, rev))

## Construct the input/output matrix

data_matrix <- matrix(0, nrow = dim(data)[2], dim(data)[1])
orig_mats <- list()

for (i in 1:dim(data_matrix)[2]) {
    
    orig_mats[[i]] <- matrix(data[i,], nrow = 7, ncol = 6, byrow = T)
    tmp_vec <- as.vector(orig_mats[[i]])
    data_matrix[,i] <- tmp_vec
    
}

## Output some of the original characters

image.plot(rotate(orig_mats[[1]]), col = heat.colors(12))
image.plot(rotate(orig_mats[[8]]), col = heat.colors(12))
image.plot(rotate(orig_mats[[14]]), col = heat.colors(12))
image.plot(rotate(orig_mats[[17]]), col = heat.colors(12))
image.plot(rotate(orig_mats[[24]]), col = heat.colors(12))



## Generate memory matrix by Hebbs rule and test the recalls

hebb_matrix <- data_matrix[,1] %*% t(data_matrix[,1]) +
    data_matrix[,8] %*% t(data_matrix[,8]) +
    data_matrix[,14] %*% t(data_matrix[,14]) +
    data_matrix[,17] %*% t(data_matrix[,17]) +
    data_matrix[,24] %*% t(data_matrix[,24])

## Test the recall of the original characters

image.plot(rotate(matrix(hebb_matrix %*% data_matrix[,1], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(hebb_matrix %*% data_matrix[,8], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(hebb_matrix %*% data_matrix[,14], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(hebb_matrix %*% data_matrix[,17], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(hebb_matrix %*% data_matrix[,24], nrow = 7, ncol = 6)), col = heat.colors(12))



## Set the parameters

mu <- 0.001
n <- 50000
tol <- 0.00000001

## Generate the memory matrix with err_corr

err_corr(data_matrix, data_matrix, mu, n, tol)

## Test the recall of the original characters

image.plot(rotate(matrix(mem_matrix %*% data_matrix[,1], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% data_matrix[,8], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% data_matrix[,14], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% data_matrix[,17], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% data_matrix[,24], nrow = 7, ncol = 6)), col = heat.colors(12))



## Corrupt 5% of each input

matrix_corr <- data_matrix

for (i in 1:dim(matrix_corr)[2]) {
    
    inds <- sort(sample(1:length(data_matrix[,1]), round(length(data_matrix[,1])/20, 0), replace = FALSE))
    matrix_corr[,i][inds] <- matrix_corr[,i][inds] * (-1)
    
}

## Test the recall for the original characters

image.plot(rotate(matrix(mem_matrix %*% matrix_corr[,1], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% matrix_corr[,8], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% matrix_corr[,14], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% matrix_corr[,17], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_matrix %*% matrix_corr[,24], nrow = 7, ncol = 6)), col = heat.colors(12))



## Corrupt 5% of the memory matrix

mem_mat_corr <- mem_matrix

for (i in 1:dim(mem_matrix)[2]) {
    
    inds <- sort(sample(1:length(mem_matrix[,1]), round(length(mem_matrix[,1])/20, 0), replace = FALSE))
    mem_mat_corr[,i][inds] <- mem_mat_corr[,i][inds] * (-1)
    
}

## Test the recall for the original characters

image.plot(rotate(matrix(mem_mat_corr %*% data_matrix[,1], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_mat_corr %*% data_matrix[,8], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_mat_corr %*% data_matrix[,14], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_mat_corr %*% data_matrix[,17], nrow = 7, ncol = 6)), col = heat.colors(12))
image.plot(rotate(matrix(mem_mat_corr %*% data_matrix[,24], nrow = 7, ncol = 6)), col = heat.colors(12))






