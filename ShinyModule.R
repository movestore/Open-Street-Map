library('move')
library('ggmap')
library('shiny')

shinyModuleUserInterface <- function(id, label, num, col) {
  ns <- NS(id)

  tagList(
    titlePanel("Open Street map"),
    sliderInput(inputId = ns("num"), 
                label = "Choose a margin size", 
                value = num, min = 0, max = 30),
    plotOutput(ns("map"),height="90vh")
  )
}

shinyModuleConfiguration <- function(id, input) {
  ns <- NS(id)
  
  configuration <- list()
  
  configuration
}

shinyModule <- function(input, output, session, data, col, num) {
  current <- reactiveVal(data)

  osmap <- reactive({
    map <- get_map(bbox(extent(data)+c(-input$num,input$num,-input$num,input$num)))
  
    out <- ggmap(map) +
      geom_path(data=as.data.frame(data),aes(x=location_long,y=location_lat,group=local_identifier),colour=col)
    out
    })

  output$map <- renderPlot({
    osmap()
  })
  
  return(reactive({ current() }))
}

