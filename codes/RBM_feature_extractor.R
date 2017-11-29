new_features <- function(model,data)
{
  new_data <- model %*% data
  return(new_data)
}