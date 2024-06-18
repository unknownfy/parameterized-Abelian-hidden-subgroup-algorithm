ket0 = [1;0];
ket1 = [0;1];
rho0 = ket0*ket0';
rho1 = ket1*ket1';
%divide parameter into two part: U1 portion and U2 portion 
%lengthl = length(l);

%Pauli matrix
sigma(:,:,1) = eye(2);
sigma(:,:,2) = [0 1;1 0];
sigma(:,:,3) = [0 -1i;1i 0];
sigma(:,:,4) = [1 0;0 -1];
%identity matrix and empty matrix
I = eye(2);
I2 = eye(4);
I3 = eye(8);
% Hadamard gate
H = 1/sqrt(2)*[1 1;1 -1];
H = 1/sqrt(2)*[1 1;1 -1];
H2 = kron(H,H);
NOT = [0,1;1,0];
empty = [0 0;0 0];
empty2 = [0 0 0 0;
          0 0 0 0;
          0 0 0 0;
          0 0 0 0];
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
       
QFT = FourierMatrix(8);
%input = 1/2*(kron(kron(ket0,ket0),ket0)+kron(kron(ket0,ket1),ket1)+kron(kron(ket1,ket0),ket0)+kron(kron(ket1,ket1),ket1));
%state = kron(QFT,I)*input*(kron(QFT,I)*input)';
A = swap13*kron(I2,H)*kron(I,CR2^(1))*kron(kron(I,H),I)*CR3^(1)*kron(CR2^(1),I)*kron(H,I2);
B = swap13*kron(H,I2)*kron(CR2,I)*kron(kron(I,H),I)*CR3*kron(I,CR2)*kron(I2,H)*swap13;

QFT-A
QFT-B


