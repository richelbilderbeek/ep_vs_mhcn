library(ggplot2)
library(testthat)
library(bbbq)
library(EpitopePrediction)
library(mhcnuggetsr)

# MHC-I haplotypes used in this study
mhc1_haplotypes <- get_mhc1_haplotypes()

n_aas <- 9
# 1000: 9 hours, before running out of 20 GB memory
# 100: 30 mins
n_peptides <- 200 # Tested per haplotype

if (is_on_ci()) {
  n_peptides <- 2
}

# A tidy tibble
df <- tibble::as_tibble(
  expand.grid(
    tool = c("ep", "mhcn"),
    haplotype = mhc1_haplotypes,
    sequence = bbbq::create_random_peptides(n_peptides = n_peptides, n_aas = n_aas),
    ic50 = NA,
    stringsAsFactors = FALSE
  )
)
n_rows <- nrow(df)
for (i in seq_len(n_rows)) {
  df$ic50[i] <- bbbq::predict_ic50s_mhc1(
    protein_sequence = df$sequence[i],
    mhc_1_haplotype = df$haplotype[i],
    n_aas = n_aas,
    tool = df$tool[i]
  )$ic50
}
df
readr::write_csv(df, "ep_vs_mhcn.csv")
