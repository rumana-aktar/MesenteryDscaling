function [S_impainted]=dscaleImage(A)
    A=double(A);
    
    %% dscale the image
    [S, dl, dr] = dscale(double(A));
    
   

    %% 
    S(S==0)=1;
    RowDiag=diag(dl);
    ColDiag=diag(dr);
    
    
    
    S_impainted=inv(RowDiag)*S*inv(ColDiag); 
    
end