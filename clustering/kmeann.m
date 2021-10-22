clc
clear all
close all
%Read an Image
img= imread('C:\Users\Nishant Jain\Downloads\fund.jpg');

%Convert the Image into gray scale and into double format 
%Uint8 format restrict the pixel value between 0 and 255. Converting the 
%image into double format allow the pixel value to go beyond it and to have 
%value in real number form
im=double(rgb2gray(img));

% Nc =  Number of K Mean Cluster you need to form
Nc = 20;
% If the difference between the old and the new cluster mean values lies within
% th that is the Threshold value , then iteration or procedure of updating the 
% cluster mean value will be stopped
th=10;
% count will keep a track of the number of time cluster mean values are updated
counntt=1;
% Initialization of the mean value of Nc number of clusters
% Matrix m contains the mean value of Nc number of clusters
m=0:Nc-1;
m=m.*(255/Nc)+(255/(2*Nc));

% updated mean values will be stored in matrix new_m 
new_m = zeros(1,Nc);
[r,c] = size(im);

while((max(m-new_m)>th)&&(counntt<5))
  if counntt!=1
    m=new_m;
  end
  counntt=counntt+1;
  % Matrix "out" will carry the difference of all the pixels from Nc number of
  % mean values
  out = zeros(size(im,1),size(im,2),Nc);
  for i = 1:Nc
    out(:,:,i)=abs(im-m(i));  
  end
  % indd is a matrix of dimension same as the original image and each element 
  % will carry the number that indicates about the mean value with which the 
  % distance of the pixel value of the original image is the closest
  [~,indd]=min(out,[],3);
  % for loop will determine the new mean values of the Clusters
  for i = 1:Nc
    new_m(i) = sum(sum((indd==i).*im))/(sum(sum((indd==i)))+eps);
  end
end

% To display the original image
imshow(img)

% To display the clustered image
figure, imshow(uint8(indd.*(255/Nc)))

