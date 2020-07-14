#
#
#
## app.R ##
library(shiny)
library(shinydashboard)

library(ggplot2)
library(flair)

ui <- dashboardPage(
  dashboardHeader(title="Mémo parcours R",
                  titleWidth = 250),
  dashboardSidebar(
    width = 250,
    sidebarMenu(
      menuItem("Présentation de R", tabName = "Present", icon = icon("glasses")),
      menuItem("Statistiques descriptives", tabName = "Stat_desc", icon = icon("calculator")),
      menuItem("Manipulation de données", tabName = "Manip_data", icon = icon("columns")),
      menuItem("Statistiques bivariées", tabName = "Stat_bi", icon = icon("chart-line")),
      menuItem("Manipulation de données 2", tabName = "Manip_data2", icon = icon("table")),
      menuItem("Graphiques", tabName = "Graph", icon = icon("chart-bar")),
      menuItem("Mise en forme de sorties", tabName = "Sortie", icon = icon("archive"),badgeLabel = "new", badgeColor = "green")

    )
  ),
  dashboardBody(
    tabItems(
      # 1ere rubrique--------
      tabItem(tabName = "Present",
              h2("Rstudio - un EDI pour coder en R")
      ),

      # 2eme rubrique------------
      tabItem(tabName = "Stat_desc",
              h2("Produire vos premières statistiques"),
              tabsetPanel(type = "tabs",
                          tabPanel("Dessin de fichier"),
                          tabPanel("Fichier détail"),
                          tabPanel("Statistiques")
              )
      ),

      # 6eme rubrique-------------
      tabItem(tabName = "Graph",
              h2("Produire vos graphiques"),
              tabsetPanel(type = "tabs",
                          tabPanel("Histogramme",
                                   fluidRow(
                                     box(title = " histogramme", height=350, status = "primary", solidHeader = TRUE,
                                         plotOutput("plot1", height = 250)),

                                     box(
                                       title = "paramètrage", height=350, status = "warning", solidHeader = TRUE,
                                       sliderInput("slider", "Nombre d'observations:", 0, 1000, 500),
                                       sliderInput("moy", "Moyenne", -100, 100, 0),
                                       sliderInput("ec_t", "Ecart-type", 0, 10, 1)
                                     )
                                   ),
                                   fluidRow(
                                     box(

                                       title = "code R", background = "light-blue",
                                       textOutput("hist_code")
                                     )

                                   )),
                          tabPanel("Diagramme circulaire"),
                          tabPanel("Nuage de points")
              )

      )
    )
  )
)

server <- function(input, output) {

  output$plot1 <- renderPlot({
    set.seed(122)
    histdata <- rnorm(1000,mean=as.numeric(input$moy), sd=as.numeric(input$ec_t))

    data <- histdata[seq_len(input$slider)]
    ggplot() +
      aes(x=data) +
      geom_histogram(bins = 30L, fill = "#6baed6") +
      labs(x = "valeur de la variable d'intérêt", title = paste("Histogramme d'une loi normale (moyenne =",input$moy,", écart-type =", input$ec_t,")")) +
      theme_minimal()
    #hist(data,col = "lightblue", main = paste("Histogramme d'une loi normale (moyenne =",input$moy,", écart-type =", input$ec_t,")"))
  })

  output$hist_code <- renderText({
    paste("ggplot() +
          aes(x=rnorm(n=", input$slider,", mean=",input$moy,", sd=", input$ec_t,")) +
          geom_histogram(bins = 30L, fill = '#6baed6') +
          labs(x = 'valeur de la variable', title = ' ", paste("Histogramme de la loi normale (moyenne =",input$moy,", écart-type =", input$ec_t,")')"),"+
          theme_minimal()")

  })
}

shinyApp(ui, server)
