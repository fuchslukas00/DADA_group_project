library(gbm)

load("../../group_project2/Data_Project2/Project2_data.Rdata")

cor_fraw <- apply(LENS_tas_ann_train$X, 2, function(x)
  cor(x, LENS_tas_ann_train$Y$fraw)
)

top_features <- order(abs(cor_fraw), decreasing = TRUE)[1:500]

train_data <- data.frame(
  fraw = LENS_tas_ann_train$Y$fraw,
  LENS_tas_ann_train$X[, top_features]
)

gbm_fraw <- gbm(
  fraw ~ .,
  data = train_data,
  distribution = "gaussian",
  n.trees = 4000,
  interaction.depth = 3,
  shrinkage = 0.01,
  bag.fraction = 0.7,
  cv.folds = 5,
  n.cores = 4,
  verbose = TRUE
)

saveRDS(gbm_fraw, "gbm_fraw_model_4000.rds")