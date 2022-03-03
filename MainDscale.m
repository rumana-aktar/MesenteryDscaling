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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; warning off;

SINGLE_DIGIT = 2; edge = 6; overlayWithMask = 1; largeImageScale = 2;
if SINGLE_DIGIT == 0 || SINGLE_DIGIT == 1
    largeImageScale = 1;
    overlayWithMask = 0;
end

dirname='/Volumes/E/DNCC/raw_data/Segmentation_Results/wo8_replacement/Real_seq3';
dirnameMaskOverlay='/Volumes/E/DNCC/raw_data/Segmentation_Results/wo8_replacement/RealM_seq3';
out = '/Volumes/E/DNCC/raw_data/DscaledResults/wo8_replacement/Real_seq3';



dirnameOut = sprintf('%s_D%d_E%d_LE%d/', out, SINGLE_DIGIT, edge, edge * largeImageScale);
dirnameOut_Cropped = sprintf('%s_D%d_E%d_LE%d_crop/', out, SINGLE_DIGIT, edge, edge * largeImageScale);

if (~isdir(dirnameOut));         mkdir(dirnameOut);     end
if (~isdir(dirnameOut_Cropped));         mkdir(dirnameOut_Cropped);     end

files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;% 

filesMaskOverlay = dir(fullfile(dirnameMaskOverlay,'*.png'));
if( size(filesMaskOverlay,1) < 2 );     disp('at least two images with appropriate format in the directory');     return; end;% 



%% -------------------------------------------DIGIT with BORDER INFORMATION----------------------------- 
digit_x1 = [ 77,  97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 233, 292, 351];
digit_x2 = [ 99, 119, 157, 177, 215, 235, 274, 294, 332, 352, 391, 411, 138, 254, 313, 372];
digit_y1 = 35; digit_y2 = 72;


%% -------------------------------------------MASK INFORMATION----------------------------- 
mask_x1 = [ 80,    99,   138,   158,   196,   216,   255,   275,   313,   333,   372,   392,   119,   235,   294,   353];
mask_x2 = [ 96,   115,   154,   174,   212,   232,   271,   291,   329,   349,   388,   408,   135,   251,   310,   369];
mask_y1 = 39; mask_y2 = 69; 


i = 1;
while i < size(files, 1)
    i 
    
     
    I = imread(fullfile(dirname, files(i).name)); 
    if size(I, 3) == 3;    I = rgb2gray(I);   end     
    
    
    
    % --------------------------------------------------------------------------------------------------
    if SINGLE_DIGIT == 0         
        % ------------------------------there is only one dscale call for whole image
        [I, I_cropped] = getAllDigitsDscaledTogether(I, mask_x1, mask_x2, mask_y1, mask_y2, edge);
    
    elseif SINGLE_DIGIT == 1
        % ------------------------------EXTRAT THE REGION AROUND EACH DIGIT and PROCESS ALL DIGIT ONE-BY-ONE-----------------------------
        [I, I_cropped] = getDigitsDscaledSeperately(I, I, edge, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
    else
        [ID, I_cropped] = getAllDigitsDscaledTogether(I, mask_x1, mask_x2, mask_y1, mask_y2, edge);
        Mask = imread(fullfile(dirnameMaskOverlay, filesMaskOverlay(i).name));
       
        % use the previously segmented output as input to 2nd level Dscaled
        % algorithm and you can change the edge/border this time as we are
        % using an image without missing blocks
        edge_larger = edge * largeImageScale;
        [I, I_cropped] = getDigitsDscaledSeperately(ID, Mask, edge_larger, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2);
   
     
    
        
    end
        
    
    fname=files(i).name;
    fname_wpath=fullfile(dirnameOut,fname);
    imwrite(uint8(I),fname_wpath);  
    
    fname_wpath=fullfile(dirnameOut_Cropped,fname);
    imwrite(uint8(I_cropped),fname_wpath); 
    i=i+1;
    
    
end




% %% -----------------------------SIMPLE EXAMPLE OF DSCALE---------------------------------
%  A=[173   114   107   175   180   182   183   156   165    166   140 
%  180   157   0   0   0   0   0   0   0   143   150 
%  167   173   0   0   0   0   0   0   0   119   124 
%  165   181   0   0   0   0   0   0   0   131   122 
%  169   178   187   139   160   144   170   184   130   130   126 ];
%S=round(dscaleImage(A));


% % 
% A = [ 300   300   300  300
%       200   0       0  200
%       100   200   300  400] ;
% S=round(dscaleImage(A));


