#' Lanceur de l'application rfornoob
#'
#' @return la fonction lance l'application
#' @import shiny
#' @import shinydashboard
#' @import ggplot2
#' @import flair
#' @export
shiny_novices <- function() {  appDir <- system.file("Memo", package = "rfornoob")  ;shiny::runApp(appDir, display.mode = "normal")}
