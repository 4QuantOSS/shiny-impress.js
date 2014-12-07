shinyUI(pageWithSidebar(
  headerPanel("Impress Graph Demo"), 
  sidebarPanel(
    sliderInput('slide_count', 'Slide Count', min=1, max=100,value=10),
    sliderInput('slide_width', 'Slide Width', min=50, max=2000,value=150),
    sliderInput('slide_height', 'Slide Height', min=50, max=2000,value=100),
    sliderInput('font_size', 'Font Size', min=5, max=200,value=20)
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview",includeMarkdown("README.md")),
      tabPanel("Graph",
               selectInput('layout','Layout Type:',ls(layout.fcns),selected="Circle"),
               sliderInput('con_frac', 'Connectivity (%)', min=0, max=100,value=20),
               plotOutput('igraph_plot')
      ),
      tabPanel("Slides", 
               sliderInput('frame_width', 'Frame Width', min=100, max=2000,value=500),
               sliderInput('frame_height', 'Frame Height', min=100, max=2000,value=500),
               helpText(h4("Click inside the frame to use the keyboard <- and -> to navigate")),
               htmlOutput("preview",inline=T)
      ),
      tabPanel("Source Code",
               h3(textOutput("sourcecode"))
               )
    )
  )
))