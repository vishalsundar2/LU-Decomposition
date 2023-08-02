function [L, U, P] = myLU(A)
    [m, n] = size(A);
    if m ~= n
        error('Input matrix must be square');
    end
    
    L = eye(n); % L as identity matrix
    P = eye(n);
    U = A; % U as input matrix
    
    for k = 1:n-1
        % Partial pivoting
        [~, pivot_row] = max(abs(U(k:n, k))); % Find row index of maximum value in column k
        pivot_row = pivot_row + k - 1; % Adjust row index to match the original matrix
        if pivot_row ~= k
            % Swap rows in U and P
            U([k, pivot_row], :) = U([pivot_row, k], :);
            P([k, pivot_row], :) = P([pivot_row, k], :);
            if k >= 2
                L([k, pivot_row], 1:k-1) = L([pivot_row, k], 1:k-1);
            end
        end
        
        % Gaussian elimination
        for i = k+1:n
            L(i, k) = U(i, k) / U(k, k);
            U(i, :) = U(i, :) - L(i, k) * U(k, :);
        end
    end
end