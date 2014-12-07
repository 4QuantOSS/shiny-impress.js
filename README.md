## About
A simple tool for using R's igraph libraries to automatically generate impress.js presentations. The idea is that many of these style presentations are based on trees or graphs and R already has very good tools for coming up with different layouts for these trees.

## Tabs
### Graph
Shows the graph rendering itself using the built-in plot.igraph function, it is pretty boring, but shows the general layout.

### Slides
Shows the presentation itself in an iframe. Some browsers do not like this, in which case just use the source in the next panel.

### Source
The source code for the presentation, since the iframe ```srcdoc```, makes it pretty un-readable. The formatting is ugly, if I find a pretty.html function somewhere, I'll use it.

## Credits
This project took advantage of the great tools developed at 
- http://jmpressjs.github.io/jmpress.js/#/home
- http://wmh.github.io/circular-slides-generator/
- and of course the RStudio Shiny documentation
