library(shiny)

make.style<-function(...) tags$style(make.style.text(...))

make.style.text<-function(width=150,height=150,font=48) {
  paste('body {
  background-image: url(//wmh.github.io/circular-slides-generator/static/img/noise.png);
}
        .step {
        position: relative;
        padding: 10px;
        margin: 0 auto;
        -webkit-box-sizing: border-box;
        -moz-box-sizing:    border-box;
        -ms-box-sizing:     border-box;
        -o-box-sizing:      border-box;
        box-sizing:         border-box;
        font-family: "PT Serif", georgia, serif;
        font-size: ',font,'px;
        line-height: 1.5;
        }
        .slide {
        display: block;
        width: ',width,'px;
        height: ',height,'px;
        padding: 20px 20px;
        background-color: white;
        border: 1px solid rgba(0, 0, 0, .3);
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, .1);
        color: rgb(102, 102, 102);
        text-shadow: 0 2px 2px rgba(0, 0, 0, .1);
        font-family: "Open Sans", Arial, sans-serif;
        }
        .credits, .credits h2 {
        padding-top: 0;
        }
        ',sep='')
}


# To be called from server.R
renderImpress <- function(slides.df,use.iframe=T,width="400px", height="400px",slide.width=200,slide.height=200,font.size=24,spacing=1) {
  slides.data<-lapply(as.list(1:dim(slides.df)[1]), function(x) slides.df[x[1],])
  slide.fun<-function(x,y,z,scale,angle,content,angle.x=0,angle.y=0) 
    div(class="step slide","data-x"=x,"data-y"=y,"data-z"=z,
        "data-rotate-z"=angle,"data-rotate-x"=angle.x,"data.rotate.y"=angle.y,"data-scale"=scale,
        h2(content),tags$ul(tags$li("Stuff"),tags$li(paste("More about",content))))
  overview.slide<-div(class="step","data-x"=0,"data-y"=0,"data-scale"=spacing/2*nrow(slides.df))
  
  slides<-lapply(slides.data,function(cslide) slide.fun(cslide$x,cslide$y,cslide$z,
                                                        cslide$scale,cslide$angle,cslide$content,
                                                        angle.x=cslide$angle.x,angle.y=cslide$angle.y))
  nslides<-list()
  nslides[[1]]<-overview.slide
  nslides[c(2:(length(slides)+1))]<-slides
  slides.html<-tags$html(
    tags$body(
      make.style(slide.width,slide.height,font=font.size),
      tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"),
      tags$script(src="https://jmpressjs.github.io/jmpress.js/dist/jmpress.all.min.js")
      ,
      div(id="impress",
          nslides
      ),
      tags$script("$(function() {
                  $('#impress').jmpress();
});")
    )
  )
  if(use.iframe) {
    tags$iframe(width=validateCssUnit(width),height=validateCssUnit(height),
                srcdoc=tagList(slides.html)
    )
  } else {
    slides.html
  }  
}


credit.slide<-'<div class="step slide credits" data-x="-730" data-y="-873" data-rotate="240" data-scale="1">
  <h2>Credits</h2>
  <ul>
  <li>
  <a href="http://bartaz.github.io/impress.js" target="_blank">impress.js</a> - Bartek Szopka
</li>
  <li>
  <a href="http://wmh.github.io/circular-slides-generator" target="_blank">Circular Slides Generator</a> - Hunter Wu
</li>
  </ul>
  </div>
  <div class="step" data-x="0" data-y="0" data-scale="4"></div>
  '


