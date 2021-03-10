library(ggplot2)
library(testthat)
library(dplyr)

expect_true(file.exists("sorted_values.csv"))
sv <- readr::read_csv("sorted_values.csv")

#  haplotype | sequence | ep | mhcn
# -----------|----------|----|------
expect_true("haplotype" %in% names(sv))
expect_true("sequence" %in% names(sv))
expect_true("ep" %in% names(sv))
expect_true("mhcn" %in% names(sv))

ggplot(sv, aes(x = ep, y = mhcn, color = haplotype)) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_continuous(limits = c(0, max(sv$mhcn))) +
  scale_x_continuous(limits = c(0, max(sv$ep))) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("IC50 predicted by EpitopePrediction") +
  ylab("IC50 predicted by MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y."
    )
  ) + ggsave("ep_vs_mhcn_sort_perc.png", width = 7, height = 7)

expect_true(file.exists("ep_vs_mhcn_sort_perc.png"))
