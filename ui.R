library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("The overlapping interval simulation"),

    # Sidebar with a slider input
    sidebarLayout(
        sidebarPanel(
            sliderInput("n_point",
                        "Number of points p:",
                        min = 3,
                        max = 301,
                        value = 30),
            sliderInput("n",
                        "Number of intervals n:",
                        min = 2,
                        max = 300,
                        value = 30),
            sliderInput("size", 
                        "Number of experiments:",
                        min = 1,
                        max = 150,
                        value = 20),
            sliderInput("times",
                        "Number of repeats:",
                        min = 2,
                        max = 100,
                        value = 15),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h2("Sypnosis"),
            h4("Draw p points between [0,1] (both 0 and 1 are counted in p) that
            are equally distanced and randomly draw n line segments (n > 1) that
            connect any 2 points from p points. What is the probability that 
            there is at least 1 line segment that overlaps with all other line segments?"),
            h4("Use the computer to run experiments and repeat those procedure 
               to estimate the mean of probability"),
            h3("Mean estimation of probability", textOutput("Mean")),
            h5("Standard Error", textOutput("SE")),
            plotOutput("plot")
        )
    )
))
