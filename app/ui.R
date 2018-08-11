# install.packages("shiny")
library(shiny)

choice_list <- list("File Size (KB)" = 1, "Number of words" = 2,
                    "Lexical Diversity" = 3, "Average word length" = 4)
ui <- fluidPage(
  
  titlePanel("Text Files Analyzer"),
  
  fluidRow(column(6,
                  
                  selectInput("x", h3("x variable"),
                              choices = choice_list, selected = 1)
  ),
  column(6,
         selectInput("y", h3("y variable"),
                     choices = choice_list, selected = 2)
  )),
  
  # outputs
  plotOutput("plot"), 
  verbatimTextOutput("report")
  
)