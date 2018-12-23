
<!-- README.md is generated from README.Rmd. Please edit that file -->

An R package to easily insert humanitarian web icons into rmarkdown.

It works with inline code `` `r humicons::hi("Agriculture")` `` and
chunks:

```` 

```r
humicons::hi("Agriculture")
```
````

The **development** version can be installed from GitHub using:

``` r
# install.packages("remotes")
remotes::install_gitlab("dickoa/humicons")
```

This package is a fork of the `icon` package by `ropensci`:
<https://github.com/ropenscilabs/icon>
