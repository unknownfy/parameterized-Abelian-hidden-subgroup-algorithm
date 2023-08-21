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

%transform the data dirctlly into quantum gate U_f    
Uf = eye(2^10);
Uf = swapindexinuf(Uf,'0000100000','0000100001');
Uf = swapindexinuf(Uf,'0001000000','0001000010');
Uf = swapindexinuf(Uf,'0001100000','0001100011');
Uf = swapindexinuf(Uf,'0010000000','0010000100');
Uf = swapindexinuf(Uf,'0010100000','0010100101');
Uf = swapindexinuf(Uf,'0011000000','0011000110');
Uf = swapindexinuf(Uf,'0011100000','0011100111');
Uf = swapindexinuf(Uf,'0100000000','0100001000');
Uf = swapindexinuf(Uf,'0100100000','0100101001');
Uf = swapindexinuf(Uf,'0101000000','0101001010');
Uf = swapindexinuf(Uf,'0101100000','0101101011');
Uf = swapindexinuf(Uf,'0110000000','0110001100');
Uf = swapindexinuf(Uf,'0110100000','0110101101');
Uf = swapindexinuf(Uf,'0111000000','0111001110');
Uf = swapindexinuf(Uf,'0111100000','0111101111');


Uf = swapindexinuf(Uf,'1000100000','1000100001');
Uf = swapindexinuf(Uf,'1001000000','1001000010');
Uf = swapindexinuf(Uf,'1001100000','1001100011');
Uf = swapindexinuf(Uf,'1010000000','1010000100');
Uf = swapindexinuf(Uf,'1010100000','1010100101');
Uf = swapindexinuf(Uf,'1011000000','1011000110');
Uf = swapindexinuf(Uf,'1011100000','1011100111');
Uf = swapindexinuf(Uf,'1100000000','1100001000');
Uf = swapindexinuf(Uf,'1100100000','1100101001');
Uf = swapindexinuf(Uf,'1101000000','1101001010');
Uf = swapindexinuf(Uf,'1101100000','1101101011');
Uf = swapindexinuf(Uf,'1110000000','1110001100');
Uf = swapindexinuf(Uf,'1110100000','1110101101');
Uf = swapindexinuf(Uf,'1111000000','1111001110');
Uf = swapindexinuf(Uf,'1111100000','1111101111');



%set a small t
t = 0.1;  
%construct e^{i-\rhot}   
cswap = [sigma(:,:,1) empty empty empty;
         empty sigma(:,:,1) empty empty;
         empty2 expm(-1i*swap*t)];

     

input = rho0;
for i = 1:1:9
input = kron(input,rho0);
end



%% parameterized quantum circuit



hstate{1} = input;
step = 1;

Uhprocessindex{step,:} = {H,H,H,H,H,I5};
Uhprocessindex{step+1,:} = {Uf};
Uhprocessindex{step+2,:} = {H,I4,I5};
Uhprocessindex{step+3,:} = {CR2^(sin(l(1))^2),I3,I5};
Uhprocessindex{step+4,:} = {CR3^(sin(l(2))^2),I2,I5};
Uhprocessindex{step+5,:} = {CR4^(sin(l(3))^2),I,I5};
Uhprocessindex{step+6,:} = {CR5^(sin(l(4))^2),I5};
Uhprocessindex{step+7,:} = {I,H,I3,I5};
Uhprocessindex{step+8,:} = {I,CR2^(sin(l(5))^2),I2,I5};
Uhprocessindex{step+9,:} = {I,CR3^(sin(l(6))^2),I,I5};
Uhprocessindex{step+10,:} = {I,CR4^(sin(l(7))^2),I5};
Uhprocessindex{step+11,:} = {I2,H,I2,I5};
Uhprocessindex{step+12,:} = {I2,CR2^(sin(l(8))^2),I,I5};
Uhprocessindex{step+13,:} = {I2,CR3^(sin(l(9))^2),I5};
Uhprocessindex{step+14,:} = {I3,H,I,I5};
Uhprocessindex{step+15,:} = {I3,CR2^(sin(l(10))^2),I5};
Uhprocessindex{step+16,:} = {I4,H,I5};
Uhprocessindex{step+17,:} = {swap15,I5};
Uhprocessindex{step+18,:} = {I,swap13,I,I5};
 
 

[Uhprocessindex_x,Uhprocessindex_y] = size(Uhprocessindex);

for i = 1:1:Uhprocessindex_x
    hstate{i+1} = quantumprocess(Uhprocessindex{i,:},hstate{i});    
end

outputofuf = hstate{Uhprocessindex_x+1};
output_true = outputofuf;













