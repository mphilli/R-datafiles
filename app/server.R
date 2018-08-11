

server <- function (input, output) {
  # list the variable options
  options <- list(file_sizes, num_words, lex_diversity, avg_word_length)
  labels <- c("File Size (KB)", "Numer of words", "Lexical Diversity", "Average word length")
  
  
  output$plot <- renderPlot({
    # create a dataframe from the selected variables
    x <- unlist(options[as.numeric(input$x)])
    y <- unlist(options[as.numeric(input$y)])
    data <- data.frame(x, y)

    # plot the data in a linear regression model using ggplot    
    ggplot(data, aes(x, y)) + geom_point(size=2, shape=16) +
      geom_smooth(method="lm", formula=y~x) + 
      labs(x=labels[as.numeric(input$x)], y=labels[as.numeric(input$y)])
  })
  
  output$report <- renderPrint({
    x <- unlist(options[as.numeric(input$x)])
    y <- unlist(options[as.numeric(input$y)])
    model <- lm(x ~ y)
    
    print(paste0("Correlation: ", cor(data.frame(x, y))[1, 2]))
    print(paste0("R-squared: ", summary(model)$r.squared))
    print(paste0("p-value: ", summary(model)$coefficients[2,4]))
  })
}

shinyApp(ui = ui, server = server)
