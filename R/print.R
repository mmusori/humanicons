knitOutputType <- function() {
  output <- tryCatch(
    rmarkdown::yaml_front_matter(knitr::current_input())$output,
    error = function(e) "console"
  )
  if (is.list(output)) {
      return(names(output)[1])
  } else if (length(output) == 0) {
    return("unknown_document")
  } else {
    return(output[1])
  }
}


#' @importFrom knitr knit_print
#' @export
knitr::knit_print

#' @export
knit_print.icon_hi <- function(x, ...) {
    if (knitOutputType() %in% c("pdf_document", "beamer", "pdf_document2")) {
        knitr::asis_output(paste0("\\hi", x$name), meta = list(rmarkdown::latex_dependency("humicons")))
  } else if (knitOutputType() %in% c("word_document", "console")) {
    paste0("hi_", x$name)
  } else {
    header <- htmltools::tags$head(html_dependency_humicons())
    icon <- htmltools::tags$i(class = cat_icon(x), style = font_style(x))
    knitr::knit_print(htmltools::tagList(header, icon))
  }
}

cat_icon <- function(x) {
  UseMethod("cat_icon")
}

cat_icon.icon_hi <- function(x) {
  icon_string(x, icon = "hi")
}

paste_icon <- function(icon = "fas", other) {
  paste0(" ", icon, "-", other)
}

icon_string <- function(x, icon = "fas", icon_class = icon) {
  # Determine fa string to use
  # -------------------------------------------------
  size_append <- switch(as.character(x$options$size), `1` = "", lg = paste_icon(icon,
      "lg"), `2` = paste_icon(icon, "2x"), `3` = paste_icon(icon, "3x"),
      `4` = paste_icon(icon, "4x"), `5` = paste_icon(icon, "5x"))

  if (x$options$fixed_width) {
      fw_append <- paste_icon(icon, "fw")
  } else {
      fw_append <- ""
  }

  anim_append <- switch(x$options$animate, still = "", spin = paste_icon(icon,
      "spin"), pulse = paste_icon(icon, "pulse"))

  rotate_append <- switch(as.character(x$options$rotate), `0` = "", `90` = paste_icon(icon,
      "rotate-90"), `180` = paste_icon(icon, "rotate-180"), `270` = paste_icon(icon,
      "rotate-270"))

  flip_append <- switch(x$options$flip, none = "", horizontal = paste_icon(icon,
      "flip-horizontal"), vertical = paste_icon(icon, "flip-vertical"))

  if (x$options$border) {
      border_append <- paste_icon(icon, "border")
  } else {
      border_append <- ""
  }

  if (!is.null(x$options$pull)) {
      pull_append <- switch(x$options$pull, left = paste_icon(icon, "pull-left"),
          right = paste_icon(icon, "pull-right"))
  } else {
      pull_append <- ""
  }

  other_append <- paste0(" ", paste(x$options$other, collapse = " "))

  paste0(paste0(icon_class, " "), paste_icon(icon, x$name), size_append, fw_append,
      anim_append, rotate_append, flip_append, border_append, pull_append,
      other_append)
}
