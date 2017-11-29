normalize <- function(m2, a, b) {
  for (r in seq(nrow(m2)))
    for (c in seq(ncol(m2)))
      if(a[c] == b[c])
        m2[[r,c]] <- a[c]
  else
    m2[[r, c]] <- (m2[[r,c]]-a[c])/(b[c]-a[c])
  return(m2)
}
