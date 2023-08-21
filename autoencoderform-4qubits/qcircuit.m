function output_true = qcircuit(l) 
%   This function computes two output states: ideal output and real output
%   This function has 1 required arguments:
%      l: vector of all parameter
%   output_true= qcircuit(l) gives output state of parameterized circuit, 
%   We keep many different circuits and gates in comments for tset

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
H2 = kron(H,H);
NOT = [0,1;1,0];
empty = [0 0;0 0];
empty2 = [0 0 0 0;
          0 0 0 0;
          0 0 0 0;
          0 0 0 0];
empty3 = zeros(2^3,2^3);
empty4 = zeros(2^4,2^4);
swap = [1 0 0 0;
        0 0 1 0;
        0 1 0 0;
        0 0 0 1];
swap13 = [1 0 0 0 0 0 0 0;
          0 0 0 0 1 0 0 0;
          0 0 1 0 0 0 0 0;
          0 0 0 0 0 0 1 0;
          0 1 0 0 0 0 0 0;
          0 0 0 0 0 1 0 0;
          0 0 0 1 0 0 0 0;
          0 0 0 0 0 0 0 1];
swap14 = eye(2^4);
swap14 = swapindexinuf(swap14,'0001','1000');
swap14 = swapindexinuf(swap14,'0011','1010');
swap14 = swapindexinuf(swap14,'0101','1100');
swap14 = swapindexinuf(swap14,'0111','1110');

swap15 = eye(2^5);
swap15 = swapindexinuf(swap15,'10000','00001');
swap15 = swapindexinuf(swap15,'10010','00011');
swap15 = swapindexinuf(swap15,'10100','00101');
swap15 = swapindexinuf(swap15,'10110','00111');
swap15 = swapindexinuf(swap15,'11000','01001');
swap15 = swapindexinuf(swap15,'11010','01011');
swap15 = swapindexinuf(swap15,'11100','01101');
swap15 = swapindexinuf(swap15,'11110','01111');


CNOT_12 = [1 0 0 0;
        0 1 0 0;
        0 0 0 1;
        0 0 1 0];
CNOT_21 = [1 0 0 0;
           0 0 0 1;
           0 0 1 0;
           0 1 0 0];
CR2 = [I empty;
       empty R(2)];
CR2 = swap*CR2*swap;
CR3 = [I2 empty2;
       empty2 kron(I,R(3))];
CR3 =  swap13*CR3*swap13; 
CR4 = [I3  empty3;
     empty3 kron(I2,R(4))];
CR4 =  swap14*CR4*swap14; 
CR5 = [I4 empty4;
       empty4  kron(I3,R(5))];     
CR5 =  swap15*CR5*swap15; 



%set a small t
t = 0.1;  
%construct e^{i-\rhot}   
cswap = [sigma(:,:,1) empty empty empty;
         empty sigma(:,:,1) empty empty;
         empty2 expm(-1i*swap*t)];
   

%transform the data dirctlly into quantum gate U_f    
Uf = eye(2^8);

% Uf = swapindexinuf(Uf,'00010000','00010001');
% Uf = swapindexinuf(Uf,'00100000','00100010');
% Uf = swapindexinuf(Uf,'00110000','00110011');
% Uf = swapindexinuf(Uf,'01000000','01000100');
% Uf = swapindexinuf(Uf,'01010000','01010101');
% Uf = swapindexinuf(Uf,'01100000','01100110');
% Uf = swapindexinuf(Uf,'01110000','01110111');
% 
% Uf = swapindexinuf(Uf,'10000000','10000000');
% Uf = swapindexinuf(Uf,'10010000','10010001');
% Uf = swapindexinuf(Uf,'10100000','10100011');
% Uf = swapindexinuf(Uf,'10110000','10110010');
% Uf = swapindexinuf(Uf,'11000000','11000101');
% Uf = swapindexinuf(Uf,'11010000','11010100');
% Uf = swapindexinuf(Uf,'11100000','11100111');
% Uf = swapindexinuf(Uf,'11110000','11110110');



Uf = swapindexinuf(Uf,'00010000','00010010');
Uf = swapindexinuf(Uf,'00100000','00100001');
Uf = swapindexinuf(Uf,'00110000','00110100');
Uf = swapindexinuf(Uf,'01000000','01000011');
Uf = swapindexinuf(Uf,'01010000','01010111');
Uf = swapindexinuf(Uf,'01100000','01100101');
Uf = swapindexinuf(Uf,'01110000','01110110');

Uf = swapindexinuf(Uf,'10000000','10000000');
Uf = swapindexinuf(Uf,'10010000','10010010');
Uf = swapindexinuf(Uf,'10100000','10100001');
Uf = swapindexinuf(Uf,'10110000','10110100');
Uf = swapindexinuf(Uf,'11000000','11000011');
Uf = swapindexinuf(Uf,'11010000','11010111');
Uf = swapindexinuf(Uf,'11100000','11100101');
Uf = swapindexinuf(Uf,'11110000','11110110');



input = rho0;
for i = 1:1:7
input = kron(input,rho0);
end




%% parameterized quantum circuit



hstate{1} = input;
step = 1;
 

Uhprocessindex{step,:} = {H,H,H,H,I4};
Uhprocessindex{step+1,:} = {Uf};
Uhprocessindex{step+2,:} = {H,I3,I4};
Uhprocessindex{step+3,:} = {CR2^(sin(l(1))^2),I2,I4};
Uhprocessindex{step+4,:} = {CR3^(sin(l(2))^2),I,I4};
Uhprocessindex{step+5,:} = {CR4^(sin(l(3))^2),I4};

Uhprocessindex{step+6,:} = {I,H,I2,I4};
Uhprocessindex{step+7,:} = {I,CR2^(sin(l(4))^2),I,I4};
Uhprocessindex{step+8,:} = {I,CR3^(sin(l(5))^2),I4};

Uhprocessindex{step+9,:} = {I2,H,I,I4};
Uhprocessindex{step+10,:} = {I2,CR2^(sin(l(6))^2),I4};

Uhprocessindex{step+11,:} = {I3,H,I4};

Uhprocessindex{step+12,:} = {swap14,I4};
Uhprocessindex{step+13,:} = {I,swap,I,I4};
 

[Uhprocessindex_x,Uhprocessindex_y] = size(Uhprocessindex);

for i = 1:1:Uhprocessindex_x
    hstate{i+1} = quantumprocess(Uhprocessindex{i,:},hstate{i});    
end

outputofuf = hstate{Uhprocessindex_x+1};
output_true = outputofuf;















