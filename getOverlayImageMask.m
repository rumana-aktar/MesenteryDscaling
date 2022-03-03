function I = getOverlayImageMask(I, Mask, x1, x2, y1, y2)
    blockI = I(y1:y2, x1:x2);
    blockM = Mask(y1:y2, x1:x2);
    
    blockI(blockM==0)=0;
    I(y1:y2, x1:x2) = blockI;
    
end