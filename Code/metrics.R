# As the clustering method will name the clusters by number,
# the accuracy of the clustering algorithm is obtained by means of permutations,
# which are calculated for each combination to the true labels of the data set,
# and the highest value is taken as the final result.

library(e1071) # For function permutations().

acc = function(true, n, res){
  if(length(true) != length(res)){
    print("The length are not match!!!")
    break
  }

  lables = unique(res)
  acc_res = 0
  all = permutations(n)

  for (i in 1:nrow(all)) {
    temp = res
    for (j in 1:n) {
      temp[res == lables[j]] = all[i,j]
    }
    temp_acc = sum(temp == true)/length(true)

    if(temp_acc > acc_res){
      acc_res = temp_acc
      final_result = temp
    }
  }
  return(list(acc_res = acc_res, final_result = final_result))
}






# The functions used to calculate the metrics include accuracy,
# precision, recall, F1 score, TPR, FPR, Kappa statistic and Phi coefficient.

library(mltools) # For function mcc().

metric = function(true, pre, true_number){
  if(length(true) != ncol(pre)){
    print("The length are not match!!!")
    break
  }

  n = length(true)
  precision_list = c()
  recall_list = c()
  F1_list = c()
  ACC_list = c()
  TPR_list = c()
  FPR_list = c()
  kappa_list = c()
  phi_list = c()

  for (i in 1:nrow(pre)) {
    TP = sum(pre[i,] == true & true == true_number)
    FP = sum(pre[i,] != true & pre[i,] == true_number)
    FN = sum(pre[i,] != true & pre[i,] != true_number)
    TN = sum(pre[i,] == true & true != true_number)
    ACC = sum(pre[i,] == true) / length(true)

    # True Positive Rate
    TPR = TP / (TP + FN)

    # False Positive Rate
    FPR = FP / (FP + TN)

    # Precision
    precision = TP / (TP + FP)

    # Recall
    recall = TPR

    # F1 score
    F1 = (2 * precision * recall) / (precision + recall)

    # Kappa statistic
    cluster_lable = unique(true)
    temp = 0

    for (j in cluster_lable) {
      temp = temp + sum(pre[i,] == j) * sum(true == j)
    }

    pe = temp / (n * n)
    kappa = (ACC - pe) / (1 - pe)

    # Phi coefficient
    phi = mcc(unlist(pre[i,]), true)

    precision_list = c(precision_list, precision)
    recall_list = c(recall_list, recall)
    F1_list = c(F1_list, F1)
    ACC_list = c(ACC_list, ACC)
    TPR_list = c(TPR_list, TPR)
    FPR_list = c(FPR_list, FPR)
    kappa_list = c(kappa_list, kappa)
    phi_list = c(phi_list, phi)
  }

  return(list(precision_list = precision_list,
              recall_list = recall_list,
              F1_list = F1_list,
              ACC_list = ACC_list,
              TPR_list = TPR_list,
              FPR_list = FPR_list,
              kappa_list = kappa_list,
              phi_list = phi_list
  ))
}































