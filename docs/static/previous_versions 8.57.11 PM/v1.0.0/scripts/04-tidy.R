## ----setup_tidy, include=FALSE------------------------------------------------
chap <- 4
lc <- 0
rq <- 0
# **`r paste0("(LC", chap, ".", (lc <- lc + 1), ")")`**
# **`r paste0("(RQ", chap, ".", (rq <- rq + 1), ")")`**

knitr::opts_chunk$set(
  tidy = FALSE, 
  out.width = '\\textwidth', 
  fig.height = 4,
  fig.align='center',
  warning = FALSE
)

options(scipen = 99, digits = 3)

# In knitr::kable printing replace all NA's with blanks
options(knitr.kable.NA = '')

# Set random number generator see value for replicable pseudorandomness.
set.seed(76)


## ----warning=FALSE, message=FALSE---------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(nycflights13)
library(fivethirtyeight)


## ----message=FALSE, warning=FALSE, echo=FALSE---------------------------------
# Packages needed internally, but not in text.
library(knitr)
library(kableExtra)
library(stringr)
library(scales)


## ----message=FALSE, eval=FALSE------------------------------------------------
## library(readr)
## dem_score <- read_csv("https://moderndive.com/data/dem_score.csv")
## dem_score

## ----message=FALSE, echo=FALSE------------------------------------------------
dem_score <- read_csv("data/dem_score.csv")
dem_score


## ----read-excel, echo=FALSE, fig.cap="Importing an Excel file to R."----------
include_graphics("images/rstudio_screenshots/read_excel.png")


## ---- echo=FALSE--------------------------------------------------------------
drinks %>% 
  head(5)


## -----------------------------------------------------------------------------
drinks_smaller <- drinks %>% 
  filter(country %in% c("USA", "China", "Italy", "Saudi Arabia")) %>% 
  select(-total_litres_of_pure_alcohol) %>% 
  rename(beer = beer_servings, spirit = spirit_servings, wine = wine_servings)
drinks_smaller


## ----drinks-smaller, fig.cap="Comparing alcohol consumption in 4 countries.", fig.height=3.9, echo=FALSE----
drinks_smaller_tidy <- drinks_smaller %>% 
  gather(type, servings, -country)
drinks_smaller_tidy_plot <- ggplot(
    drinks_smaller_tidy, 
    aes(x = country, y = servings, fill = type)
    ) +
  geom_col(position = "dodge") +
  labs(x = "country", y = "servings")
if(knitr::is_html_output()){
  drinks_smaller_tidy_plot
} else {
  drinks_smaller_tidy_plot + scale_fill_grey()
}


## -----------------------------------------------------------------------------
drinks_smaller_tidy






## ----tidy-stocks, echo=FALSE--------------------------------------------------
stocks_tidy <- stocks %>% 
  rename(
    Boeing = `Boeing stock price`,
    Amazon = `Amazon stock price`,
    Google = `Google stock price`
  ) %>% 
#  gather(`Stock name`, `Stock price`, -Date)
  pivot_longer(cols = -Date, 
               names_to = "Stock Name", 
               values_to = "Stock Price")
stocks_tidy %>% 
  kable(
    digits = 2,
    caption = "Stock prices (tidy format)", 
    booktabs = TRUE,
    linesep = ""
  ) %>% 
  kable_styling(font_size = ifelse(knitr:::is_latex_output(), 10, 16),
                latex_options = c("hold_position"))


## ----tidy-stocks-2, echo=FALSE------------------------------------------------
stocks <- tibble(
  Date = as.Date('2009-01-01') + 0:4,
  `Boeing Price` = paste("$", c("173.55", "172.61", "173.86", "170.77", "174.29"), sep = ""),
  `Weather` = c("Sunny", "Overcast", "Rain", "Rain", "Sunny")
) %>% 
  slice(1:2)
stocks %>% 
  kable(
    digits = 2,
    caption = "Example of tidy data"#, 
#    booktabs = TRUE
  ) %>% 
  kable_styling(font_size = ifelse(knitr:::is_latex_output(), 10, 16), 
                latex_options = c("hold_position"))


## \vspace{-0.15in}

## **_Learning check_**

## \vspace{-0.1in}




## -----------------------------------------------------------------------------
drinks_smaller


## -----------------------------------------------------------------------------
drinks_smaller_tidy <- drinks_smaller %>% 
  pivot_longer(names_to = "type", 
               values_to = "servings", 
               cols = -country)
drinks_smaller_tidy


## ---- eval=FALSE--------------------------------------------------------------
## drinks_smaller %>%
##   pivot_longer(names_to = "type",
##                values_to = "servings",
##                cols = c(beer, spirit, wine))


## ---- eval=FALSE--------------------------------------------------------------
## drinks_smaller %>%
##   pivot_longer(names_to = "type",
##                values_to = "servings",
##                cols = beer:wine)


## ----eval=FALSE---------------------------------------------------------------
## ggplot(drinks_smaller_tidy, aes(x = country, y = servings, fill = type)) +
##   geom_col(position = "dodge")


## ----drinks-smaller-tidy-barplot, echo=FALSE, fig.cap='(ref:drinks-col)', fig.height=2.5----
if(knitr::is_html_output()){
  drinks_smaller_tidy_plot
} else {
  drinks_smaller_tidy_plot + scale_fill_grey()
}


## \vspace{-0.15in}

## **_Learning check_**

## \vspace{-0.1in}


## ---- eval=FALSE--------------------------------------------------------------
## airline_safety


## -----------------------------------------------------------------------------
airline_safety_smaller <- airline_safety %>% 
  select(airline, starts_with("fatalities"))
airline_safety_smaller




## -----------------------------------------------------------------------------
guat_dem <- dem_score %>% 
  filter(country == "Guatemala")
guat_dem


## -----------------------------------------------------------------------------
guat_dem_tidy <- guat_dem %>% 
  pivot_longer(names_to = "year", 
               values_to = "democracy_score", 
               cols = -country,
               names_ptypes = list(year = integer())) 
guat_dem_tidy


## ----guat-dem-tidy, fig.cap="Democracy scores in Guatemala 1952-1992.", fig.height=3----
ggplot(guat_dem_tidy, aes(x = year, y = democracy_score)) +
  geom_line() +
  labs(x = "Year", y = "Democracy Score")






## ---- eval=FALSE--------------------------------------------------------------
## library(ggplot2)
## library(dplyr)
## library(readr)
## library(tidyr)


## ---- eval=FALSE--------------------------------------------------------------
## library(tidyverse)


## ---- eval=FALSE--------------------------------------------------------------
## library(ggplot2)
## library(dplyr)
## library(readr)
## library(tidyr)
## library(purrr)
## library(tibble)
## library(stringr)
## library(forcats)


## ----echo=FALSE, results="asis"-----------------------------------------------
if(knitr::is_latex_output()){
  cat("Solutions to all *Learning checks* can be found online in [Appendix D](https://moderndive.com/D-appendixD.html).")
} 




## ----import-cheatsheet, echo=FALSE, fig.cap="Data Import cheatsheet (first page): readr package.", out.width="66%"----
if(knitr::is_html_output())
  include_graphics("images/cheatsheets/data-import-1.png")


## ----tidyr-cheatsheet, echo=FALSE, fig.cap="Data Import cheatsheet (second page): tidyr package.", out.width="66%"----
if(knitr::is_html_output())
  include_graphics("images/cheatsheets/data-import-2.png")

