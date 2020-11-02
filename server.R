library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    dcalc <- reactive({
        p <- input$n_point
        t <- input$times
        s1 <- input$size
        n1 <- input$n
        
        i <- seq(0,1,length.out = p)
        dat <- vector(mode = "numeric", length = t)
        for (x in 1:t) {
            prob = vector(mode = "numeric", length = s1)
            for (s in 1:s1) {
                m0 <- cbind(sample(i, n1, replace = TRUE),
                            sample(i, n1, replace = TRUE))
                m <- t(apply(m0, 1, sort))
                for (k in 1:n1) {
                    if (all(m[,2][k]>=m[,1][-k]) && all(m[,1][k]<=m[,2][-k])) {
                        prob[s] <- 1
                        break
                    }
                }
            }
            dat[x] <- mean(prob)
        }
        dat
    })
    
    output$Mean <- renderText({mean(dcalc())})
    output$SE <- renderText({sd(dcalc())/sqrt(length(dcalc()))})
    
    output$plot <- renderPlot({
        with(plot(dcalc(), xlab = "Times", ylab = "Probability", type = "l"),
             abline(h = mean(dcalc()), col= "blue"))

    })

})
