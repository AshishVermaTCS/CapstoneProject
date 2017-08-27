## Data Science Capstone Final Project

library(shiny); library(stringr); library(tm); library(readr)

bg <- readRDS("bigram.RData"); tg <- readRDS("trigram.RData"); qd <- readRDS("quadgram.RData")

names(bg)[names(bg) == 'word1'] <- 'w1'; names(bg)[names(bg) == 'word2'] <- 'w2';
names(tg)[names(tg) == 'word1'] <- 'w1'; names(tg)[names(tg) == 'word2'] <- 'w2'; names(tg)[names(tg) == 'word3'] <- 'w3';
names(qd)[names(qd) == 'word1'] <- 'w1'; names(qd)[names(qd) == 'word2'] <- 'w2'; names(qd)[names(qd) == 'word3'] <- 'w3'
names(qd)[names(qd) == 'word4'] <- 'w4';
message <- ""



## Function for predicting the next word
predictNextWord <- function(input_word) {
  clean_word <- stripWhitespace(removeNumbers(removePunctuation(tolower(input_word),preserve_intra_word_dashes = TRUE)))
  input_word <- strsplit(clean_word, " ")[[1]]
  n <- length(input_word)
  
  ## check with bigram
  if (n == 1) {input_word <- as.character(tail(input_word,1)); functionBigram(input_word)}
  
  ## check with trigram
  else if (n == 2) {input_word <- as.character(tail(input_word,2)); functionTrigram(input_word)}
  
  ## check with quadgram
  else if (n >= 3) {input_word <- as.character(tail(input_word,3)); functionQuadgram(input_word)}
}


##Function to check based on bigram
functionBigram <- function(input_word) {
  if (identical(character(0),as.character(head(bg[bg$w1 == input_word[1], 2], 1)))) {
    message<<-"If no word found the most used pronoun 'it' in English will be returned" 
    as.character(head("it",1))
  }
  else {
    message <<- "Trying to Predict the Word using Bigram Freqeuncy Matrix  "
    as.character(head(bg[bg$w1 == input_word[1],2], 1))
  }
}

##Function to check based on trigram
functionTrigram <- function(input_word) {
  if (identical(character(0),as.character(head(tg[tg$w1 == input_word[1]
                                                  & tg$w2 == input_word[2], 3], 1)))) {
    as.character(predictNextWord(input_word[2]))
  }
  else {
    message<<- "Trying to Predict the Word using Trigram Fruequency Matrix "
    as.character(head(tg[tg$w1 == input_word[1]
                         & tg$w2 == input_word[2], 3], 1))
  }
}

##Function to check based on quadgram
functionQuadgram <- function(input_word) {
  if (identical(character(0),as.character(head(qd[qd$w1 == input_word[1]
                                                  & qd$w2 == input_word[2]
                                                  & qd$w3 == input_word[3], 4], 1)))) {
    as.character(predictNextWord(paste(input_word[2],input_word[3],sep=" ")))
  }
  else {
    message <<- "Trying to Predict the Word using Quadgram Frequency Matrix"
    as.character(head(qd[qd$w1 == input_word[1] 
                         & qd$w2 == input_word[2]
                         & qd$w3 == input_word[3], 4], 1))
  }       
}


## ShineServer code to call the function predictNextWord
shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- predictNextWord(input$inputText)
    output$sentence2 <- renderText({message})
    result
  });
  output$sentence1 <- renderText({
    input$inputText});
}
)

