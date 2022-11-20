library(shiny)
library(plotly)

shinyUI(pageWithSidebar(
    headerPanel("New York Air Quality Data, 1973"),
    sidebarPanel(
        radioButtons("i1", 
                     "Primary Feature", 
                     c("Ozone"=1, 
                       "Solar Radiation"=2, 
                       "Wind"=3, 
                       "Temperature"=4),
                     selected = 4),
        radioButtons("i2", 
                     "Secondary Feature", 
                     c("Ozone"=1, 
                       "Solar Radiation"=2, 
                       "Wind"=3, 
                       "Temperature"=4),
                     selected = 1),
        submitButton("Update Chart")
    ),
    mainPanel(
        plotlyOutput("newChart")
    )
))