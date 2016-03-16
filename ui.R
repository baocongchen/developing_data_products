library(shiny)
library(ggplot2) 
library(WDI)
library(dplyr)
dat <- WDI(indicator='NY.GDP.PCAP.CD', 
          country=c('US','GB','JP','FR','DE','TH','VN','ID'), 
          start=1980, end=2014)
dat <- na.omit(dat)
countriesVector <- unique(dat$country)
countryCodesVector <- unique(dat$iso2c)
countryNames<- setNames(countryCodesVector, countriesVector)
shinyUI(fluidPage(
  #titlePanel('GDP Prediction'),
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        condition='input.dataset === "GDP per capita (current US$)"',
        checkboxGroupInput('show_vars', h2('Columns in the dataset'),
                           choices = colnames(dat), 
                           selected = colnames(dat))
      ),
      conditionalPanel(
        condition='input.dataset === "Plot"',
        checkboxGroupInput('select_countries', label = h2('GDP Growth by Countries'),
                           choices = countryNames,
                           selected = c('VN','ID','TH'))
      )
    
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Plot", plotOutput("myGdpPlot"),
                 helpText("GDP per capita is gross domestic product divided by midyear population. GDP is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources. Data are in current U.S. dollars.")),
        tabPanel('GDP per capita (current US$)', DT::dataTableOutput('mytable1'))
        
      )
    )
  )
))