
library(tidyverse)
library(rvest)

# Prepare 3 sets of zipcode level data ------------------------------------

## 1. Price-to-rent ratio: _PriceToRentRatio_
## 2. Zillow rent index: _Zri_
## 3. Median rent list price: _MedianRentalPrice_

read_html("https://www.zillow.com/research/data/") %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    unique() %>%
    grep(".csv$", ., value = TRUE) %>%  # -> all_csv_links
    grep("Zip", ., value = TRUE) %>%  # -> zip_csv_links
    grep("_PriceToRentRatio_|_Zri_|_MedianRentalPrice_", ., value = TRUE) ->
    zip_csv_links_tmp
zip_csv_links_tmp

# Tidy up and save data needed --------------------------------------------

zip_csv_links_tmp %>%
    grep("Zip_PriceToRentRatio_AllHomes.csv", ., value = TRUE) %>%
    read_csv() %>%
    gather(YearMonth, PriceToRentRatio, -c(RegionID:SizeRank)) %>%
    print() ->
    Zip_PriceToRentRatio_AllHomes
use_data(Zip_PriceToRentRatio_AllHomes, overwrite = TRUE)

zip_csv_links_tmp %>%
    grep("Zip_Zri_AllHomes.csv", ., value = TRUE) %>%
    read_csv() %>%
    gather(YearMonth, Zri, -c(RegionID:SizeRank)) %>%
    print() ->
    Zip_Zri_AllHomes
use_data(Zip_Zri_AllHomes, overwrite = TRUE)

zip_csv_links_tmp %>%
    grep("Zip_Zri_MultiFamilyResidenceRental.csv", ., value = TRUE) %>%
    read_csv() %>%
    gather(YearMonth, Zri, -c(RegionID:SizeRank)) %>%
    print() ->
    Zip_Zri_MultiFamilyResidenceRental
use_data(Zip_Zri_MultiFamilyResidenceRental, overwrite = TRUE)

zip_csv_links_tmp %>%
    grep("Zip_MedianRentalPrice_AllHomes.csv", ., value = TRUE) %>%
    read_csv() %>%
    gather(YearMonth, MedianRentalPrice, -c(RegionName:SizeRank)) %>%
    print() ->
    Zip_MedianRentalPrice_AllHomes
use_data(Zip_MedianRentalPrice_AllHomes, overwrite = TRUE)

zip_csv_links_tmp %>%
    grep("Zip_MedianRentalPrice_2Bedroom.csv", ., value = TRUE) %>%
    read_csv() %>%
    gather(YearMonth, MedianRentalPrice, -c(RegionName:SizeRank)) %>%
    print() ->
    Zip_MedianRentalPrice_2Bedroom
use_data(Zip_MedianRentalPrice_2Bedroom, overwrite = TRUE)
