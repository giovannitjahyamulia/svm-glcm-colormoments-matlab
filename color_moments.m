image = imread('test.jpg');
% extract color channels
R = double(image(:, :, 1));
G = double(image(:, :, 2));
B = double(image(:, :, 3));

meanR = mean(R(:));
varianceR  = std(R(:));
meanG = mean(G(:));
varianceG  = std(G(:));
meanB = mean(B(:));
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

% varianceR = nthroot(((differenceR^2)/N), 2);
% varianceG = nthroot(((differenceG^2)/N), 2);
% varianceB = nthroot(((differenceB^2)/N), 2);

% construct output vector
if(varianceR == stdR & varianceG == stdG & varianceB == stdB)
    colorMoments(1, :) = [meanR stdR varianceR meanG stdG varianceG meanB stdB varianceB]
else
    colorMoments(1, :) = [meanR stdR meanG stdG meanB stdB]
end

% mean = (meanR + meanG + meanB)/3
% std = (stdR + stdG + stdB)/3

