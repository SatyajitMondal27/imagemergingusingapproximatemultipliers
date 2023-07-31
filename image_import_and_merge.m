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
alpha=128;
inalpha=256-alpha;
for i=1:500
    for j=1:500
        for k=1:3
        a=img(i,j,k);
        b=img2(i,j,k);
        i
        j        
        r1=cast(eightxeightapp(a,round(alpha/256)),'uint16');
        r2=cast(eightxeightapp(b,round(inalpha/256)),'uint16');
        img(i,j,k)=r1+(r2);
        end
    end
end

imshow(img);
