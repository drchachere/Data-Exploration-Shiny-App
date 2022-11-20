library(shiny)
library(ggplot2)
library(plotly)

df <- datasets::airquality

valid_rows <- !is.na(df$Ozone) & !is.na(df$Solar.R)
df <- df[valid_rows, ]

df$timeDatect <- as.POSIXct(as.POSIXlt(paste(73, df$Month, df$Day), format="%y %m %d"))
df <- df[, -c(5, 6)]

rtnString <- function(x){
    c("Ozone (in parts per billion)",
      "Solar Radiation (in Langleys)",
      "Wind (in mph)",
      "Temperature (in degrees Fahrenheit)")[x]
}

shinyServer(
    function(input, output) {
        i1 <- reactive({as.numeric(input$i1)})
        i2 <- reactive({as.numeric(input$i2)})
        quant_sec_ft <- reactive({cut(df[ , i2()], 
                                      breaks=quantile(df[ , i2()]), 
                                      labels=c("Very Low", "Lower Average", "Higher Average", "Very High"), 
                                      include.lowest=TRUE)
        })
        output$newChart <- renderPlotly({
            g <- ggplot(df, 
                        aes(x=timeDatect, y=df[ , i1()], color=quant_sec_ft(), text=FALSE)) + 
                geom_point() +
                xlab("Date") +
                ylab(rtnString(i1())) + 
                scale_color_discrete(name=rtnString(i2()))
            ggplotly(g, tooltip=c("y", "x"))
        })   
    }
)