%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Rumana Aktar, date- 03/03/2022
% Reads dataset from 'dirname' and generates test (unlabeled) datasets with 12 digits 
% each digit at location i, will be in different directory, dirnameOut_i
% optional parameter, edge can be set to 4 for generating labels for masks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; warning off;

edge = 0; % 4 if we want only mask without any good pixels around labels
st = [77, 97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389,  116, 232, 291];
st = st + edge;


dirname='/Volumes/E/DNCC/raw_data/seq3/';
files = dir(fullfile(dirname,'Fr*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return;end;% 

y1 = 35; 
y2 = y1 + 36;


    
j =1 ;
while j <= size(st, 2)
    
    dirnameOut=sprintf('/Volumes/E/DNCC/raw_data/burn-in dataset/TEST/%02d', j);
    if (~isdir(dirnameOut))
        mkdir(dirnameOut);
    end
    x1 = st(j); x2 = x1 + 21 - 2 * edge ;   

    
    i=1;
    while i<=10 %size(files,1)
        i
        I1 = imread(fullfile(dirname, files(i).name));       
        I2 = I1(y1:y2, x1:x2, :);
        [y1, y2, x1, x2];

        fname=sprintf('Frame_%04d_%d_%d.png', i, x1, y1);
        fname=files(i).name;
        fname_wpath=fullfile(dirnameOut,fname);
        imwrite(I2,fname_wpath);  
        i=i+1;
    
    end
    j = j +1;

end   
