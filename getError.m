function err = getError(I_org, I, mask_x1, mask_x2, mask_y1, mask_y2)
    err = 0;
    
    for i = 1:16

        err = err + immse(I_org(mask_y1: mask_y2, mask_x1(i):mask_x2(i)), I(mask_y1: mask_y2, mask_x1(i):mask_x2(i)) );
    end
    
    
    err = err / 16;
end