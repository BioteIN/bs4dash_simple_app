

#Criar reatives

topup_filter_tbl <- reactive({
  
  result <- topup_dat %>% filter(between(CREATED_AT, input$dateRange[1], input$dateRange[2]))
  
  return(result)
  
})

# 3.0 manipulacao de dados ------------------------------------------------

total.revenue <- reactive({
  
  sum(topup_filter_tbl()$AMOUNT)
  
})


sales.account <-  reactive({ topup_filter_tbl() %>% group_by(CREATED_AT) %>% summarise(value = sum(QYT)) %>% filter(value==max(value))})

prof.prod <- reactive({topup_filter_tbl() %>% group_by(format(CREATED_AT, "%m")) %>% summarise(value = sum(AMOUNT)) %>% filter(value==max(value))})

day.rec <- reactive({topup_filter_tbl() %>% group_by(format(CREATED_AT, "%m")) %>% summarise(value = sum(AMOUNT)) %>% filter(value==max(value))})


#conteudo reactives ------------------
output$value1 <- renderValueBox({
  valueBox(
    formatC(sales.account()$value, format="d", big.mark=',')
    ,paste('Quantidade de Recargas Vendidas',sales.account()$Account)
    
    ,color = "purple")
  
  
})



output$value2 <- renderValueBox({
  
  valueBox(
    formatC(total.revenue(), format="d", big.mark=',')
    ,'Valor Total das Recargas Vendidas'
    
    ,color = "red")
  
})



output$value3 <- renderValueBox({
  
  valueBox(
    formatC(prof.prod()$value, format="d", big.mark=',')
    ,paste('Valor de Recargas Mensais',prof.prod()$value)
    
    ,color = "yellow")
  
})

# Valeu Box ---------------------------------------------------------------



#frow1 <- fluidRow(
#  valueBox(
#    formatC(sales.account()$value, format="d", big.mark=',')
#    ,paste('Quantidade de Recargas Vendidas',sales.account()$Account)
#    ,icon = icon("stats",lib='glyphicon')
#    ,color = "purple"
#  ),
#  bs4InfoBox(
#    title = " Valor Total das Recargas Vendidas",
#    value = formatC(prof.prod()$value, format="d", big.mark=','),
#    icon = icon("gbp",lib='glyphicon'),
#    color = "red"
#  )
#  ,
#  bs4InfoBox(
#    title = " Valor de Recargas Mensais",
#    value = formatC(total.revenue()$value, format="d", big.mark=','),
#    icon = icon("menu-hamburger",lib='glyphicon')
#    ,color = "yellow"
#  )
  
  # valueBoxOutput("value1")
  # ,valueBoxOutput("value2")
  # ,valueBoxOutput("value3")
#)

frow1 <- fluidRow(
  valueBoxOutput("value1")
  ,valueBoxOutput("value2")
  ,valueBoxOutput("value3")
)




# 2.0 Graficos ------------------------------------------------------------

output$revenuebyPrd <- renderPlot({
  ggplot(data = topup_filter_tbl(), 
         aes(x=CREATED_AT, y=AMOUNT, fill=factor(SEGMENTATION_ID))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Valor (em Meticais)") + 
    xlab("Data") + theme(legend.position="bottom" 
                         ,plot.title= element_text(size=15, face="bold")) + 
    ggtitle("Valor das Vendas por data") + labs(fill = "Tipo")
})


output$revenuebyRegion <- renderPlot({
  ggplot(data = topup_filter_tbl(), 
         aes(x=SEGMENTATION_ID, y=AMOUNT, fill=factor(SEGMENTATION_ID))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Valor (em Meticais)") + 
    xlab("Tipo de Recarga") + theme(legend.position="bottom" 
                                    ,plot.title= element_text(size=15, face="bold")) + 
    ggtitle("Valor das Vendas por tipo") + labs(fill = "Tipo")
})


frow2 <- fluidRow(
  
  box(
    title = "Vendas por Datas"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyPrd", height = "300px")
  )
  
  ,box(
    title = "Vendas pelo tipo de recargas"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyRegion", height = "300px")
  ) 
  
)

frow3 <- tabItem(tabName = "item_2",
                 h2(" ")
)




# output$value1 <- renderValueBox({
#   valueBox(
#     formatC(sales.account$value, format="d", big.mark=',')
#     ,paste('Quantidade de Recargas Vendidas',sales.account$Account)
#     ,icon = icon("stats",lib='glyphicon')
#     ,color = "purple")
#   
#   
# })



output$vendas_por_data_UI <- renderUI({
  
  
    tagList(
      frow1,
      frow2,
      frow3
      
    )
})
