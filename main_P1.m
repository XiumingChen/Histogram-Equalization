clear;

img = imread('P1-snow.jpg');
out = myhisteq(img);
imwrite(out, 'P1-snow-out.jpg')
