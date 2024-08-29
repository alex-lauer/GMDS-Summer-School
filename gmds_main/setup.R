### Setup file to be sourced at beginning of each new chapter

### Load libraries

# install.packages("tidyverse", "mmrm", "emmeans", "gtsummary", "gt", "rbmi")

library(tidyverse)
library(mmrm)
library(emmeans)
library(gtsummary)
library(gt)
library(rbmi)

### Load data

### This is the small example dataset, created from the low dropout
all <- haven::read_sas("data/all2.sas7bdat")
colnames(all) <- tolower(colnames(all))

all2 <- all %>%
  dplyr::mutate(
    aval = change + basval,
    avisit = dplyr::recode(as.character(time), "1" = "Week 2", "2" = "Week 4", "3" = "Week 8"),
    avisit = factor(avisit, levels = c("Week 2", "Week 4", "Week 8")),
    week = as.numeric(dplyr::recode(as.character(time), "1" = "2", "2" = "4", "3" = "8")),
    subject = factor(subject),
    group = factor(trt, levels = 1:2, labels = c("Arm 1","Arm 2"))
  )


### Larger dataset with low dropout rate
low <- haven::read_sas("data/low2.sas7bdat") %>%
  dplyr::mutate(
    aval = change + basval
  )

colnames(low) <- tolower(colnames(low))

high <- haven::read_sas("data/high2.sas7bdat") %>%
  dplyr::mutate(
    aval = change + basval
  )
