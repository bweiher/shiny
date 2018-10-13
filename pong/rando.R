# 
# tibble(
#   ben_score = input$ben_score,
#   dylan_score = input$dylan_score
# ) %>% 
#   mutate(
#     winner = ifelse(ben_score > dylan_score, 'Ben', 'Dylan'),
#     date = Sys.Date()
#   ) %>% 
#   select(date, winner, everything())
library(lubridate)
library(tidyverse)


begin <- ymd(Sys.Date())
after <- ymd(Sys.Date() + days(325))


dates <- seq.Date(begin,after,by='day')

dlist <- list()
for(g in seq_along(dates)) {
  current_date <- dates[g]
  
 dlist[[g]] <- map_df(1:sample(c(1:7), 1L), function(x){
   tibble(
    ben_score = sample(  x = c(1:21),size = 1),
    dylan_score = sample(x = c(1:21),size = 1)
  ) %>% 
    mutate(
      winner = ifelse(ben_score > dylan_score, 'Ben', 'Dylan'),
      date =current_date,
      time = Sys.time()
    ) %>% 
    select(date, winner, everything())
 })
  
  
 
}


bind_rows(dlist) %>% 
  write_csv('df.csv')

  read_csv('df.csv') %>% 
  mutate(ben_wins = ben_score > dylan_score) %>% 
  group_by(date) %>% 
  summarise(games= n(), ben_wins = sum(ben_wins)) %>% 
  mutate(daily_winrate = ben_wins / games,
         cumulative_winrate = cumsum(ben_wins) / cumsum(games)) %>% 
  select(date, contains('winrate')) %>% 
  gather(metric, value, -date) %>% 
  mutate(value=value*100) %>% 
  hchart('line', hcaes(x=date, y=value, group=metric),
         name = c('Cumulative Winrate', 'Daily Winrate')) %>% 
  hc_add_theme(bwmisc::theme_ipsum()) %>% 
  hc_yAxis(title=list(text='Win Percentage'),
           max = 100,
           labels=list(format='{value}%')) %>% 
  hc_xAxis(title=list(text='Date')) %>% 
  hc_title(text = "Daily and Cumulative Winrates") %>% 
  hc_subtitle(text = "Ben vs. Dylan") %>% 
  hc_tooltip(valueDecimals=1,valueSuffix='%')
          
  
    dts <- read_csv('df.csv') %>% 
    transmute(date, 
              point_diff = ben_score - dylan_score,
              csum_point_diff = cumsum(point_diff)) 
  
    dates <- unique(dts$date)
    
   
  # TODO every time  
data <- map_df(seq_along(dates), function(x){   
      
    pts <- pull(filter(dts, date == dates[x]), point_diff)
    high <- max(pts) 
    median <- median(pts)
    low <- min(pts)
   
    tibble(
      date =dates[x],
      low = low ,
      median = median,
      high = high
    )
    })

# TODO assume that this is sorted by time
  csum_d <- dts %>% 
  group_by(date) %>% 
  filter(row_number() == max(row_number())) %>% 
  select(date,  csum_point_diff) %>% 
  ungroup() %>% 
    arrange(date)
    
    highchart() %>% 
    hc_add_series(data , 'errorbar' , hcaes(x=date, low = low, high = high )) %>% 
    hc_add_series(csum_d, 'line', hcaes(x=date, y=csum_point_diff), 
                  name = 'Cumulative Point Difference',
                  dashStyle='dash') %>% 
    hc_xAxis(type = 'datetime') %>% 
    hc_add_theme(bwmisc::theme_ipsum()) %>% 
    hc_yAxis(title=list(text='Point Differential'),
             plotLines = list(
               list(#label = list(text = "This is a plotLine"),
                    color = "#FF0000",
                    dashStyle ='dot',
                    width = 2,
                    value = 0)
             )) %>% 
    hc_title(text = 'Point Differential Distribution by Day') %>% 
    hc_subtitle(text = "Ben vs. Dylan") 

