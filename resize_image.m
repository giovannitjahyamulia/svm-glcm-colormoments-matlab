RootPath = '';
RootDirectory = dir(RootPath);
SavePath = '';


for i = 1:length(RootDirectory)
   FolderName = RootDirectory(i).name
   if(FolderName ~= '.' | FolderName ~= '..')
       FolderPath = strcat(RootPath, FolderName, "\");
       File = dir(FolderPath);
       for j = 1:length(File)
           FileName = File(j).name;
           if(FileName == '.')
           else
                FilePath = strcat(FolderPath, FileName);
                image = imread(FilePath);
                image_resized = imresize(image, [300 400]);
                image_resized_location = strcat(SavePath, "\", FileName);
                imwrite(image_resized, image_resized_location);
           end
       end
   end
end