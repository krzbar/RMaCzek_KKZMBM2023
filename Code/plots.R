# Dataset
# WDBC
dataname = "wdbc"
data = read.csv(paste0(dataname, ".csv"), header = FALSE)
original_lables = data$V2

true_lable = "M"
lables = unique(original_lables)

true = c()
for (i in 1:nrow(data)) {
  temp = which(lables == original_lables[i])
  true = c(true, temp)
}
data = data[,-c(1,2)]
summary(data)

true_number = unique(true[original_lables == true_lable])
num_cluster = length(lables)



# WBC
# dataname = "wbc"
# data = read.csv(paste0(dataname, ".csv"), header = FALSE)
# original_lables = data$V11
#
# true_lable = "2"
# lables = unique(original_lables)
#
# true = c()
# for (i in 1:nrow(data)) {
#   temp = which(lables == original_lables[i])
#   true = c(true, temp)
# }
# data = data[,-c(1,11)]
# data$V7 = as.numeric(data$V7)
# original_lables = original_lables[!is.na(data$V7)]
# true = true[!is.na(data$V7)]
# data = data[!is.na(data$V7),]
# summary(data)
#
# true_number = unique(true[original_lables == true_lable])
# num_cluster = length(lables)



# WPBC
# dataname = "wpbc"
# data = read.csv(paste0(dataname, ".csv"), header = FALSE)
# original_lables = data$V2
#
# true_lable = "R"
# lables = unique(original_lables)
#
# true = c()
# for (i in 1:nrow(data)) {
#   temp = which(lables == original_lables[i])
#   true = c(true, temp)
# }
# data = data[,-c(1, 2, 3)]
# data$V35 = as.numeric(data$V35)
# original_lables = original_lables[!is.na(data$V35)]
# true = true[!is.na(data$V35)]
# data = data[!is.na(data$V35),]
# summary(data)
#
# true_number = unique(true[original_lables == true_lable])
# num_cluster = length(lables)


# Plot
# order = c("SPIN_NH", "OLO_ward", "GW_ward", "HC_ward", "OLO_average")
order = "SPIN_NH"

x = czek_matrix(data, order = order, cluster = TRUE, cluster_type = "exact", num_cluster = num_cluster, min.size = 2)

res = attr(x, "cluster_res")
my_acc = acc(true, num_cluster, res)
my_acc$acc_res

plot.czek_matrix(x, plot_title = paste0("order = ", order, ", acc = ", round(my_acc$acc_res, digits = 4)))
