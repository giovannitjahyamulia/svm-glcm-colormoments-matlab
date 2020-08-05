RootTrainPath = 'F:\SKRIPSI 2019-2020\6. Giovanni Tjahyamulia - 1620250081\image_train\';
RootTestPath = 'F:\SKRIPSI 2019-2020\6. Giovanni Tjahyamulia - 1620250081\image_test\';
RootTrain = dir(RootTrainPath);
RootTest = dir(RootTestPath);

X_train = [];
Y_train = [];
 
index_file = 0;
index_folder = 0;
 
for i = 1:length(RootTrain)
   FolderName = RootTrain(i).name
   if(FolderName ~= '.' | FolderName ~= '..')
       % printf(strcat('Extracting feature from ', FolderName));
       index_folder = index_folder + 1;
       
       FolderPath = strcat(RootTrainPath, FolderName, "\");
       File = dir(FolderPath);
       
       for j = 1:length(File)
           FileName = File(j).name;
           
           if(FileName == '.')
               
           else
                index_file = index_file + 1;
                
                FilePath = strcat(FolderPath, FileName);
                image = imread(FilePath);
                                
                glcm_stats = graycoprops(rgb2gray(image));
                
                X_train(index_file, 1) = glcm_stats.Contrast;
                X_train(index_file, 2) = glcm_stats.Correlation;
                X_train(index_file, 3) = glcm_stats.Energy;
                X_train(index_file, 4) = glcm_stats.Homogeneity;
                                
                Y_train(index_file) = index_folder;
           end 
       end
   end
end
 
X_test = [];
Y_test = [];
 
index_file = 0;
index_folder = 0;

file_test_name = [];
 
for i = 1:length(RootTest)
   FolderName = RootTest(i).name
   if(FolderName ~= '.' | FolderName ~= '..')
       % printf(strcat('Extracting feature from ', FolderName));
       index_folder = index_folder + 1;
       
       FolderPath = strcat(RootTestPath, FolderName, "\");
       File = dir(FolderPath);
       
       for j = 1:length(File)
           FileName = File(j).name;
           
           if(FileName == '.')
               
           else
                index_file = index_file + 1;
                
                FilePath = strcat(FolderPath, FileName);
                image = imread(FilePath);
                
                glcm_stats = graycoprops(rgb2gray(image));
                
                X_test(index_file, 1) = glcm_stats.Contrast;
                X_test(index_file, 2) = glcm_stats.Correlation;
                X_test(index_file, 3) = glcm_stats.Energy;
                X_test(index_file, 4) = glcm_stats.Homogeneity;
                                                
                Y_test(index_file) = index_folder;
           end 
       end
   end
end

save('SVM-GLCM_TrainFeatures.mat', 'X_train')
save('SVM-GLCM_TrainLabels.mat', 'Y_train')
save('SVM-GLCM_TestFeatures.mat', 'X_test')
save('SVM-GLCM_TestLabels.mat', 'Y_test')

% 'linear' | 'gaussian' | 'rbf' | 'polynomial'
SVMModel = fitcecoc(X_train, Y_train)
[Y_predict] = predict(SVMModel, X_test)
ConfusionMatrix = confusionmat(Y_test, Y_predict)
confusionchart(ConfusionMatrix)

save('SVM-GLCM_ConfusionMatrix.mat', 'ConfusionMatrix');