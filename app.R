
#Jose Fernandez
#Sample Table to Push Notes to Players
# Sep 2020

############################################

#load libraries
library(shiny)
library(shinyWidgets)
library(pushoverr)
library(tidyverse)
library(htmlwidgets)
library(htmltools)
library(formattable)
library(sparkline)
library(feather)
library(DT)
library(shinyjs)

############################################

#load data + preformatted table
source("data.R")

###########################################

#user interface
ui <- fluidPage(
  
  #dependencies
  getDependency('sparkline'),
  useShinyjs(),
  
  column(width = 8,
  DTOutput("table")
  
  )
)

###########################################

#server logic
server <- function(input, output){
  
#Interactive table
  output$table <- renderDT(table2, 
                           rownames = F,
                           escape = F,
                           selection = 'single',
                           class = 'white-space: nowrap',
                           colnames = c("Photo", "Player", "Total Load", "Load Trend", "Load Dist", "Total Mins", "Mins Trend", "Mins Dist","Games", "B2B", "SMS"),
                           options = list(dom = 'tp',
                                          pageLength = 100,
                                          bSort=F,
                                          drawCallback = htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}'),
                                          columnDefs = list(
                                            list(className = 'dt-center', targets = 0:10),
                                            list(width = '150px', targets = c(1)),
                                            list(width = '70px', targets = c(0)),
                                            list(width = '70px', targets = c(2,3,4,5,6,7)),
                                            list(width = '50px', targets = c(8,10))
                                          ),
                                          
                           paging = F))
                  
  
#First modal to type and send the message 
  
  for(i in 1:nrow(table2)){
    onclick(paste0("inf",i), {
      
      showModal(
        modalDialog(
          HTML(as.character(table2$Photo[input$table_rows_selected])),
          h4(table2$Player[input$table_rows_selected]),
          textAreaInput("text", label = "", value = "", placeholder = "Type note...", width = "560px"),
          footer = actionButton("send","Send Notification"),
          easyClose = T
  
          )
      )
      
    })
    
  }
  
# Second modal to confirm message was sent and execute Pushover code
  observeEvent(input$send, {
    
    removeModal()
    
    showModal(modalDialog(
      title = HTML(paste(h3("Sent!"),  div(img(src="https://www.iconspng.com/uploads/primary-ok/primary-ok.png", width="10%")) , sep = " ")),
      HTML(paste(tags$strong("Your Note:"), 
                 "<br/>",  
                 "<br/>", 
                 tags$span(style="color:darkgrey", as.character(input$text)), 
                 "<br/>",
                 "<br/>",
                 tags$strong("To: "),
                 "<br/>",
                 tags$span(style="color:dodgerblue", table2$Player[input$table_rows_selected]),
                 "<br/>",
                 sep = "")), 
      easyClose = T))
    
           pushover(message = as.character(input$text), 
                    user = "your_user_key_here", 
                    app = "your_app_key_here")
        
    
       })
  
}

############################################

shinyApp(ui, server)

############################################
