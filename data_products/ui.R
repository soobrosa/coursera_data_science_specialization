library(shiny)
library(plotrix)

shinyUI(pageWithSidebar(
  
  headerPanel("Foursquare Trending Places Regression Example"),
  
  sidebarPanel(
    selectInput("city","City:",
                list("London", "New York", "Hong Kong", "Berlin"),"London"),
    br(),
    h4("Description"),
    helpText("Let's try to figure out how do
              Foursquare Trending Places attributes
              align in number of checkins and tips."),
    br(),
    checkboxInput("line","Show me the regression line!", T),
    checkboxInput("means","Show me the mean of checkings and tips!"),
    checkboxInput("ant","Show me the regression equation!", F)
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot",plotOutput("plot")),
      tabPanel("Stats Summary",
               h4("Screen output in R"),
               verbatimTextOutput("summary"))
      )
    )
  )
  
  )