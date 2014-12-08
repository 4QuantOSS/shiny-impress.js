shinyServer(function(input, output) {
  get.ccm<-reactive({
    ccm.fcns[[input$ccm]](input$slide_count,input$con_frac/100)
  })
  
  get.graph<-reactive({
    make.graph(get.ccm())
  })
  
  get.layout<-reactive({
    gpos<-layout.fcns[[input$layout]](get.graph())
    if(ncol(gpos)<3) {
      cbind(gpos,0*gpos[,1])
    } else {
      gpos
    }
  })
  
  get.slides<-reactive({
    slide.names<-V(get.graph())$name
    slide.pos<-get.layout()
    
    # rough estimate of the scales
    xsc<-input$slide_width*sqrt(input$slide_count)*input$spacing/100
    ysc<-input$slide_height*sqrt(input$slide_count)*input$spacing/100
    # normalize the positions (for the overview slide)
    pos.nrm<-function(x) {
      dsx<-diff(range(x))
      if(dsx>0) {
        2*(x-min(x))/dsx-1
      } else {
        x
      }
    }
    xpos<-xsc*pos.nrm(slide.pos[,1])
    ypos<-ysc*pos.nrm(slide.pos[,2])
    zpos<-xsc*pos.nrm(slide.pos[,3])
    data.frame(x=xpos,
               y=ypos,
               z=zpos,
               scale=1+runif(input$slide_count,min=-1,max=5)*input$scale_noise/100,
               angle=runif(input$slide_count,min=-180,max=180)*input$angle_noise/100,
               angle.x=runif(input$slide_count,min=-180,max=180)*input$angle_noise/100,
               angle.y=runif(input$slide_count,min=-180,max=180)*input$angle_noise/100,
               content=slide.names)
  })
  output$preview <- renderUI({
    renderImpress(get.slides(),use.iframe=T,
                  width=input$frame_width,
                  height=input$frame_height,
                  slide.width=input$slide_width,
                  slide.height=input$slide_height,
                  font.size=input$font_size,
                  spacing=input$spacing/100
                  )
  })
  
  output$slide_positions<-renderDataTable({
    get.slides()
  })

  output$sourcecode <- renderPrint({
    renderImpress(get.slides(),use.iframe=F,
                  width=input$frame_width,
                  height=input$frame_height,
                  slide.width=input$slide_width,
                  slide.height=input$slide_height,
                  font.size=input$font_size,
                  spacing=input$spacing/100
                  )
  })
  
  output$igraph_plot <- renderPlot({
    draw.graph(get.graph(),get.layout())
  })
})