function  poststate = partialmeasure(state,fx)
%measure a part of bit state
ket = [1 0;
       0 1];
n = 5;
I = eye(2^n);

for i = 1:1:2^n
    index = dec2bin(i-1,n)-'0';
    ket2 = ket(index(1)+1,:);
    for j = 1:1:n-1
    ket2  =  kron(ket2 ,ket(index(j+1)+1,:));
    end
    M(:,:,i) = kron(I,ket2'*ket2);
    p(i) = trace(state*M(:,:,i));
    measurestate(:,:,i) = (M(:,:,i)*state*M(:,:,i))/(trace(state*M(:,:,i))+10^(-8));
    partialstate(:,:,i) = PartialTrace(measurestate(:,:,i),2,[2^n,2^n]);
end
poststate = partialstate(:,:,fx);

% t  = rand(1);
%     function  m = samplefunction(t)
% % samplefunction =  0.*(t<0)+ p(1).*(t<p(1)&t>=0)+p(2).*(t>=p(1)&t<p(1)+p(2))+p(3).*(t>=p(1)+p(2)&t<p(1)+p(2)+p(3))+p(4).*(t>=p(1)+p(2)+p(3)&t<p(1)+p(2)+p(3)+p(4))+...
% %                   p(5).*(t>=p(1)+p(2)+p(3)+p(4)&t<p(1)+p(2)+p(3)+p(4)+p(5))+p(6).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6))+p(7).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7))+...
% %                   p(8).*(t>=p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)&t<p(1)+p(2)+p(3)+p(4)+p(5)+p(6)+p(7)+p(8))+1.*(t>=1);
%  m =  0.*(t<0)+ p(1).*(t<p(1)&t>=0)+p(2).*(t>=p(1)&t<p(1)+p(2))+p(3).*(t>=p(1)+p(2)&t<p(1)+p(2)+p(3))+p(4).*(t>=p(1)+p(2)+p(3)&t<p(1)+p(2)+p(3)+p(4))+1.*(t>=1);
%     end
% pick = samplefunction(t);
% [m,n] = find(p == pick);
% poststate = partialstate(:,:,n);
end