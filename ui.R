shinyUI(pageWithSidebar(
  headerPanel("Impress Graph Demo"), 
  sidebarPanel(
    sliderInput('slide_count', 'Slide Count', min=1, max=100,value=15),
    sliderInput('slide_width', 'Slide Width', min=50, max=2000,value=100),
    sliderInput('slide_height', 'Slide Height', min=50, max=2000,value=100),
    sliderInput('font_size', 'Font Size', min=5, max=200,value=24)
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview",includeMarkdown("README.md")),
      tabPanel("Graph",
               selectInput('layout','Layout Type:',ls(layout.fcns),selected="Circle"),
               plotOutput('igraph_plot')
      ),
      tabPanel("Slides", 
               sliderInput('frame_width', 'Frame Width', min=100, max=2000,value=300),
               sliderInput('frame_height', 'Frame Height', min=100, max=2000,value=300),
               htmlOutput("preview",inline=T)
      ),
      tabPanel("Source Code",
               h3(textOutput("sourcecode"))
               )
    )
  )
))