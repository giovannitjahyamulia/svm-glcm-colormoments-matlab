RootTrainPath = 'D:\Skripsi\image_train\';
RootTestPath = 'D:\Skripsi\image_test\';
RootTrain = dir(RootTrainPath);
RootTest = dir(RootTestPath);


X_train = [];
Y_train = [];
 
index_file = 0;
index_folder = 0;
 
for i = 1:length(RootTrain)
   FolderName = RootTrain(i).name
   if(FolderName ~= '.' | FolderName ~= '..')
       index_folder = index_folder + 1;
       
       FolderPath = strcat(RootTrainPath, FolderName, "\");
       File = dir(FolderPath);
       
       for j = 1:length(File)
           FileName = File(j).name;
           
           if(FileName == '.')
               
           else
                index_file = index_file + 1;
                FilePath = strcat(FolderPath, FileName);
                image = rgb2gray(imresize(imread(FilePath), [256 342]));
                                
                X_train(index_file, :) = (image(:));
                                
                Y_train(index_file) = index_folder;
           end 
       end
   end
end
 
X_test = [];
Y_test = [];
 
index_folder = 0;
index_file = 0;
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
                image = rgb2gray(imresize(imread(FilePath), [256 342]));
                
                X_test(index_file, :) = image(:);
                                                
                Y_test(index_file) = index_folder;
                
           end 
       end
   end
end

save('SVM-Full_TrainFeatures.mat', 'X_train')
save('SVM-Full_TrainLabels.mat', 'Y_train')
save('SVM-Full_TestFeatures.mat', 'X_test')
save('SVM-Full_TestLabels.mat', 'Y_test')

% 'linear' | 'gaussian' | 'rbf' | 'polynomial'
SVMModel = fitcecoc(X_train, Y_train);
[Y_predict] = predict(SVMModel, X_test);
ConfusionMatrix = confusionmat(Y_test, Y_predict);
confusionchart(ConfusionMatrix)

save('confusionchart-SVM-Full.mat', 'ConfusionMatrix');