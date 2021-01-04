tabText4 <- "hello tab tipo here"

recarregamento_tab <- bs4TabItem(
  tabName = "vendas_por_tipo",
  uiOutput("vendas_por_tipo_UI") %>% withSpinner(),
  
  tabText4
)
