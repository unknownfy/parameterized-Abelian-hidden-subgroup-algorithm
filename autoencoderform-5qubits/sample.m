function p = sample(state)
% sample and estimate probability from state 
ket = [1 0;
       0 1];
n = 5;
I3 = eye(2^n);   
for i = 1:1:2^n
    index = dec2bin(i-1,n)-'0';
    ket3  = ket(index(1)+1,:);
    for j = 1:1:n-1
    ket3  =  kron(ket3,ket(index(j+1)+1,:));
    end
    p(i) =  ket3*state* ket3';
end



% t  = rand(1);
%     function m = samplefunction(t)
%              m =  0.*(t<0)+ p(1).*(t<p(1)&t>=0)+p(2).*(t>=p(1)&t<p(1)+p(2))+p(3).*(t>=p(1)+p(2)&t<p(1)+p(2)+p(3))+p(4).*(t>=p(1)+p(2)+p(3)&t<p(1)+p(2)+p(3)+p(4))+...
%                   p(5).*(t>=p(1)+p(2)+p(3)+p(4)&t<p(1)+p(2)+p(3)+p(4)+p(5))+p(6).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6))+p(7).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7))+...
%                   p(8).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)+p(8))+1.*(t>=1);
%     end
% pick = samplefunction(t);
% [m,n] = find(p == pick);
%bitstring = dec2bin(n(1)-1,n)-'0';

end