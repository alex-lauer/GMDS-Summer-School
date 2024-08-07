### Setup file to be sourced at beginning of each new chapter

### Load libraries

renv::install("tidyverse")
renv::install("mmrm")
renv::install("emmeans")
renv::install("nlme")
renv::install("gtsummary")

library(tidyverse)
library(mmrm)
library(emmeans)
library(gtsummary)
# library(mlmi)

### Load data

### This is the small example dataset, created from the low dropout
all <- haven::read_sas("data/all2.sas7bdat")
colnames(all) <- tolower(colnames(all))

all2 <- all %>%
  dplyr::mutate(
    aval = change + basval,
    avisit = dplyr::recode(as.character(time), "1" = "Week 2", "2" = "Week 4", "3" = "Week 8"),
    avisit = factor(avisit, levels = c("Week 2", "Week 4", "Week 8")),
    week = ifelse(time==3,8,time*2),
    subject = factor(subject),
    group = factor(trt, levels = 1:2, labels = c("Arm 1","Arm 2"))
  )


### Larger dataset with low dropout rate
low <- haven::read_sas("data/low2.sas7bdat") %>%
  dplyr::mutate(
    aval = change + basval
  )

colnames(low) <- tolower(colnames(low))

high <- haven::read_sas("data/high2.sas7bdat") 
colnames(high) <- tolower(colnames(high))

high2 <- high %>% group_by(patient) %>% 
dplyr::mutate(
  aval = change + basval,
  drop=max(week),
  group = factor(trt, levels = 1:2, labels = c("Arm 1","Arm 2")),
  avisit = dplyr::recode(as.character(week), "1" = "Week 1", "2" = "Week 2", "4" = "Week 4", "6" = "Week 6", "8" = "Week 8"),
  avisit = factor(avisit, levels = c("Week 1", "Week 2", "Week 4", "Week 6", "Week 8"))
)
