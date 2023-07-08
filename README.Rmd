---
title: "README"
author: "Aidan"
date: "2023-07-08"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## CleanDataProject
##### Files contained in this repository:  
+ "CleanDataProject.Rproj" - the R project file created by RStudio upon initialization  
+ "/data/" - doesn't contain raw data, but contains raw data parsing txt files and the tidy, processed data  
+ "CodeBook.Rmd" - raw markdown file containing the code book  
+ "CodeBook.html" - knit markdown file with easy-to-read code book  
+ "run_analysis.R" - data processing script, takes no parameters and follows the tidy data guidelines [here](https://vita.had.co.nz/papers/tidy-data.pdf)  

##### $run\_analysis.R$ workflow:
1. Test if the data has been downloaded before. If not, download it.
2. Use $fread()$ to pull all relevant information from different $csv$ files.
3. All individual files are combined using $cbind$ and $rbind$ to form a large data table.
4. Columns are named according to the [features.txt](./data/UCI HAR Dataset/features.txt).
5. $grepl()$ pulls out only mean and standard deviation columns and subsets the data.
6. $factor()$ converts values in $Activities$ column to their relative descriptors.
7. $ddply()$ wraps up the process by finding column means for every column except the first two.
8. Write the data to [tidy.txt](./data/tidy.txt)

###### Read data using $read.csv("./data/tidy.txt", sep = ";")$