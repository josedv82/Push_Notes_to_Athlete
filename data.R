
#Jose Fernandez
#Sample Table to Push Notes to Players
# Sep 2020

#####################################################################################

#load library
library(tidyverse)

######################################################################################

#load raw data (the raw data is not provided for this example)
game_logs <- read_feather("gamelogs.feather") %>% 
  filter(Season == "2019-20") %>%
  mutate(Month = lubridate::month(Date), Week = lubridate::week(Date)) %>%
  filter(Month == 1) %>%
  filter(Team == "Los Angeles Clippers")


######################################################################################

#format table + add button column
weekLoad <- game_logs %>%
  group_by(Player) %>%
  mutate(Date2 = lag(Date)) %>%
  mutate(dates = Date - Date2) %>% 
  mutate(B2B = ifelse(is.na(dates), 0, ifelse(dates == 1, 1, 0))) %>% 
  summarise(Games = n(), 
            totalMins = sum(MINS),
            
            M.Trend = spk_chr(MINS, 
                              type = "line", 
                              lineColor = "deeppink", 
                              fillColor = "transparent", 
                              minSpotColor = "skyblue",
                              maxSpotColor = "orangered",
                              spotColor = F,
                              chartRangeMinX = 1,
                              chartRangeMinX = 60,
                              normalRangeMin = mean(MINS)-(sd(MINS) * 0.5),
                              normalRangeMax = mean(MINS)+(sd(MINS) * 0.5),
                              chartRangeClip = T,
                              tooltipChartTitle = "Minutes Played"),
            
            M.Dist =  spk_chr(MINS, 
                              type = "box", 
                              lineColor="deeppink", 
                              boxFillColor = "pink",
                              whiskerColor = "transparent",
                              outlierLineColor = "white",
                              outlierFillColor = "white",
                              medianColor = "deeppink",
                              minValue = 1,
                              maxValue = 60,
                              showOutliers = F,
                              tooltipChartTitle = "Minutes Distribution"),
            
            
            totalLoad = sum(Load), 
            
            L.Trend = spk_chr(Load, 
                              type = "line", 
                              lineColor = "deeppink", 
                              fillColor = "transparent", 
                              minSpotColor = "skyblue",
                              maxSpotColor = "orangered",
                              spotColor = F,
                              chartRangeMinX = 0,
                              chartRangeMinX = 100,
                              normalRangeMin = mean(MINS)-(sd(MINS) * 0.5),
                              normalRangeMax = mean(MINS)+(sd(MINS) * 0.5),
                              chartRangeClip = T,
                              tooltipChartTitle = "Game Load"),
            
            L.Dist =  spk_chr(Load, 
                              type = "box", 
                              lineColor="deeppink", 
                              boxFillColor = "pink",
                              whiskerColor = "transparent",
                              outlierLineColor = "white",
                              outlierFillColor = "white",
                              medianColor = "deeppink",
                              minValue = 0,
                              maxValue = 100,
                              showOutliers = F,
                              tooltipChartTitle = "Minutes Distribution"),
            
            B2B = sum(B2B), 
            
            Participation = mean(Participation)) %>%
  
  select(Player, totalLoad, L.Trend, L.Dist, totalMins, M.Trend, M.Dist, Games, B2B) %>%
  
  ungroup()

photo <- game_logs %>% distinct(Player, Photo)

table <- full_join(weekLoad, photo, by = c("Player")) %>% 
  na.omit() %>%
  arrange(desc(totalLoad, totalMins, Games)) %>%
  select(Photo, Player, totalLoad, L.Trend, L.Dist, totalMins, M.Trend, M.Dist, Games, B2B) %>%
  mutate(Photo = paste('<img src =',' "', Photo,'" ', 'height="45"></img>', sep = ""))


table2 <- table %>% arrange(desc("totalLoad"))%>%

  #this mutate statement creates a button column that can be executed with the same modal  
  mutate(SMS = sapply(1:nrow(table), function(i){
    sprintf("<button id='inf%d' type='button' class='btn btn-default action-button shiny-bound-input'><i class= 'glyphicon glyphicon-send'/></button>",i)
  })) %>%
  
  formattable::formattable(
    list(
      totalLoad = color_tile("white", "indianred"),
      totalMins = color_tile("white", "indianred")
    )
  )



#####################################################################################
