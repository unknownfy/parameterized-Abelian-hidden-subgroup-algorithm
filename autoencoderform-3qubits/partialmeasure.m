function  poststate = partialmeasure(state,fx)
%   This function computes output state after partial measure
%   This function has 2 required arguments:
%      state:input state
%      fx: measurebit, like:\ket{0} or \ket{1}

ket = [1 0;
       0 1];
I = eye(2);
I3 = eye(8);   
for i = 1:1:4
    index = dec2bin(i-1,2)-'0';
    ket2(:,i) =  kron(ket(1,:),kron(ket(index(1)+1,:),ket(index(2)+1,:)));
    M(:,:,i) = kron(I3,ket2(:,i)*ket2(:,i)');
    p(i) = trace(state*M(:,:,i));
    measurestate(:,:,i) = (M(:,:,i)*state*M(:,:,i))/(trace(state*M(:,:,i))+10^(-8));
    partialstate(:,:,i) = PartialTrace(measurestate(:,:,i),2,[8,8]);
end
poststate = partialstate(:,:,fx);
%% below part is retained for sample
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