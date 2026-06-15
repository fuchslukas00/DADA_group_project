library(gbm)

load("../../group_project2/Data_Project2/Project2_data.Rdata")

# Feature selection for year
cor_year <- apply(LENS_tas_ann_train$X, 2, function(x)
  cor(x, LENS_tas_ann_train$Y$year)
)

top_features_year <- order(abs(cor_year), decreasing = TRUE)[1:500]

# Training data
train_data_year <- data.frame(
  year = LENS_tas_ann_train$Y$year,
  LENS_tas_ann_train$X[, top_features_year]
)

# GBM model for year
gbm_year <- gbm(
  year ~ .,
  data = train_data_year,
  distribution = "gaussian",
  n.trees = 4000,
  interaction.depth = 3,
  shrinkage = 0.01,
  bag.fraction = 0.7,
  cv.folds = 5,
  n.cores = 4,
  verbose = TRUE
)

# Best number of trees
best_trees_year <- gbm.perf(
  gbm_year,
  method = "cv",
  plot.it = FALSE
)

cat("Best trees for year:", best_trees_year, "\n")

# Save model and selected features
saveRDS(gbm_year, "gbm_year_model.rds")
saveRDS(top_features_year, "gbm_year_top_features.rds")
saveRDS(best_trees_year, "gbm_year_best_trees.rds")