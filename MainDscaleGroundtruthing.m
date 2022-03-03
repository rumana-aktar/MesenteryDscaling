%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Rumana Aktar, date- 03/03/2022
% generate 3 kinds of dscale result with SINGLE_DIGIT
% SINGLE_DIGIT(0) : multi-digit, SINGLE_DIGIT(1): single-digit,
% SINGLE_DIGIT(2): single-digit-2nd-level
% edge: good pixel border around mask
% largeImageScale: good pixel border around mask; for
% single-digit-2nd-level when we need a larger good pixel padding
% 'dirname': segmented images; actually we could also use real image with
% classification file and digit masks
% 'dirnameMaskOverlay' probably required of single-digit-2nd-level 
% 'out': dscale result is saved here
% it also saved the cropped area too after dscaling
% calculates mean square error for differnt type of dscaling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; warning off;

%% -------------------------------------------ERROR seq3----------------------------- 
%    'D0_E4_LE4   = 353.949881'
%    'D0_E6_LE6   = 352.987628'
%    'D0_E10_LE10 = 353.198125'
%    'D0_E15_LE15 = 355.137078'
%    'D0_E20_LE20 = 358.070261'

%    'D1_E4_LE4   = 399.389777'
%    'D1_E6_LE6   = 400.840783'
%    'D1_E10_LE10 = 387.075426'
%    'D1_E15_LE15 = 387.013689'
%    'D1_E20_LE20 = 380.358370'

%    'D2_E4_LE4   = 401.119974'
%    'D2_E6_LE6 = 401.776548'
%    'D2_E6_LE12  = 398.499717'
%    'D2_E6_LE18  = 399.064670'
%    'D2_E6_LE24  = 400.576475'



%% it is averaging over the whole area; as good area is increasing, and segmented area is fixed; error is decresing
%% use mask to calculate the segmented pixels only; for each digit seperately
%% extract each digit and compute the error seperately


SINGLE_DIGIT = 1; edge = 20; overlayWithMask = 1; largeImageScale = 1;
if SINGLE_DIGIT == 0 || SINGLE_DIGIT == 1
    
    largeImageScale = 1;
    overlayWithMask = 0;
end

ERROR = [];



