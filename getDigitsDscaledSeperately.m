%% ---------------------------------------------------------------------------------------------- 
% % ------------------------------EXTRACT THE REGION AROUND EACH DIGIT SEPERATELY---------------------------
% % ------------------------------there is multiple dscale call (one for each digit) in an image
% %% -------------------------------------------MASK INFORMATION--------------------------------- 
% mask_x1 = [ 80,    99,   138,   158,   196,   216,   255,   275,   313,   333,   372,   392,   119,   235,   294,   353];
% mask_x2 = [ 96,   115,   154,   174,   212,   232,   271,   291,   329,   349,   388,   408,   135,   251,   310,   369];
% mask_y1 = 39; mask_y2 = 69; 
% ---------------------------------------------------------------------------------------------- 
% % -------------------------------------------DIGIT with BORDER INFORMATION----------------------------- 
% digit_x1 = [ 77,  97, 135, 155, 193, 213, 252, 272, 310, 330, 369, 389, 116, 233, 292];
% digit_x2 = [ 99, 119, 157, 177, 215, 235, 274, 294, 332, 352, 391, 411, 138, 254, 313];
% digit_y1 = 35; digit_y2 = 72; 



%% ---------------------------------------------------------------------------------------------- 
function [Iout, I_cropped] = getDigitsDscaledSeperately(I, Mask, edge, overlayWithMask, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2)
    Iout = I;    
    
    j = 1; 
    while j <= size(digit_x1, 2)
        j;
        x1 = digit_x1(j);    x2 = digit_x2(j);     y1 = digit_y1;    y2 = digit_y2;
        x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge;
        
        if overlayWithMask == 1
            %------------ get the digit_without_border --------------------
            x11 = mask_x1(j);    x22 = mask_x2(j);          y11 = mask_y1;    y22 = mask_y2;
            
            %------------ I_overlay_block is of original size -------------
            I_overlay_block = getOverlayImageMask(I, Mask, x11, x22, y11, y22);
            S=dscaleImage(I_overlay_block(y1:y2, x1:x2));
            
%             %------------ save few of the resuls for presentation -------------
%             crp = I_overlay_block(mask_y1 - 20 : mask_y2 + 20, mask_x1(1)- 20:  max(mask_x2(:))+20);
%             imwrite(uint8(crp), sprintf('SecondLevel_input_to_Dscale_728_%06d.png', j))

            Iout(y1:y2, x1:x2) = S;
        else        
            S=dscaleImage(I(y1:y2, x1:x2));
            I(y1:y2, x1:x2) = S;             
        end
             
        j=j+1;
    end
    x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
    x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge;
    
    
    if overlayWithMask == 0
        Iout = I;
    end
    
    I_cropped=Iout(y1:y2, x1:x2);
end


%% use the digit without any border otherwise, the mask from next and previous image will affect the result
function I = getOverlayImageMask(I, Mask, x1, x2, y1, y2)
    blockI = I(y1:y2, x1:x2);
    blockM = Mask(y1:y2, x1:x2);
    
    blockI(blockM==0)=0;
    I(y1:y2, x1:x2) = blockI;
    
end

% %% ---------------------------------------------------------------------------------------------- 
% function [I, I_cropped] = getDigitsDscaledSeperately(I, edge, digit_x1, digit_x2, digit_y1, digit_y2, mask_x1, mask_x2, mask_y1, mask_y2)
%     j = 1; 
%     while j <= size(digit_x1, 2)
%         j
%         x1 = digit_x1(j);    x2 = digit_x2(j);     y1 = digit_y1;    y2 = digit_y2;
%         x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge;        
%         S=dscaleImage(I(y1:y2, x1:x2));
%         I(y1:y2, x1:x2) = S;  
%              
%         j=j+1;
%     end
%     x1 = mask_x1(1);    x2 = max(mask_x2(:));     y1 = mask_y1;    y2 = mask_y2;
%     x1 = x1 - edge;     x2 = x2 + edge;        y1 = y1 - edge;  y2 = y2 + edge;
%     I_cropped=I(y1:y2, x1:x2);
% end