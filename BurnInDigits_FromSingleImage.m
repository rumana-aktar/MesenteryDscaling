%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Rumana Aktar, date- 03/03/2022
% Reads a single image I1, and generates 16 labels (digit with good border) in 'dir' 
% each digit at location i, will be in different directory, dirnameOut_i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; warning off;

x1 = [ 77,  97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 233, 292, 351];
x2 = [ 99, 119, 157, 177, 215, 235, 274, 294, 332, 352, 391, 411, 138, 254, 313, 372];
y1 = 35; y2 = 72; 


dir = '/Volumes/E/DNCC/raw_data/Slide Figures/dscale/'
I1 = imread('/Volumes/E/DNCC/raw_data/DscaledResults/Frames_000945.png');


i = 1;
while i <= size(x1, 2)
    i 
    I2 = I1(y1:y2, x1(i):x2(i), :);
    
    fname=sprintf('Frame_00728_%02d.png', i);
    fname_wpath=fullfile(dir,fname);
    imwrite(I2,fname_wpath);  
    i=i+1;
end

