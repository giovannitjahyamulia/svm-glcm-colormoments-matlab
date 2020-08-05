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
                image = imread(FilePath);
                
                % extract color channels
                R = double(image(:, :, 1));
                G = double(image(:, :, 2));
                B = double(image(:, :, 3));

                meanR = mean(R(:));
                meanG = mean(G(:));
                meanB = mean(B(:));
                
                varianceR  = std(R(:));
                varianceG  = std(G(:));
                varianceB  = std(B(:));

                differenceR = double(0);
                differenceG = double(0);
                differenceB = double(0);
                for row = 1:length(image)
                    for col = 1:length(image(1))
                        differenceR = differenceR + double(image(row, col, 1) - meanR);
                        differenceG = differenceG + double(image(row, col, 2) - meanG);
                        differenceB = differenceB + double(image(row, col, 3) - meanB);
                    end
                end

                N = length(image) * length(image(1));
                skewnessR = nthroot(((differenceR^3)/N), 3);
                skewnessG = nthroot(((differenceG^3)/N), 3);
                skewnessB = nthroot(((differenceB^3)/N), 3);
                                
                X_train(index_file, 1) = meanR;
                X_train(index_file, 2) = meanG;
                X_train(index_file, 3) = meanB;
                
                X_train(index_file, 4) = varianceR;
                X_train(index_file, 5) = varianceG;
                X_train(index_file, 6) = varianceB;
                
                X_train(index_file, 7) = skewnessR;
                X_train(index_file, 8) = skewnessG;
                X_train(index_file, 9) = skewnessB;
                                
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
                
                % extract color channels
                R = double(image(:, :, 1));
                G = double(image(:, :, 2));
                B = double(image(:, :, 3));

                meanR = mean(R(:));
                meanG = mean(G(:));
                meanB = mean(B(:));
                
                varianceR  = std(R(:));
                varianceG  = std(G(:));
                varianceB  = std(B(:));

                differenceR = double(0);
                differenceG = double(0);
                differenceB = double(0);
                for row = 1:length(image)
                    for col = 1:length(image(1))
                        differenceR = differenceR + double(image(row, col, 1) - meanR);
                        differenceG = differenceG + double(image(row, col, 2) - meanG);
                        differenceB = differenceB + double(image(row, col, 3) - meanB);
                    end
                end

                N = length(image) * length(image(1));
                skewnessR = nthroot(((differenceR^3)/N), 3);
                skewnessG = nthroot(((differenceG^3)/N), 3);
                skewnessB = nthroot(((differenceB^3)/N), 3);
                
                X_test(index_file, 1) = meanR;
                X_test(index_file, 2) = meanG;
                X_test(index_file, 3) = meanB;
                
                X_test(index_file, 4) = varianceR;
                X_test(index_file, 5) = varianceG;
                X_test(index_file, 6) = varianceB;
                
                X_test(index_file, 7) = skewnessR;
                X_test(index_file, 8) = skewnessG;
                X_test(index_file, 9) = skewnessB;
                                                
                Y_test(index_file) = index_folder;
                
           end 
       end
   end
end

save('SVM-ColorMoments_TrainFeatures.mat', 'X_train')
save('SVM-ColorMoments_TrainLabels.mat', 'Y_train')
save('SVM-ColorMoments_TestFeatures.mat', 'X_test')
save('SVM-ColorMoments_TestLabels.mat', 'Y_test')

% 'linear' | 'gaussian' | 'rbf' | 'polynomial'
SVMModel = fitcecoc(X_train, Y_train);
[Y_predict] = predict(SVMModel, X_test);
ConfusionMatrix = confusionmat(Y_test, Y_predict)
confusionchart(ConfusionMatrix)

save('SVM-ColorMoments_ConfusionMatrix.mat', 'ConfusionMatrix');