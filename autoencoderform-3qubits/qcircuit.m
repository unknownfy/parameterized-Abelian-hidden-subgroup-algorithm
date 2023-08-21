function output_true = qcircuit(l,data) 
%   This function computes two output states: ideal output and real output
%   This function has 2 required arguments:
%      l: vector of all parameter
%      data: density matrix from training data 
%   [output_true,output_idea] = qcircuit(l,data) gives output state of parameterized circuit, 
%   We keep many different circuits and gates in comments for tset


%set basic constants we need
global delta
%basic quantum state
ket0 = [1;0];
ket1 = [0;1];
ket = [ket0,ket1];
rho0 = ket0*ket0';
rho1 = ket1*ket1';
%divide parameter into two part: U1 portion and U2 portion 
lengthl = length(l);

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
% other useful gate
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
CR3 = [I2 empty2;
       empty2 kron(I,R(3))];
       


SUf = eye(16);       
SUf(10,14) = 1;
SUf(14,10) = 1;
SUf(10,10) = 0;
SUf(14,14) = 0;

       
       
CUf = eye(128);
CUf(43,43) = 0;
CUf(44,44) = 0;
CUf(44,43) = 1;
CUf(43,44) = 1;
CUf(107,107) = 0;
CUf(108,108) = 0;
CUf(107,108) = 1;
CUf(108,107) = 1;

CUf2 = eye(1024);
CUf2(171,171) = 0;
CUf2(140,140) = 0;
CUf2(171,140) = 1;
CUf2(140,171) = 1;
CUf2(427,427) = 0;
CUf2(420,420) = 0;
CUf2(427,420) = 1;
CUf2(420,427) = 1;
CUf2(683,683) = 0;
CUf2(682,682) = 0;
CUf2(683,682) = 1;
CUf2(682,683) = 1;
CUf2(275,275) = 0;
CUf2(260,260) = 0;
CUf2(275,260) = 1;
CUf2(260,275) = 1;
CUf2(659,659) = 0;
CUf2(658,658) = 0;
CUf2(659,658) = 1;
CUf2(658,659) = 1;

Uf = eye(8);
Uf(3,3) = 0;
Uf(4,4) = 0;
Uf(3,4) = 1;
Uf(4,3) = 1;
Uf(7,7) = 0;
Uf(8,8) = 0;
Uf(7,8) = 1;
Uf(8,7) = 1;

Uf = eye(2^6);

Uf = swapindexinuf(Uf,'001000','001001');
Uf = swapindexinuf(Uf,'010000','010010');
Uf = swapindexinuf(Uf,'011000','011011');
Uf = swapindexinuf(Uf,'100000','100011');
Uf = swapindexinuf(Uf,'101000','101010');
Uf = swapindexinuf(Uf,'110000','110001');

       
%set a small t
t = 0.1;  
%construct e^{i-\rhot}   
cswap = [sigma(:,:,1) empty empty empty;
         empty sigma(:,:,1) empty empty;
         empty2 expm(-1i*swap*t)];

     
%set tunable unitary U1, U2 and U3. U1 for 1 qubit gate, U2 for 2 qubit gate if needed
U1 = zeros(2,2,3);
for k = 1:1:3
        for i = 1:1:4
           U1(:,:,k) = U1(:,:,k)+l((k-1)*4+i)*sigma(:,:,i);
        end
    U1(:,:,k) = expm(1i*U1(:,:,k));
end
% for k = 1:1:9
%    U1(:, :,k) = [cos(l(k)) sin(l(k));
%                  -sin(l(k)) cos(l(k))]; 
% end
%U3(:,:,1) = kron(kron(U1(:,:,1),U1(:,:,2)),U1(:,:,3));

%U3(:,:,2) = kron(kron(U1(:,:,4),U1(:,:,5)),U1(:,:,6));


% U2 = zeros(4,4,2);
% for k = 1:1:2
%     for j =1:1:4
%         for i = 1:1:4
%            U2(:,:,k) = U2(:,:,k)+l((k-1)*4*4+(j-1)*4+i)*kron(sigma(:,:,i),sigma(:,:,j));
%         end
%     end
%     U2(:,:,k) = expm(1i*U2(:,:,k));
% end



CNOT_31 = [1 0 0 0 0 0 0 0;
           0 0 0 0 0 1 0 0;
           0 0 1 0 0 0 0 0;
           0 0 0 0 0 0 0 1;
           0 0 0 0 1 0 0 0;
           0 1 0 0 0 0 0 0;
           0 0 0 0 0 0 1 0;
           0 0 0 1 0 0 0 0];
CNOT_13 = [1 0 0 0 0 0 0 0;
           0 1 0 0 0 0 0 0;
           0 0 1 0 0 0 0 0;
           0 0 0 1 0 0 0 0;
           0 0 0 0 0 1 0 0;
           0 0 0 0 1 0 0 0;
           0 0 0 0 0 0 0 1;
           0 0 0 0 0 0 1 0];

