library(shiny)
library(ggplot2) 
library(WDI)
library(dplyr)
library(plotly)
options(warn=-1)
dat <- WDI(indicator='NY.GDP.PCAP.CD', 
          country=c('US','GB','JP','FR','DE','TH','VN','ID'), 
          start=1980, end=2014)
dat <- na.omit(dat)
countriesVector <- unique(dat$country)
countryCodesVector <- unique(dat$iso2c)
countryNames<- setNames(countryCodesVector, countriesVector)
shinyUI(navbarPage("LUX",
             tabPanel('App', 
               sidebarLayout(
                 sidebarPanel(
                   conditionalPanel(
                     condition='input.dataset === "Data Table"',
                     checkboxGroupInput('show_vars', h2('Columns in the dataset'),
                                        choices = colnames(dat), 
                                        selected = colnames(dat))
                   ),
                   conditionalPanel(
                     condition='input.dataset === "Main"',
                     checkboxGroupInput('select_countries', label = h2('GDP Growth by Countries'),
                                        choices = countryNames,
                                        selected = c('VN','ID','TH'))
                   )
                   
                 ),
                 mainPanel(
                   tabsetPanel(
                     id = 'dataset',
                     tabPanel('Main', 
                              plotlyOutput('myGdpPlot'),
                              verbatimTextOutput('summary'),
                              helpText('GDP per capita is gross domestic product 
                                       divided by midyear population. GDP is the sum 
                                       of gross value added by all resident producers 
                                       in the economy plus any product taxes and minus 
                                       any subsidies not included in the value of the 
                                       products. It is calculated without making deductions 
                                       for depreciation of fabricated assets or for depletion 
                                       and degradation of natural resources. Data are in current 
                                       U.S. dollars.')
                              ),
                     tabPanel('Data Table', DT::dataTableOutput('mytable1'))
                   )
                 ) 
               )
             ),
             tabPanel('Documentation',
                      h1('Summary'),
                      p("This app shows World Bank's GDP Indicator. \nThe data is obtained
                        directly from the World Bank Open Data site. Please visit ",
                        a('https://data.worldbank.org/indicator'),
                        'for more information'), 
                      p('The App has 2 tabs; one shows the graph of GDP per capita by year 
                        for each country and its summary, the other the data table')
             )
  
        )
)