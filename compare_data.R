library(ggplot2)
library(testthat)
library(dplyr)

expect_true(file.exists("ep_vs_mhcn.csv"))
df <- readr::read_csv("ep_vs_mhcn.csv")

# tool | haplotype | IC50
# -----|-----------|------
# EpitopPrediction |
expect_true("tool" %in% names(df))
expect_true("haplotype" %in% names(df))
expect_true("sequence" %in% names(df))
expect_true("ic50" %in% names(df))

# Reshape from tidy data to plottable data
df_scatter <- tidyr::pivot_wider(
  df,
  names_from = tool,
  values_from = ic50
)

ggplot(df_scatter, aes(x = EpitopePrediction, y = mhcnuggetsr, color = haplotype)) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_continuous(limits = c(0, max(df_scatter$mhcnuggetsr))) +
  scale_x_log10(limits = c(min(df$ic50), max(df$ic50))) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("IC50 predicted by EpitopePrediction") +
  ylab("IC50 predicted by MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y. ",
      "Blue line = fit to linear model, should ideally match the dashed line"
    )
  ) + ggsave("ep_vs_mhcn_comp.png", width = 7, height = 7)

df_comp_perc <- df_scatter %>%
  mutate(perc_ep = (log10(EpitopePrediction) - min(log10(EpitopePrediction))) / (max(log10(EpitopePrediction)) - min(log10(EpitopePrediction)))) %>%
  mutate(perc_mhcn = (mhcnuggetsr - min(mhcnuggetsr)) / (max(mhcnuggetsr) - min(mhcnuggetsr)))

ggplot(
  df_comp_perc,
  aes(x = perc_ep, y = perc_mhcn, color = as.factor(haplotype))) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1.0)) +
  scale_x_continuous(labels = scales::percent, limits = c(0, 1.0)) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("Relative IC50 value predicted by EpitopePrediction") +
  ylab("Relative IC50 value predicted by MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y. ",
      "Blue line = fit to linear model, should ideally match the dashed line"
    )
  ) + ggsave("ep_vs_mhcn_perc2.png", width = 7, height = 7)


expect_true(file.exists("ep_vs_mhcn_comp.png"))
