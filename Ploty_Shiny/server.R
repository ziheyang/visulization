library(shiny)
library(ggplot2)
library(plyr)
library(dplyr)
library(reshape2)
library(caret)
library(ModelMetrics)
library(stats4)
library(caTools)

# Define a server for the Shiny app
function(input, output) {
  
  output$Continent = renderUI({
    selectInput(inputId = "geog1",
                label = "Continent:", 
                choices = as.character(unique(Happiness$Continent)),
                selected = "Region")
  })
  
  Pred_Actual_lm <- reactive({
    dataset2 = Happiness[Happiness$Continent == input$geog1, Num.cols]
    split = sample.split(dataset2$Happiness.Score, SplitRatio = 0.8)
    training_set = subset(dataset2, split == TRUE)
    test_set = subset(dataset2, split == FALSE)
    
    regressor_lm = lm(formula = Happiness.Score ~ .,
                      data = training_set)
    
    y_pred_lm = predict(regressor_lm, newdata = test_set)
    
    as.data.frame(cbind(Prediction = y_pred_lm, Actual = test_set$Happiness.Score))
  })
  
  output$plot = renderPlot({
    ggplot(Pred_Actual_lm(), aes(Actual, Prediction )) +
      geom_point() + theme_bw() + geom_abline() +
      labs(title = "Multiple Linear Regression", x = "Actual happiness score",
           y = "Predicted happiness score") +
      theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
            axis.title = element_text(family = "Helvetica", size = (10)))
    
  })
  
}