% Rx = [cos() -1i*sin();     
%       -1i*sin() cos()];   
% Ry = [cos() -sin();     
%       sin() cos()];  
% Rz = [exp(-1i*()) 0;      %R_z
%       0 exp(1i*())];
%   
% onebitgate(2,2,2) = Rx;
% onebitgate(2,2,1) = I;
% onebitgate(2,2,3) = Ry;
% onebitgate(2,2,4) = Rz;
% 
% 
% twobitgate(4,4,1) = CNOT_12;
% twobitgate(4,4,2) = CNOT_21;
% 
% threebitgate(8,8,1) = CNOT_13;
% threebitgate(8,8,2) = CNOT_31;


    
% U3 = zeros(8,8,1);
% for k = 1:1:1
%     for n = 1:1:4
%         for j = 1:1:4
%             for i =1:1:4
%                 U3(:,:,k) = U3(:,:,k)+l((1-1)*4*4*4+(n-1)*4*4+(j-1)*4+i)*kron(sigma(:,:,n),kron(sigma(:,:,i),sigma(:,:,j)));
%             end
%         end
%     end
%      U3(:,:,k) = expm(1i*U3(:,:,k));
% end



% %transform classical data bit input into qubit
% input = 1/(sqrt(8))*(kron(kron(kron(ket0,ket0),ket0),kron(ket(:,data(1)),ket(:,data(2))))+kron(kron(kron(ket0,ket0),ket1),kron(ket(:,data(3)),ket(:,data(4))))+kron(kron(kron(ket0,ket1),ket0),kron(ket(:,data(5)),ket(:,data(6))))+...
%     kron(kron(kron(ket0,ket1),ket1),kron(ket(:,data(7)),ket(:,data(8))))+kron(kron(kron(ket1,ket0),ket0),kron(ket(:,data(9)),ket(:,data(10))))+kron(kron(kron(ket1,ket0),ket1),kron(ket(:,data(11)),ket(:,data(12))))+...
%     kron(kron(kron(ket1,ket1),ket0),kron(ket(:,data(13)),ket(:,data(14))))+kron(kron(kron(ket1,ket1),ket1),kron(ket(:,data(15)),ket(:,data(16)))));
% 
% 
% 
% %%
% % different training circuit
% % different in form of control parameters
% 
% 
% 
% % state1 = kron(kron(U1(:,:,1),I2),I2)*input*(kron(kron(U1(:,:,1),I2),I2)*input)';
% % state2 = kron(kron(swap*CR2^(1/(1+exp(l(13))))*swap,I),I2)*state1*(kron(kron(swap*CR2^(1/(1+exp(l(13))))*swap,I),I2))';
% % state3 = kron(swap13*CR3^(1/(1+exp(l(14))))*swap13,I2)*state2*(kron(swap13*CR3^(1/(1+exp(l(14))))*swap13,I2))';
% % state4 = kron(kron(kron(I,U1(:,:,2)),I),I2)*state3*(kron(kron(kron(I,U1(:,:,2)),I),I2))';
% % state5 = kron(kron(I,swap*CR2^(1/(1+exp(l(15))))*swap),I2)*state4*(kron(kron(I,swap*CR2^(1/(1+exp(l(15))))*swap),I2))';
% % state6 = kron(kron(I2,U1(:,:,3)),I2)*state5*(kron(kron(I2,U1(:,:,3)),I2))';
% % state7 = kron(swap13^(1/(1+exp(l(16)))),I2)*state6*kron(swap13^(1/(1+exp(l(16)))),I2)';
% 
% 
% 
% % oringnal for submit
% % state1 = kron(kron(U1(:,:,1),I2),I2)*input*(kron(kron(U1(:,:,1),I2),I2)*input)';
% % state2 = kron(kron(swap*CR2^(sin(l(13)*pi/2)^2)*swap,I),I2)*state1*(kron(kron(swap*CR2^(sin(l(13)*pi/2)^2)*swap,I),I2))';
% % state3 = kron(swap13*CR3^(sin(l(14)*pi/2)^2)*swap13,I2)*state2*(kron(swap13*CR3^(sin(l(14)*pi/2)^2)*swap13,I2))';
% % state4 = kron(kron(kron(I,U1(:,:,2)),I),I2)*state3*(kron(kron(kron(I,U1(:,:,2)),I),I2))';
% % state5 = kron(kron(I,swap*CR2^(sin(l(15)*pi/2)^2)*swap),I2)*state4*(kron(kron(I,swap*CR2^(sin(l(15)*pi/2)^2)*swap),I2))';
% % state6 = kron(kron(I2,U1(:,:,3)),I2)*state5*(kron(kron(I2,U1(:,:,3)),I2))';
% % %state7 = kron(swap13^(sin(l(16)*pi/2)^2),I2)*state6*kron(swap13^(sin(l(16)*pi/2)^2),I2)';
% % state7 = kron(kron(swap^(sin(l(13)*pi/2)^2),I),I2)*state6*kron(kron(swap^(sin(l(13)*pi/2)^2),I),I2)';
% % state8 = kron(swap13^(sin(l(14)*pi/2)^2),I2)*state7*kron(swap13^(sin(l(14)*pi/2)^2),I2)';
% % state9 = kron(kron(I,swap^(sin(l(15)*pi/2)^2)),I2)*state8*kron(kron(I,swap^(sin(l(15)*pi/2)^2)),I2)';
% 
% 
% %new for test
% state1 = kron(kron(H,I2),I2)*input*(kron(kron(H,I2),I2)*input)';
% state2 = kron(kron(swap*CR2^(sin(l(13)*pi/2)^2)*swap,I),I2)*state1*(kron(kron(swap*CR2^(sin(l(13)*pi/2)^2)*swap,I),I2))';
% state3 = kron(swap13*CR3^(sin(l(14)*pi/2)^2)*swap13,I2)*state2*(kron(swap13*CR3^(sin(l(14)*pi/2)^2)*swap13,I2))';
% state4 = kron(kron(kron(I,H),I),I2)*state3*(kron(kron(kron(I,H),I),I2))';
% state5 = kron(kron(I,swap*CR2^(sin(l(15)*pi/2)^2)*swap),I2)*state4*(kron(kron(I,swap*CR2^(sin(l(15)*pi/2)^2)*swap),I2))';
% state6 = kron(kron(I2,H),I2)*state5*(kron(kron(I2,H),I2))';
% %state7 = kron(swap13^(sin(l(16)*pi/2)^2),I2)*state6*kron(swap13^(sin(l(16)*pi/2)^2),I2)';
% state7 = kron(kron(swap,I),I2)*state6*kron(kron(swap,I),I2)';
% state8 = kron(swap13,I2)*state7*kron(swap13,I2)';
% state9 = kron(kron(I,swap),I2)*state8*kron(kron(I,swap),I2)';
% 
% 
% 
% 
% 
% 
% % state1 = kron(kron(U1(:,:,1),I2),I2)*input*(kron(kron(U1(:,:,1),I2),I2)*input)';
% % state2 = kron(kron(swap*CR2^(o(1))*swap,I),I2)*state1*(kron(kron(swap*CR2^(o(1))*swap,I),I2))';
% % state3 = kron(swap13*CR3^o(2)*swap13,I2)*state2*(kron(swap13*CR3^o(2)*swap13,I2))';
% % state4 = kron(kron(kron(I,U1(:,:,2)),I),I2)*state3*(kron(kron(kron(I,U1(:,:,2)),I),I2))';
% % state5 = kron(kron(I,swap*CR2^(o(3))*swap),I2)*state4*(kron(kron(I,swap*CR2^(o(3))*swap),I2))';
% % state6 = kron(kron(I2,U1(:,:,3)),I2)*state5*(kron(kron(I2,U1(:,:,3)),I2))';
% % state7 = kron(swap13,I2)*state6*kron(swap13,I2)';
% 
% % state1 = kron(kron(I2,U1(:,:,1)),I2)*input*(kron(kron(I2,U1(:,:,1)),I2)*input)';
% % state2 = kron(kron(I, CR2^(o(1)) ),I2)*state1*(kron(kron(I,CR2^(o(1))),I2))';
% % state3 = kron( CR3^o(2) ,I2)*state2*(kron( CR3^o(2),I2))';
% % state4 = kron(kron(kron(I,U1(:,:,2)),I),I2)*state3*(kron(kron(kron(I,U1(:,:,2)),I),I2))';
% % state5 = kron(kron( CR2^(o(3)) ,I),I2)*state4*(kron(kron(CR2^(o(3)) ,I),I2))';
% % state6 = kron(kron(U1(:,:,3),I2),I2)*state5*(kron(kron(U1(:,:,3),I2),I2))';
% % state7 = kron(swap13^(o(4)),I2)*state6*kron(swap13^(o(4)),I2)';
% 
% 
% output_true = state9;
%%
input = rho0;
for i = 1:1:5
input = kron(input,rho0);
end




%% parameterized quantum circuit



hstate{1} = input;
step = 1;
 

Uhprocessindex{step,:} = {H,H,H,I3};
Uhprocessindex{step+1,:} = {Uf};
Uhprocessindex{step+2,:} = {H,I2,I3};
Uhprocessindex{step+3,:} = {CR2^(sin(l(1))^2),I,I3};
Uhprocessindex{step+4,:} = {CR3^(sin(l(2))^2),I3};


Uhprocessindex{step+5,:} = {I,H,I,I3};
Uhprocessindex{step+6,:} = {I,CR2^(sin(l(3))^2),I3};

Uhprocessindex{step+7,:} = {I2,H,I3};

Uhprocessindex{step+8,:} = {swap13,I3};
 
 

[Uhprocessindex_x,Uhprocessindex_y] = size(Uhprocessindex);

for i = 1:1:Uhprocessindex_x
    hstate{i+1} = quantumprocess(Uhprocessindex{i,:},hstate{i});    
end

outputofuf = hstate{Uhprocessindex_x+1};
output_true = outputofuf;












