library(shiny)
library(ggplot2)
library(WDI)
library(dplyr)
dat <- WDI(indicator='NY.GDP.PCAP.CD', country=c('US','GB','JP','FR','DE','TH','VN','ID'), start=1980, end=2014)
dat <- na.omit(dat)
countriesVector <- unique(dat$country)
countryCodesVector <- unique(dat$iso2c)
countryNames<- setNames(countryCodesVector, countriesVector)
shinyServer(function(input, output) {
  
  # choose columns to display in the data table
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(dat[, input$show_vars, drop = FALSE])
  })
  
  # create reactive to select country to plot and summarize
  countries <- reactive({
    if(length(input$select_countries) > 0) {
      unlist(strsplit(input$select_countries, ' '))
    } else {
      unique(dat$iso2c)
    }
  })
  
  output$myGdpPlot <- renderPlotly({
    ggplot(filter(dat, iso2c %in% countries()), aes(year, NY.GDP.PCAP.CD, col = country)) + 
    geom_line() +     
    xlab('Year') + ylab('GDP per capita') + 
    labs(title = 'GDP Per Capita (current US$)')
  })
  
  output$summary <- renderPrint(summary(filter(dat, iso2c %in% countries())))
  
}) 