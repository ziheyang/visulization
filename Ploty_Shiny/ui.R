library(shiny)
library(ggplot2)

fluidPage(
  titlePanel("Interactive Linear Regressions for Happiness Score"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("Continent"),
      #uiOutput("Year")
    ),
    
    mainPanel(
      plotOutput("plot", height = "400px"))
  )
)