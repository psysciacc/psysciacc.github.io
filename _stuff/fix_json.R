# Scan all Quarto-generated JSON index files for parse errors and show context

json_files <- list.files(".quarto/idx", pattern = "\\.json$", full.names = TRUE, recursive = TRUE)

for (f in json_files) {
  #cat("\n--- Checking:", f, "---\n")
  txt <- tryCatch(readChar(f, file.info(f)$size), error = function(e) NA)
  if (is.na(txt)) {
    cat("Could not read file\n")
    next
  }
  ok <- tryCatch({ jsonlite::fromJSON(txt); TRUE }, error = function(e) FALSE)
  if (!ok) {
    cat("\n--- Checking:", f, "---\n")
    cat("JSON PARSE ERROR\n")
    pos <- regexpr("position ([0-9]+)", capture.output(try(jsonlite::fromJSON(txt), silent=TRUE))[1])
    # fallback: show around known bad position 15426
    p <- 15426
    start <- max(1, p-200)
    end <- min(nchar(txt), p+200)
    cat(substr(txt, start, end), "\n")
  } else {
    #cat("OK\n")
  }
}
