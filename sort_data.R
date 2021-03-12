library(ggplot2)
library(testthat)
library(dplyr)

expect_true(file.exists("ep_vs_mhcn.csv"))
sv <- readr::read_csv("ep_vs_mhcn.csv")

# Reshape from tidy data to plottable data
sv <- tidyr::pivot_wider(
  sv,
  names_from = tool,
  values_from = ic50
)

sv <- arrange(sv, haplotype, EpitopePrediction)

ht <- sv$haplotype[1]
u <- 1

for (i in seq_len(nrow(sv))) {
  if (sv$haplotype[i] == ht) {
    sv$EpitopePrediction[i] <- u
    u <- u + 1
  } else {
    ht <- sv$haplotype[i]
    sv$EpitopePrediction[i] <- 1
    u <- 2
  }
}

sv <- arrange(sv, haplotype, mhcnuggetsr)

ht <- sv$haplotype[1]
u <- 1

for (i in seq_len(nrow(sv))) {
  if (sv$haplotype[i] == ht) {
    sv$mhcnuggetsr[i] <- u
    u <- u + 1
  } else {
    ht <- sv$haplotype[i]
    sv$mhcnuggetsr[i] <- 1
    u <- 2
  }
}

ggplot(sv, aes(x = EpitopePrediction, y = mhcnuggetsr, color = haplotype)) +
  geom_abline(slope = 1, intercept = 0, lty = "dashed") +
  geom_point() +
  scale_y_continuous(limits = c(0, max(sv$mhcnuggetsr))) +
  scale_x_continuous(limits = c(0, max(sv$EpitopePrediction))) +
  geom_smooth(method = "lm", alpha = 0.1) +
  xlab("Sorted values from EpitopePrediction") +
  ylab("Sorted values from MHCnuggets") +
  labs(
    caption = paste0(
      "Dashed line: x = y."
    )
  ) + ggsave("ep_vs_mhcn_sort.png", width = 7, height = 7)

expect_true(file.exists("ep_vs_mhcn_sort.png"))

readr::write_csv(sv, "sorted_values2.csv")
expect_true(file.exists("sorted_values2.csv"))
