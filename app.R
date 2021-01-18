if (interactive()) {
  library(shiny)
  library(bs4Dash)
  library(tidyverse)
  library(shinycssloaders)
  
  source(file = "global.R", local = TRUE)
  source(file = "ui/recarregamento_tab.R", local = TRUE)
  source(file = "ui/segmentacao_tab.R", local = TRUE)
  source(file = "ui/vendas_por_data_tab.R", local = TRUE)
  source(file = "ui/vendas_por_tipo_tab.R", local = TRUE)
  
  shinyApp(
    ui = bs4DashPage(
      bs4DashNavbar(
        skin = "light",
        status = NULL,
        border = TRUE,
        sidebarIcon = "bars",
        compact = FALSE,
        controlbarIcon = "th",
        leftUi = NULL,
        rightUi = NULL
      )
      ,
      bs4DashSidebar(
        inputId = NULL,
        disable = FALSE,
        title = NULL,
        skin = "dark",
        status = "primary",
        brandColor = NULL,
        url = NULL,
        src = NULL,
        elevation = 4,
        opacity = 0.8,
        expand_on_hover = TRUE,
        bs4SidebarMenu(
          id = "test",
          bs4SidebarHeader("Menu Principal"),
          bs4SidebarMenuItem(
            tabName = "recarregamento",
            text = "Recarregamento"
          ),
          bs4SidebarMenuItem(
            tabName = "segmentacao",
            text = "Segmentação de Clientes"
          ),
          bs4SidebarMenuItem(
            tabName = "vendas_por_data",
            text = "Vendas por Data"
          ),
          bs4SidebarMenuItem(
            tabName = "vendas_por_tipo",
            text = "Vendas por Tipo"
          )
      )
      ),
      bs4DashControlbar(),
      bs4DashBody(
        dateRangeInput('dateRange',
                       label = 'Pesquisa por Data',
                       start = Sys.Date() - 90, end = Sys.Date()
        ),
       bs4TabItems(
         recarregamento_tab,
         segmentacao_tab
        
       )
      ),
      title = "AttachmentBlock"
    ),
    server = function(input, output) { 
      source(file = "server/01_srv_recarregamento.R", local = TRUE)
      source(file = "server/02_srv_vendas_por_data.R", local = TRUE)
      source(file = "server/03_srv_vendas_por_tipo.R", local = TRUE)
      
      }
  )
}
