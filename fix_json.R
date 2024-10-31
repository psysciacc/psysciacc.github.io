# Read the JSON file as a single string
file_path <- ".quarto/idx/submit.qmd.json"
json_text <- readChar(file_path, file.info(file_path)$size)

# Find the character at position 14740
if (nchar(json_text) >= 14740) {
  cat(substr(json_text, 14735, 14745))  # Display a few characters around the position
} else {
  cat("Position exceeds file length.")
}
