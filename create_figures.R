library(ggplot2)
library(testthat)

expect_true(file.exists("ep_vs_mhcn.csv"))
df <- readr::read_csv("ep_vs_mhcn.csv")

# tool | haplotype | IC50
# -----|-----------|------
# EpitopPrediction |
expect_true("haplotype" %in% names(df))
expect_true("ic50" %in% names(df))
expect_true("tool" %in% names(df))


# Reshape from tidy data to plottable data
df_scatter <- tidyr::pivot_wider(
  df,
  names_from = tool,
  values_from = ic50
)

ggplot(df_scatter, aes(x = ep, y = mhcn, color = haplotype)) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_continuous(limits = c(0, max(df_scatter$mhcn))) +
  scale_x_continuous(limits = c(0, max(df_scatter$mhcn))) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("IC50 predicted by EpitopePrediction") +
  ylab("IC50 predicted by MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y. ",
      "Blue line = fit to linear model, should ideally match the dashed line"
    )
  ) + ggsave("ep_vs_mhcn.png", width = 7, height = 7)


ggplot(df_scatter, aes(x = ep, y = mhcn, color = haplotype)) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_log10(limits = c(min(df$ic50), max(df$ic50))) +
  scale_x_log10(limits = c(min(df$ic50), max(df$ic50))) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("IC50 predicted by EpitopePrediction") +
  ylab("IC50 predicted by MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y. ",
      "Blue line = fit to linear model, should ideally match the dashed line"
    )
  ) + ggsave("ep_vs_mhcn_log.png", width = 7, height = 7)


expect_true(file.exists("ep_vs_mhcn.png"))
expect_true(file.exists("ep_vs_mhcn_log.png"))
