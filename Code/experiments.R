# Dataset
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

# 500 runs
order = c("SPIN_NH", "OLO_ward", "GW_ward", "HC_ward", "OLO_average")

iter = 500
res.maxtrix = 1:iter
bandwidth = 0.05    # for fuzzy clustering

for (ord in order) {
  print(ord)
  acc_list = c()
  temp_lable = 1:nrow(data)
  order_matrix = 1:nrow(data)
  for (i in 1:iter) {
    # For exact clustering
    x = czek_matrix(data, order = ord, cluster = TRUE, cluster_type = "exact", num_cluster = num_cluster, min.size = 2)

    # For fuzzy clustering
    # x = czek_matrix(data, order = ord, cluster = TRUE, cluster_type = "fuzzy", num_cluster = num_cluster, min.size = 2, scale_bandwidth = bandwidth)

    res = attr(x, "cluster_res")

    new_order = attr(x, "order")
    order_matrix = rbind(order_matrix, as.vector(new_order))

    my_acc = acc(true, num_cluster, res)
    acc_list = c(acc_list, my_acc$acc_res)
    temp_lable = rbind(temp_lable, my_acc$final_result)
  }
  res.maxtrix = cbind(res.maxtrix, acc_list)

  write.csv(order_matrix[-1,], paste0(dataname, "-order-", ord,".csv"), row.names = FALSE)
  write.csv(temp_lable[-1,], paste0(dataname, "-lable-", ord,".csv"), row.names = FALSE)
}

res.maxtrix = res.maxtrix[,-1]
colnames(res.maxtrix) = order
write.csv(res.maxtrix, paste0(dataname, "-acc.csv"), row.names = FALSE)
write.csv(apply(res.maxtrix, 2, max), paste0(dataname, "-max-acc.csv"), row.names = FALSE)
