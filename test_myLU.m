% Create a square input matrix
A = [4, 2, 1; 8, 7, 5; 4, 8, 6];

% Call myLU function to get the output matrices L, U, and P
[L, U, P] = myLU(A);

% Verify the correctness of the LU decomposition
% Check whether A = P * L * U
reconstructed_A = P' * (L * U);
disp("Original Matrix A:");
disp(A);
disp("Reconstructed Matrix A:");
disp(reconstructed_A);

% Check whether L is lower triangular
disp("L is lower triangular:");
disp(istril(L));

% Check whether U is upper triangular
disp("U is upper triangular:");
disp(istriu(U));

% Check whether P is a permutation matrix
disp("P is a permutation matrix:");
disp(isequal(P * P', eye(size(A))));

% Define sizes of systems to test
sizes = [5, 10, 50, 100];

% Initialize arrays to store time taken for myLU and lu() for each size
time_myLU = zeros(size(sizes));
time_lu = zeros(size(sizes));

for i = 1:length(sizes)
    n = sizes(i);
    % Generate a random square matrix of size n x n
    A = rand(n);

    % Time myLU function
    tic;
    [L_myLU, U_myLU, P_myLU] = myLU(A);
    time_myLU(i) = toc;

    % Time lu() function
    A_full = full(A); % Convert A to a full matrix for lu() function
    tic;
    [L_lu, U_lu, P_lu] = lu(A_full);
    time_lu(i) = toc;
end

% Plot the time taken for different size systems
figure
plot(sizes, time_myLU, '-o', 'DisplayName', 'myLU')
hold on
plot(sizes, time_lu, '-o', 'DisplayName', 'lu()')
hold off
title('Time Taken for Different Size Systems')
xlabel('Size of System (n)')
ylabel('Time (seconds)')
legend('myLU', 'lu()')