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

dirname='/Volumes/E/DNCC/raw_data/GroundTruthMasks/refined/';
dirnameOut = '/Volumes/E/DNCC/raw_data/GroundTruthMasks/refined/refined_test/';
if (~isdir(dirnameOut));         mkdir(dirnameOut);     end;

files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;



for i = 1:size(start_x, 2)
    i

     I1 = imread(fullfile(dirname, files(i).name));
     [m, n] = size(I1);      M  = m+2;      N = n+2;     
     I = zeros(M, N);      I(2:end-1, 2:end-1) = I1;     
     
     se=ones(3);
     I=imdilate(I, se);
     
     %------------------------------------------------------------------------
     fname=files(i).name;
     fname_wpath=fullfile(dirnameOut,fname);
     imwrite(I,fname_wpath);  
     
     i = i + 1;
  
end

   
