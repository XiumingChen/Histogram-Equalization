function J = myhisteq(I)
% This function will perform Histogram Equalization

% Convert image to HSV format
imgHSV = rgb2hsv(I);

% Extract the V portion of the HSV
vChannel = imgHSV(:,:,3);


% Create a histogram
[counts , binLocs] = imhist(vChannel);

cumHisto = cumsum(counts);
cdf = cumHisto(1);

% Create an empty array filled with zeroes
W = zeros(size(vChannel , 1) , size(vChannel, 2));


% Fill the empty array 
for i = 1:length(binLocs),
    
   % Create array to show every location where
   % the selected bin locations matches the vChannel value
   selectedIndices = (vChannel==binLocs(i));
   
   % Use the genera histogram equalization formula found
   % on https://en.wikipedia.org/wiki/Histogram_equalization
   new = round(255*(cumHisto(i) - cdf) / ((size(vChannel, 1) * size(vChannel, 2)) - cdf)); 
        
   W(selectedIndices) = new;
    

end
% Occupy full range of 0..255, element by element
imgHSV = imgHSV.*255;
imhist(W);
% Inject W into the HSV
imgHSV(:,:,3) = W;

% Convert format and return.

imgHSV = uint8(imgHSV);
imgHSV = im2double(imgHSV);
J = hsv2rgb(imgHSV);

end 