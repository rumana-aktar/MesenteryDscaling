%% ------------------------------------------------------------------------
%  Author: Rumana Aktar, 02/15/2022
%% ------------------------------------------------------------------------
%  The objective of this script is to get REFINED masks for all digits
%  The masks will be used to replace the identified/classified digits 
%  with the help of the masks, we will be able to blend this region
%  This mask will also be used for filling out the missing pixels, probably
%  by using Dr. Uhlmann's paper
%
%  Each digit is of size: 28x14
%  We can also get the location of each digit from this script for masking out
%
%  edge is used to remove black region from left and right side of a digit
%  start_x(1:12): presents the start_x of 12 digits of th burn in
%  start_x(13, 14, 15): presents the start_x of dash, colon1 and colon2
%  y1 is fixed for all digits
%  y2 is also fixed for all digits (digit height is 27 pixel)
%% ------------------------------------------------------------------------



clc;
clear all;
warning off;



edge = 5; 
start_x = [77, 96, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 232, 291, 300];
start_x = start_x + edge;

y1 = 40; 
y2 = y1 + 27;

dirname='/Volumes/E/DNCC/raw_data/seq3';
dirOut = '/Volumes/E/DNCC/raw_data/burn-in dataset/MaskingData/tests_seq3/';

files = dir(fullfile(dirname,'Fr*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;


%% ------------------------------------------------------------------------
%  j is the index of next digit/char; j can be 1-to-15

j = 1;
while j <= size(start_x, 2)
    
    %------------------------------------------------------------------------
    % as we have 12 digits and 3 especial characters, we want to save each
    % digit and char in a seperate location
    dirnameOut=sprintf('%s%02d', dirOut, j);
    if (~isdir(dirnameOut));         mkdir(dirnameOut);     end;
    
    %------------------------------------------------------------------------
    % get the first index of next digit/characted
    x1 = start_x(j); 
    x2 = x1 + 13 ;

    
    %------------------------------------------------------------------------
    % you can extract the jth location digit/char as many as you want or
    % number of frames
    i=1; 
    while i<=size(files,1)
        i

        %------------------------------------------------------------------------
        I1 = imread(fullfile(dirname, files(i).name));
        I2 = I1(y1:y2, x1:x2, :);

        %------------------------------------------------------------------------
        fname=files(i).name;
        fname_wpath=fullfile(dirnameOut,fname);
        imwrite(I2,fname_wpath);  
        
        i=i+3;        
    end
    
    %------------------------------------------------------------------------
    j = j + 1;

end   
