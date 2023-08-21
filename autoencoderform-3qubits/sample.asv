function [bitstring,p] = sample(state)
% sample or estimate probability from state for certain output
ket = [1 0;
       0 1];
I3 = eye(8);   
for i = 1:1:8
    index = dec2bin(i-1,3)-'0';
    ket3(:,i) =  kron(kron(ket(index(1)+1,:),ket(index(2)+1,:)),ket(index(3)+1,:));
    p(i) = ket3(:,i)'*state*ket3(:,i);
end


%% below part is retained for sample for measurement on 3 qubits case
t  = rand(1);
    function m = samplefunction(t)
             m =  0.*(t<0)+ p(1).*(t<p(1)&t>=0)+p(2).*(t>=p(1)&t<p(1)+p(2))+p(3).*(t>=p(1)+p(2)&t<p(1)+p(2)+p(3))+p(4).*(t>=p(1)+p(2)+p(3)&t<p(1)+p(2)+p(3)+p(4))+...
                  p(5).*(t>=p(1)+p(2)+p(3)+p(4)&t<p(1)+p(2)+p(3)+p(4)+p(5))+p(6).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6))+p(7).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7))+...
                  p(8).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)+p(8))+1.*(t>=1);
    end
pick = samplefunction(t);
[m,n] = find(p == pick);
 bitstring = dec2bin(n(1)-1,3)-'0';

end