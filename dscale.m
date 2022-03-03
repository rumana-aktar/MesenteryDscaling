function [S, dl, dr] = dscale(A)

    tol = 1e-15;   

    [m, n] = size(A);

    L = zeros(m, n);    M = ones(m, n);  

    S = sign(A);   A = abs(A);

    idx = find(A > 0.0);  L(idx) = log(A(idx));
    
    %% get those idx whose pixel values are 0 and were not processed before
    idx = setdiff(1 : numel(A), idx);

    L(idx) = 0;   
    M(idx) = 0;  

    r = sum(M, 2);   c = sum(M, 1);  
    
    v = zeros(1, n);
    
    u = zeros(m, 1);
    

    dx = 2*tol; 

    while (dx > tol)

        idx = c > 0;
        
        p = sum(L(:, idx), 1) ./ c(idx);
        
        p_all_row=repmat(p, m, 1) ;

        L(:, idx) = L(:, idx) - p_all_row .* M(:, idx);

        v(idx) = v(idx) - p;  dx = mean(abs(p));
                
        
        

        
        
        idx = r > 0;

        p = sum(L(idx, :), 2) ./ r(idx);

        L(idx, :) = L(idx, :) - repmat(p, 1, n) .* M(idx, :);

        u(idx) = u(idx) - p;  dx = dx + mean(abs(p));
        

    end   

    dl = exp(u); 
    dr = exp(v);

    S = S.* exp(L);

end