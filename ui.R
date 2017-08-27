## Capstone: Coursera Data Science Final Project

library(shiny)
library(markdown)
library(png)


## SHINY UI
shinyUI(
  fluidPage(
    titlePanel(title=div(img(src="NLP.png", height = 220, width = 220), "Next Word Predictor Using Natural Language Processing", img(src="ComputerLearning.png", height = 150, width = 150))),
    #titlePanel("Next Word Predictor Using Natural Language Processing",img(src = "NLP.png", height = 50, width = 50)),
    br(),
    
    sidebarLayout(
      sidebarPanel(
        br(),
        textInput("inputText", "What do you want to predict ?",value = "")
      ),
      mainPanel(
        h3("My best possible prediction would be:"),
        verbatimTextOutput("prediction"),
        strong("Entered sentence:"),
        strong(code(textOutput('sentence1'))),
        br(),
        strong("Prediction being done using:"),
        strong(code(textOutput('sentence2'))),
        br(),        br(),        br(),
        br(),        br(),        br(),        br(),
        
        img(src = 'coursera.png', height = 50, width = 200),
        img(src = 'johnshopkins.png', height = 50, width = 200),
        img(src = 'swiftkey.png', height = 50, width = 200),
        img(src = 'R.png', height = 60, width = 220),
        
        h5(strong(code("Created and Managed by: Ashish Verma")))
        
        )
    )
  )
)