dirnameOrg='/Volumes/E/DNCC/raw_data/seq3';
filesOrg = dir(fullfile(dirnameOrg,'*.png'));
if( size(filesOrg,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;%


dirname='/Volumes/E/DNCC/raw_data/Segmentation_Results/Bellow100_seq3';
dirnameMaskOverlay='/Volumes/E/DNCC/raw_data/Segmentation_Results/Bellow100M_seq3';

out = '/Volumes/E/DNCC/raw_data/DscaledResults/TEST_3Dsacle_GT/Bellow100_seq3';
dirnameOut = sprintf('%s_D%d_E%d_LE%d/', out, SINGLE_DIGIT, edge, edge * largeImageScale);
dirnameOut_Cropped = sprintf('%s_D%d_E%d_LE%d_crop/', out, SINGLE_DIGIT, edge, edge * largeImageScale);

if (~isdir(dirnameOut));         mkdir(dirnameOut);     end
if (~isdir(dirnameOut_Cropped));         mkdir(dirnameOut_Cropped);     end

files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;% 

filesMaskOverlay = dir(fullfile(dirnameMaskOverlay,'*.png'));
if( size(filesMaskOverlay,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;% 



y = 100;

%% -------------------------------------------DIGIT with BORDER INFORMATION----------------------------- 
digit_x1 = [ 77,  97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 233, 292, 351];
digit_x2 = [ 99, 119, 157, 177, 215, 235, 274, 294, 332, 352, 391, 411, 138, 254, 313, 372];
digit_y1 = 35; digit_y2 = 72;




%% -------------------------------------------MASK INFORMATION----------------------------- 
mask_x1 = [ 80,    99,   138,   158,   196,   216,   255,   275,   313,   333,   372,   392,   119,   235,   294,   353];
mask_x2 = [ 96,   115,   154,   174,   212,   232,   271,   291,   329,   349,   388,   408,   135,   251,   310,   369];
mask_y1 = 39; mask_y2 = 69; 


digit_y1 = digit_y1 + y;  digit_y2 = digit_y2 + y;
mask_y1  = mask_y1  + y;  mask_y2  = mask_y2  + y;

i = 1;
while i < size(files, 1)
    i 
    I = imread(fullfile(dirname, files(i).name)); 
    if size(I, 3) == 3;    I = rgb2gray(I);   end 
    
    I_org = imread(fullfile(dirnameOrg, filesOrg(i).name)); 

    
    
    
    % --------------------------------------------------------------------------------------------------
    if SINGLE_DIGIT == 0         
        % ------------------------------there is only one dscale call for whole image
        [I, I_cropped] = getAllDigitsDscaledTogether(I, mask_x1, mask_x2, mask_y1, mask_y2, edge);
        
        x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
        x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge; 
    
    
    elseif SINGLE_DIGIT == 1
        % ------------------------------EXTRAT THE REGION AROUND EACH DIGIT and PROCESS ALL DIGIT ONE-BY-ONE-----------------------------
        [I, I_cropped] = getDigitsDscaledSeperately(I, I, edge, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
        
        
        x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
        x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge; 
    
    elseif SINGLE_DIGIT == 2
        [ID, I_cropped] = getDigitsDscaledSeperately(I, I, edge, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
        Mask = imread(fullfile(dirnameMaskOverlay, filesMaskOverlay(i).name));
       
        % use the previously segmented output as input to 2nd level Dscaled
        % algorithm and you can change the edge/border this time as we are
        % using an image without missing blocks
        edge_larger = edge * largeImageScale;
        [I, I_cropped] = getDigitsDscaledSeperately(ID, Mask, edge_larger, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
   
        x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
        x1 = x1 - edge_larger;     x2 = x2 + edge_larger;        y1 = y1 - edge_larger;  y2 = y2 + edge_larger; 
    
    else
        [ID, I_cropped] = getAllDigitsDscaledTogether(I, mask_x1, mask_x2, mask_y1, mask_y2, edge);
        Mask = imread(fullfile(dirnameMaskOverlay, filesMaskOverlay(i).name));
       
        % use the previously segmented output as input to 2nd level Dscaled
        % algorithm and you can change the edge/border this time as we are
        % using an image without missing blocks
        edge_larger = edge * largeImageScale;
        [I, I_cropped] = getDigitsDscaledSeperately(ID, Mask, edge_larger, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
   
        x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
        x1 = x1 - edge_larger;     x2 = x2 + edge_larger;        y1 = y1 - edge_larger;  y2 = y2 + edge_larger; 

        
    end
        
    
    fname=files(i).name;
    fname_wpath=fullfile(dirnameOut,fname);
    imwrite(uint8(I),fname_wpath);  
    
    fname_wpath=fullfile(dirnameOut_Cropped,fname);
    imwrite(uint8(I_cropped),fname_wpath); 
    i=i+1;
    
    %% --------------------------------------------------------------------------------------------------
    % error checking for groundtruthing
    err = getError(I_org, I, mask_x1, mask_x2, mask_y1, mask_y2);
    
    
    ERROR = [ERROR err];
end

mean_error = mean(ERROR(:));
ERROR=[ERROR mean_error];


sprintf('D%d_E%d_LE%d = %f', SINGLE_DIGIT, edge, edge * largeImageScale, mean_error)


dlmwrite(sprintf('%sError_D%d_E%d_LE%d.txt', out, SINGLE_DIGIT, edge, edge * largeImageScale), ERROR)


% A = imread('/Volumes/E/DNCC/raw_data/Segmentation/Frame_000779 3.png');
% %A =  rgb2gray(A);
% S=dscaleImage(A);
% imwrite(uint8(S), '/Volumes/E/DNCC/raw_data/Segmentation/Frame_000779_D3.png')

% %% -----------------------------SIMPLE EXAMPLE OF DSCALE---------------------------------
%  A=[173   114   107   175   180   182   183   156   165    166   140 
%  180   157   0   0   0   0   0   0   0   143   150 
%  167   173   0   0   0   0   0   0   0   119   124 
%  165   181   0   0   0   0   0   0   0   131   122 
%  169   178   187   139   160   144   170   184   130   130   126 ];
%S=round(dscaleImage(A));

% 
% A=[173   114   1   175   180   182   183   156   165    166   140 
%  180   157   0   0   0   0   0   0   0   143   150 
%  167   173   0   0   0   0   0   0   0   1   124 
%  165   181   0   0   0   0   0   0   0   131   122 
%  169   178   187   139   160   144   170   184   1   3   4 ]
% 
% S=round(dscaleImage(A))
% 
% 
% A=[255   255  255 255 255  255 255 255  255 255 255
%  255   255   0   0   0   0   0   0   0   255   255 
%  255   255   0   0   0   0   0   0   0   255   255 
%  255   255   0   0   0   0   0   0   0   255   255 
%  255   255  255 255 255  255 255 255  255 255 255 ]
% 
% S=round(dscaleImage(A))
% 
% A(A==255)
% S=round(dscaleImage(A))

% A(1, :) =128
% A(5, :) = 128
% S=round(dscaleImage(A))


% 
A = [ 300   300   300  300
      200   0       0  200
      100   200   300  400] ;
S=round(dscaleImage(A));


