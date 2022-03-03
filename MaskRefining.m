clc; clear all; warning off;

dirname='/Volumes/E/DNCC/raw_data/burn-in dataset/wholeFrames_test/masks';
files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;


%% dot and dot2 are basically same
% %% ------------------------------------------------------------------------
% %% mask for dot2
% I = imread(fullfile(dirname, 'dot2.png'));
% I = rgb2gray(I)
% I(I>=90) = 255
% I(I<255) = 0
% I(end, 11) = 0
% imwrite(uint8(I), sprintf('%s/dot2G.png', dirname))
% I2 = I
% 
% %% ------------------------------------------------------------------------
% %% mask for dot
% I = imread(fullfile(dirname, 'dot.png'));
% I = rgb2gray(I)
% I(I>=90) = 255
% I(I<255) = 0
% I(end, 11) = 0
% imwrite(uint8(I), sprintf('%s/dotG.png', dirname))
% 
% diff = I2 - I


% %% ------------------------------------------------------------------------
% %% mask for dash
% I = imread(fullfile(dirname, 'dash.png'));
% I = rgb2gray(I)
% I(I>=90) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/dashG.png', dirname))



% %% ------------------------------------------------------------------------
% %% mask for 1
% I = imread(fullfile(dirname, '3.png'));
% I = rgb2gray(I)
% I(I>=90) = 255
% I(I<255) = 0
% I(:, 10) = 255
% imwrite(uint8(I), sprintf('%s/3G.png', dirname))
% 
% %% ------------------------------------------------------------------------
% %% mask for 1
% I = imread(fullfile(dirname, '8.png'));
% I = rgb2gray(I)
% I(I>=40) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/8G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 1
% I = imread(fullfile(dirname, '0.png'));
% I = rgb2gray(I)
% I(I>=80) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/0G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 1
% I = imread(fullfile(dirname, '1.png'));
% I = rgb2gray(I)
% I(I>=80) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/1G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 4
% I = imread(fullfile(dirname, '4.png'));
% I = rgb2gray(I)
% I(I>=80) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/4G.png', dirname))

% %% ------------------------------------------------------------------------
% %% mask for 9
% I = imread(fullfile(dirname, '9.png'));
% I = rgb2gray(I)
% I(I>=80) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/9G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 7
% I = imread(fullfile(dirname, '7.png'));
% I = rgb2gray(I)
% I(I>=100) = 255
% I(I<255) = 0
% I(:, 10) = 255
% imwrite(uint8(I), sprintf('%s/7G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 5
% I = imread(fullfile(dirname, files(5).name));
% I = rgb2gray(I)
% I(I>=97) = 255
% I(I<255) = 0
% imwrite(uint8(I), sprintf('%s/5G.png', dirname))


% %% ------------------------------------------------------------------------
% %% mask for 6
% I = imread(fullfile(dirname, files(6).name));
% I = rgb2gray(I);
% I(I>=100) = 255;
% I(I<255) = 0;
% imwrite(uint8(I), sprintf('%s/6G.png', dirname))


%% ------------------------------------------------------------------------
% %% mask for 2
% I = imread(fullfile(dirname, files(2).name));
% I = rgb2gray(I);
% I(I>=100) = 255;
% I(5:12, 10) = 255 ;
% I(I<255) = 0;
% imwrite(uint8(I), sprintf('%s/2G.png', dirname))

 
