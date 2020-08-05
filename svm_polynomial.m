% 'linear' | 'gaussian' | 'rbf' | 'polynomial'
kernel = templateSVM('KernelFunction','rbf')
SVMModel = fitcecoc(X_train, Y_train, 'Learners', kernel);

Y_predict = predict(SVMModel, X_test);
ConfusionMatrix = confusionmat(Y_test, Y_predict);
confusionchart(ConfusionMatrix)

save('SVM-RBF_ConfusionMatrix.mat', 'ConfusionMatrix');