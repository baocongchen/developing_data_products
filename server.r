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
  
  # choose columns to display
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(dat[, input$show_vars, drop = FALSE])
  })
  countries <- reactive({unlist(strsplit(input$select_countries, ' '))})
  output$myGdpPlot <- renderPlot(ggplot(filter(dat, iso2c %in% countries()), aes(year, NY.GDP.PCAP.CD, col = country)) + 
                                   geom_line() +     
                                   xlab('Year') + ylab('GDP per capita') + 
                                   labs(title = "GDP Per Capita (current US$)")
                                )

}) 