
shinyServer(function(input, output) {
  get.graph<-reactive({
    make.random.graph(nodes=input$slide_count,con.frac=input$con_frac/100)
  })
  get.layout<-reactive({
    layout.fcns[[input$layout]](get.graph())
  })
  get.slides<-reactive({
    slide.names<-V(get.graph())$name
    slide.pos<-get.layout()
    # rough estimate of the scales
    xsc<-input$slide_width*sqrt(input$slide_count)
    ysc<-input$slide_height*sqrt(input$slide_count)
    data.frame(x=xsc*slide.pos[,1],y=ysc*slide.pos[,2],
                          scale=1,angle=0,
                          content=slide.names)
  })
  output$preview <- renderUI({
    renderImpress(get.slides(),use.iframe=T,
                  width=input$frame_width,
                  height=input$frame_height,
                  slide.width=input$slide_width,
                  slide.height=input$slide_height,
                  font.size=input$font_size
                  )
  })

  output$sourcecode <- renderPrint({
    renderImpress(get.slides(),use.iframe=F,
                  width=input$frame_width,
                  height=input$frame_height,
                  slide.width=input$slide_width,
                  slide.height=input$slide_height,
                  font.size=input$font_size
                  )
  })
  
  output$igraph_plot <- renderPlot({
    draw.graph(get.graph(),get.layout())
  })
})