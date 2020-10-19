
<!-- README.md is generated from README.Rmd. Please edit that file -->

# YesNoDetect

<!-- badges: start -->

<!-- badges: end -->

YesNoDetect is a shiny application for the prediction of handwritten ✅
or ❌ boxes.

It is written using the golem framework for production-grade and robust
shiny apps. The shiny app is embedded inside the structure of an R
package which allows not only a concise and well structured workflow but
also the integration of documentation (roxygen2) and tests (testthat).
The prediction model is a convolutional neural network (CNN) implemented
via the Keras API of Tensorflow.

The main objectives for me writing this code were to get to know the
following:

  - **golem**: framework for building production-grade shiny
    applications
  - **shinymodules**: modularize shiny apps
  - **tensorflow/ keras**: modeling deep neural networks

I also used the following (to me new) packages:

  - fullPage: fullPage.js framework for shiny
  - waiter: waiting screens for shiny
  - emo: emojis 😜
  - googlesheets4: use googlesheets (as database)

## Online version

Have a look at the live version:
[Link](https://esommer.shinyapps.io/YesNoDetect/)

Note: The application is built as a desktop application and thus is not
fully operational on touchscreens.

## Installation

You can install the current version of YesNoDetect with the following
line of code:

``` r
# install.packages("devtools")
devtools::install_github("EmanuelSommer/YesNoDetect")
```

You can run the app locally by calling the following:

``` r
YesNoDetect::run_app()
```

## Structure of the app

  - **Database**: Explore and amend the database which is the foundation
    of the modeling process.
  - **Model**: The current model architecture, stats and valuation
    metrics.
  - **Predict**: Challenge the model with your handwritten boxes\!

### Database

![Database overview section](demo_pictures/db_overview.png)

![Amend database section](demo_pictures/db_amend.png)

### Model

![Model architecture](demo_pictures/model_scheme.png)

![Model stats](demo_pictures/model_metrics.png)

### Predict\!

![Predict\!](demo_pictures/predict.png)

## Known issues

#### Drawing not very intuitive

The drawing is not done by clicking, holding and releasing the mouse but
by click, hover and click again. This is not the intuitive way. As the
drawing was implemented by an interactive plot using the hover and click
parameters I could not find a way to change to the intuitive way of
drawing. Moreover I did not find any other (no interactive plots)
solutions for handdrawing in shiny apps and efficiently saving the
drawing numerically.

#### Not touch friendly

The app is not touch friendly this does not only apply to the drawing of
the boxes but the whole fullPage UI seems not to work on mobile well at
all. To deal with this one could switch to shinyMobile but I will try
this out another time.

**If you have any suggestions to solve the known issues or you have new
ones I would really like to hear from you\!**

-----

<center>

👋 **Have fun\!** 👋

</center>
