# Push Notes to Athlete's Phones
A basic athlete dashboard built in Shiny that enables coaches send notes directly to athletes's phone from the app.

## Demo

[](push00.gif)

## Content
This shiny app uses the package {pushover} to add the functionality to send notifications to athletes mobile phones directly from the dashboard. Steps to build the app:

#### Register on Pushover

* Register an account in pushover (it offers a free trial)
* Create an app
* Both the user key and pushover app keys provided during the registration process will be needed for the shiny app.

** For further intructions on how to do this follow [this tutorial](https://github.com/briandconnelly/pushoverr)

Alternatively, you can choose other options such as [slack](https://github.com/hrbrmstr/slackr), [pushbullet](https://cran.r-project.org/web/packages/RPushbullet/index.html), etc.. depending on your organization's requirements.

#### Shiny APP

* Download your data and format your dashboard. I did this [here](https://github.com/josedv82/Push_Notes_to_Athlete/blob/master/data.R). Notice the addition on the final join statement of the functionality that enables to add multiple buttons to a table with a different id, which means you only need to create one modal or one observeEvent.

* Design your app. Example my code is [here](https://github.com/josedv82/Push_Notes_to_Athlete/blob/master/app.R)

#### Disclaimer

The raw data and images for this example were downloaded using the NBAstatR package.

