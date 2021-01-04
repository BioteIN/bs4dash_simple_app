tabText3 <- "hello tab data here"

recarregamento_tab <- bs4TabItem(
  tabName = "vendas_por_data",
  uiOutput("vendas_por_data_UI") %>% withSpinner(),
  
  tabText3
)
