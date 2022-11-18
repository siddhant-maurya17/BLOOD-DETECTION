input=imread('Im004_1.jpg');
figure(1)
imshow(input)
figure(2)
imhist(input)
gi=rgb2gray(input);
figure(3)
imshow(gi)
figure(4)
imhist(gi)
a=1;
b=40;
c=a*double(gi)+b;
c=uint8(c);
figure(5)
imshow(c)
figure(6)
imhist(c)
h=histeq(gi);
figure(7)
imshow(h)
figure(8)
imhist(h)
L1=imadd(c,h);
figure(9)
imshow(L1)
L2=imsubtract(c,h)
figure(10)
imshow(L2)
L3=imadd(L1,L2);
figure(11)
imshow(L3)
LH=imhist(L3)
figure(12)
imhist(L3)
l=graythresh(L3);
bw = imbinarize(L3,l);
figure,
imshow(bw);
title('otsu thresholding method')
BW= bwareaopen(bw,700);
BW0=imclearborder(BW);
 se = strel('disk',3);
 BW=imclose(BW,se);
 figure,
 imshow(BW);
 title('removal of small particles');
BW1 = edge(BW,'sobel');
figure,
imshow(BW1)
title('edge detection by sobel operator');
d=im2bw(BW1);
figure,imshow(d),title('Original image in black and white')
e=imfill(d,'holes');
figure,imshow(e),title('Filled image in black and white')
f=bwlabel(e)
figure,imshow(f),title('Labelled image in black and white')
vislabels(f),title('Each object labelled')
S4 = regionprops(f,'MinorAxisLength','MajorAxisLength','Area','Perimeter','centroid');
for cnt = 1:length(S4)
score1(cnt) = abs(1-(S4(cnt).MajorAxisLength-S4(cnt).MinorAxisLength)...
/max([S4(cnt).MajorAxisLength,S4(cnt).MinorAxisLength]));
score2(cnt) = abs(1 - abs(pi*((mean([S4(cnt).MajorAxisLength,...
S4(cnt).MinorAxisLength]))/2)^2-S4(cnt).Area)/S4(cnt).Area);
score3(cnt) = abs(1 - abs(pi*(max([S4(cnt).MajorAxisLength,...
S4(cnt).MinorAxisLength]))-S4(cnt).Perimeter)/S4(cnt).Perimeter);
end
score = mean([score1;score2;score3]);
for cnt = 1:length(S4)
text(S4(cnt).Centroid(1),S4(cnt).Centroid(2),num2str(score(cnt)),'color','red');
end
A=[S4.Area]
mean(A)
var(A)
radius=(sqrt(A/pi))
c=[score]
