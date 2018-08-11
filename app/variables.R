# A shiny app that visualizes variables concerning a set of text files.

library(tm)
library(ggplot2)
# install.packages("rstudioapi")
library(rstudioapi)
cwd <- getActiveDocumentContext()$path
setwd(dirname(cwd))

DATA_DIR <- "./data_files/"
text_files <- readtext::readtext(paste0(DATA_DIR, "*"))

get_file_sizes <- function(files) {
  #' Returns a vector of file sizes from the specified list of files
  sizes <- c()
  for (i in 1:length(files[[1]])) {
    sizes[i] <- file.info(paste0(DATA_DIR, files[[1]][i]))$size
  }
  return(sizes)
}

file_sizes <- get_file_sizes(text_files)

get_num_words <- function(files) {
  #' Returns a vector of the number of words (whitespace delimited) in a list of files
  num_words <- c()
  file_text <- files[[2]]
  for (i in 1:length(file_text)) {
    num_words[i] <- sapply(strsplit(toString(file_text[i]), " "), length)
  }
  return(num_words)
}

num_words <- get_num_words(text_files)

get_lex_diversity <- function(files) {
  #' Returns a vector of type-token ratios for a list of files
  diversity <- c()
  file_text <- files[[2]]
  for (i in 1:length(file_text)) {
    tokens <- tm::MC_tokenizer(toString(file_text[i]))
    diversity[i] <- length(unique(tokens)) / length(tokens)
  }
  return(diversity)
}

lex_diversity <- get_lex_diversity(text_files)

get_avg_word_length <- function(files) {
  #' Returns a vector of average word lengths from each file
  avg_lengths <- c()
  file_text <- files[[2]]
  for (i in 1:length(file_text)) {
    words <- unlist(strsplit(toString(file_text[i]), " "))
    word_lengths <- c()
    for (j in 1:sapply(list(words), length)) {
      word_lengths[j] <- nchar(words[j])
    }
    avg_lengths[i] <- sum(word_lengths) / length(word_lengths)
  }
  return(avg_lengths)
}

avg_word_length <- get_avg_word_length(text_files)