data <- reactive({
  set.seed(2)
  nodes <- data.frame(id = 1:15, label = paste("Label", 1:15),
                      group = sample(LETTERS[1:3], 15, replace = TRUE))
  
  edges <- data.frame(id = 1:15, from = trunc(runif(15)*(15-1))+1,
                      to = trunc(runif(15)*(15-1))+1)
  list(nodes = nodes, edges = edges)
})

output$network_proxy_options <- renderVisNetwork({
  visNetwork(data()$nodes, data()$edges) %>% visLegend()
})

observe({
  visNetworkProxy("network_proxy_options") %>%
    visOptions(highlightNearest = input$highlightNearest)
})

observe({
  visNetworkProxy("network_proxy_options") %>%
    visOptions(nodesIdSelection = input$nodesIdSelection)
})

observe({
  if(length(input$selectedby) > 0){
    visNetworkProxy("network_proxy_options") %>%
      visOptions(selectedBy = list(variable = "group", values = input$selectedby))
  }else{
    visNetworkProxy("network_proxy_options") %>%
      visOptions(selectedBy = NULL)
  }

})

output$code_proxy_options  <- renderText({
  '
observe({
  visNetworkProxy("network_proxy_options") %>%
    visOptions(highlightNearest = input$highlightNearest)
})

observe({
  visNetworkProxy("network_proxy_options") %>%
    visOptions(nodesIdSelection = input$nodesIdSelection)
})

observe({
  if(length(input$selectedby) > 0){
    visNetworkProxy("network_proxy_options") %>%
      visOptions(selectedBy = list(variable = "group", values = input$selectedby))
  }else{
    visNetworkProxy("network_proxy_options") %>%
      visOptions(selectedBy = NULL)
  }

})
 '
})