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
    tool = c("EpitopePrediction", "mhcnuggetsr"),
    haplotype = mhc1_haplotypes,
    sequence = bbbq::create_random_peptides(
      n_peptides = n_peptides,
      peptide_length = n_aas
    ),
    ic50 = NA,
    stringsAsFactors = FALSE
  )
)
n_rows <- nrow(df)
for (i in seq_len(n_rows)) {
  df$ic50[i] <- bbbq::predict_ic50s(
    protein_sequence = df$sequence[i],
    peptide_length = n_aas,
    haplotype = df$haplotype[i],
    ic50_prediction_tool = df$tool[i],
    mhcnuggetsr_peptides_path = "pasta.fasta",
    sink_filename = "prullen.bak"
  )$ic50
}
df
readr::write_csv(df, "ep_vs_mhcn.csv")
