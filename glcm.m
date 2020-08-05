RootPath = 'F:\SKRIPSI 2019-2020\6. Giovanni Tjahyamulia - 1620250081\Code\resized\';
Root = dir(RootPath);

features = [];
label = [];

for i = 1:length(Root)
   FolderName = Root(i).name;
   if(FolderName ~= '.' | FolderName ~= '..')
       FolderPath = strcat(RootPath, FolderName, "\");
       File = dir(FolderPath);
       
       for j = 1:length(File)
           FileName = File(j).name;
           
           if(FileName == '.')
               
           else
               FilePath = strcat(FolderPath, FileName)
               img = imread(FilePath);
               stats = graycoprops(rgb2gray(img))
           end 
       end
   end
end