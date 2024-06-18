function output = CR(n)

if n == 2
    swap2 = [1 0 0 0;
        0 0 1 0;
        0 1 0 0;
        0 0 0 1];
    output = [eye(2) zeros(2);
        zeros(2) R(2)];
    output = swap2*output*swap2;


else
    swapn = swap(n);
    output = [eye(2^(n-1)) zeros(2^(n-1));
        zeros(2^(n-1)) kron(eye(2^(n-2)),R(n))];
    output = swapn*output*swapn;
end