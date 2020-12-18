# Push Notes to Athlete's Phones
A minimal athlete dashboard app built in Shiny that enables coaches to send notes directly to an athletes's phone from within the dashboard.

## Demo

![](push00.gif)

## Content
This shiny app uses the package [{pushover}](https://cran.r-project.org/web/packages/pushoverr/pushoverr.pdf) to let users send notifications to an athlete's mobile phone directly from the R shiny dashboard. Steps I followed build the app:

#### Register on Pushover

* Register an account on pushover (it offers a free trial)
* Create a pushover app
* Both, the *user key* and *pushover app* keys provided during the registration process will be needed for the shiny app.

**For step-by-step intructions on how to create a pushover account (and a pushover app) check this [this tutorial](https://github.com/briandconnelly/pushoverr)

Alternatively, you can choose other notification services such as [slack](https://github.com/hrbrmstr/slackr), [pushbullet](https://cran.r-project.org/web/packages/RPushbullet/index.html), etc.. depending on your organization's requirements.

#### Shiny APP

* Download your data and format your dashboard. I did that [here](https://github.com/josedv82/Push_Notes_to_Athlete/blob/master/data.R). I re-used a table dashboard I had previously created [here](https://github.com/josedv82/graphicalDT). 

* Next I added a column with action buttons. On this [code](https://github.com/josedv82/Push_Notes_to_Athlete/blob/master/data.R), towards the end I added a mutate statement that contains this part of the code. The important thing here is, no matter whether you have a table with 5 or 500 hundred rows, each button has a unique id. This means you only need to create one modal and one observeEvent later in the app, instead of having to create one for each different row/button.

* Finally, design your app UI and Server. My code example is [here](https://github.com/josedv82/Push_Notes_to_Athlete/blob/master/app.R)

#### Disclaimer

The raw data and images for this example were downloaded using the NBAstatR package.

