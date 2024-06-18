
ket0 = [1;0];
ket1 = [0;1];
ket00 = kron(ket0,ket0);
ket01 = kron(ket0,ket1);
ket10 = kron(ket1,ket0);
ket11 = kron(ket1,ket1); 
C = [1 0;0 1];
D = [0 1;-1 0];
gamma = pi/2;
J = exp(-1j*gamma*kron(D,D)/2);
PA = zeros(314,157);
for theta =  0:0.01:pi
    for psi =  0:0.01:pi/2
UA = [exp(1j*psi)*cos(theta/2) sin(theta/2); -sin(theta/2) exp(-1j*psi)*cos(theta/2)];
UB = D;
phif = J'*(kron(UA,UB))*J*ket00;
%PA(fix(theta*100+1),fix(psi*100+1)) = 3*(ket00'*phif)^2+0*(ket01'*phif)^2+5*(ket10'*phif)^2+1*(ket11'*phif)^2;
PA(fix(theta*100+1),fix(psi*100+1)) = 0*(ket00'*phif)^2+0*(ket01'*phif)^2+0*(ket10'*phif)^2+1*(ket11'*phif)^2;
    end
end
theta = [0:0.01:pi];
psi = [0:0.01:pi/2];
[x,y]=meshgrid(theta,psi);
plot3(x,y,PA)