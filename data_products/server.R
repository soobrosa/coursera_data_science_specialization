library(shiny)
library(plotrix)
library("RCurl")
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
library("RJSONIO")

foursquare <- function(city, token){
  
  url <- paste("https://api.foursquare.com/v2/venues/explore?ll=", city,
               "&radius=2000&oauth_token=", token,
               "&v=", format(Sys.Date(), format="%Y%m%d"), sep="")
  jsonOutput <- getURL(url)
  treeLoaded <- fromJSON(jsonOutput)
  checkinscount = ""
  tipcount = ""
  for(n in 1:length(treeLoaded$response$groups[[1]]$items)) {
    checkinscount[n] <- treeLoaded$response$groups[[1]]$items[[n]]$venue$stats["checkinsCount"]
    tipcount[n] <- treeLoaded$response$groups[[1]]$items[[n]]$venue$stats["tipCount"]
  }
  return(as.data.frame(cbind(checkinscount, tipcount)))
}

shinyServer(function(input, output){
  
  data <- reactive({
    city <- input$city
    if(city == "London") coord = "51.507222,-0.1275"
    if(city == "New York") coord = "41.145556,-73.995"
    if(city == "Hong Kong") coord = "22.3,114.2"
    if(city == "Berlin") coord= "52.516667,13.383333"
    fsq <- foursquare(coord, "2RAVKH1T4EFVBFROKNIIY1VIEYUKU5BS2QCGWM2WVUVCARVK")
    data.frame(X=as.numeric(as.character(fsq[, 1])), Y=as.numeric(as.character(fsq[, 2])))
  })
  
  output$plot <- renderPlot({
    plot(data(), xlab="Checkins", ylab="Tips")
    if(input$line) {
      abline(lm(Y ~ X, data=data()), col="dark blue")
    }
    if(input$means) {
      abline(v = mean(data()[,1]), lty="dotted")
      abline(h = mean(data()[,2]), lty="dotted")
    } 
    if(input$ant) {
      model = lm(Y ~ X, data=data())
      txt = paste("The equation of the line is:\nY = ",
                  round(coefficients(model)[1],0)," + ",
                  round(coefficients(model)[2],3),"X + error")
      
      boxed.labels(50,600,labels=txt,bg="white", cex=1.25)
    }    
    
  })
  
  output$summary <- renderPrint({
    model = lm(Y ~ X, data=data())
    summary(model)
  })
  
})