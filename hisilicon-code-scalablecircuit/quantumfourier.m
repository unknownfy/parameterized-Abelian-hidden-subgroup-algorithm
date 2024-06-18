function outputofuf  = quantumfourier(n,l)
%n: number of input
%l: variational parameter

%set basic constants we need
%basic quantum state
ket0 = [1;0];
ket1 = [0;1];
ket = [ket0,ket1];
rho0 = ket0*ket0';
rho1 = ket1*ket1';

%Pauli matrix
sigma(:,:,1) = eye(2);
sigma(:,:,2) = [0 1;1 0];
sigma(:,:,3) = [0 -1i;1i 0];
sigma(:,:,4) = [1 0;0 -1];
%identity matrix and empty matrix
I = eye(2);
I2 = eye(4);
I3 = eye(8);
I4 = eye(2^4);
I5 = eye(2^5);
% Hadamard gate
H = 1/sqrt(2)*[1 1;1 -1];
% other useful gate



CNOT_12 = [1 0 0 0;
        0 1 0 0;
        0 0 0 1;
        0 0 1 0];
CNOT_21 = [1 0 0 0;
           0 0 0 1;
           0 0 1 0;
           0 1 0 0];





step = 1;

for j = 1:1:n
    fullgate{j,:} = combinegate({eye(2^(j-1)),H,eye(2^(n-j))});
    if j<n
        for i = 2:1:n-j+1
            fullgate{j,:} = combinegate({eye(2^(j-1)),CR(i)^(sin(l(step)*pi/2)^2),eye(2^(n-i-j+1))})*fullgate{j,:};
            step = step+1;
        end
    end
end

step = 1;
fullgate{n+1,:} = eye(2^n);
for j = 1:1:n
    if j<n
        for i = 2:1:n-j+1
            fullgate{n+1,:} = combinegate({eye(2^(j-1)),swap(i)^(sin(l(step)*pi/2)^2),eye(2^(n-i-j+1))})*fullgate{n+1,:};
            step  = step+1;
        end
    end
end
%^(sin(l(step))^2)

%^(sin(l(i+(j-1)*n))^2)
outputofuf = fullgate;


