%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Rumana Aktar, date- 03/03/2022
% Reads images from two directory, dirname, dirname2 and compare pairwise
% zero-valued pixels (which are not in mask area) in 'dirname' are replaced with 1 before dscaling 
% zero-valued pixels (which are not in mask area) in 'dirname2' remains as unchanged
% no change or difference in dscale output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; warning off;

x1 = [ 77,  97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 233, 292];
x2 = [ 99, 119, 157, 177, 215, 235, 274, 294, 332, 352, 391, 411, 138, 254, 313];
y1 = 35; y2 = 72; 


dirname = '/Volumes/E/DNCC/raw_data/Segmentation_Results/test/';
dirname2 = '/Volumes/E/DNCC/raw_data/Segmentation_Results/test_no_zero_replacements/';

files = dir(fullfile(dirname,'0*.png'));
files2 = dir(fullfile(dirname2,'0*.png'));

x1 = 77; x2 = 391; y1 = 35; y2 = 72;

i = 1
while i <= size(files, 1)
    i 
    
    I1 = imread(fullfile(dirname, files(i).name));
    I2 = imread(fullfile(dirname2, files2(i).name));
    O1 = I1(y1:y2, x1:x2, :);
    O2 = I2(y1:y2, x1:x2, :);
    
    diff= abs(O1-O2);
    ii = sum(diff(:,:,:))
    
%     fname=sprintf('Frame_00728_%02d.png', i);
%     fname_wpath=fullfile(dir,fname);
%     imwrite(I2,fname_wpath);  
    i=i+1;
end

