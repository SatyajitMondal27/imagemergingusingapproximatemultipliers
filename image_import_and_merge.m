%Basic algorithm to import image for multiplication
clc;
clear all
close all
% Read image as unsigned 8-bit integer
img = im2uint8(imread('image1.png'));
img2 = im2uint8(imread('image3.png'));
img=imresize(img, [500, 500]);
img2=imresize(img2, [500, 500]);
% Display image
x=zeros(500,500,1);
imshow(img);
alpha=1;
inalpha=256-alpha;
for i=100:500
    for j=100:500
        for k=1:3
        a=img(i,j,k);
        b=img2(i,j,k);
        i
        j
        
        r1=cast(eightxeight(a,1),'uint16');
        
        img(i,j,k)=r1;
        end
    end
end
