df = read.csv('D:/KULIAH DATA SCIENCE/PROJECT/GITHUB/Latihan 2 - RStudio/fashion-mnist_test.csv', header = FALSE)

View(df)

#library(audio)
#play(sin(1:10000/20))

#x = rnorm(100)
#y = rnorm(100, sd - 10)
#df = data.frame(x, y)
#View(df)

library(ggplot2)



ggplot(df, aes(x = x,y = y)) + geom_point()

View(mtcars)
my_scatplot <- ggplot(mtcars,aes(x=wt,y=mpg)) + geom_point()
my_scatplot + xlab('Berat (x 1000kg)') + ylab('Km per liter') + geom_smooth()


library(datasets)
data("iris")
View(iris)
unique(iris$Species)

library(GGally)

ggpairs(iris, mapping=ggplot2::aes(colour = Species))

library(shiny)

library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))

names(r_colors) <- colors()

ui <- fluidPage(
  
  leafletOutput("mymap"),
  
  p(),
  
  actionButton("recalc", "New points"),
  
  p(),
  
  textOutput("coordinates")
  
)

server <- function(input, output, session) {
  
  points <- eventReactive(input$recalc, {
    
    points = cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    View(points)
    
    output$coordinates <- renderText({
      
      points
      
    })
    
    return(points)
    
  }, ignoreNULL = FALSE)
  
  observeEvent(input$Map_shape_click, { # update the location selectInput on map clicks
    
    output$coordinates <- renderText({
      
      "You have selected this"
      
    })
    
  })
  
  output$mymap <- renderLeaflet({
    
    leaflet() %>%
      
      addProviderTiles(providers$Stamen.TonerLite,
                       
                       options = providerTileOptions(noWrap = TRUE)
                       
      ) %>%
      
      addMarkers(data = points())
    
  })
  
}

shinyApp(ui, server)


