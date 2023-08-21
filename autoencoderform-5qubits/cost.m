 function costvalue = cost(l,s)
%   This function computes the sum of linear congruence set 
%   This function has 2 required arguments:
%      l: vector of all parameter
%      s: parameter of group structure
%   costvalue = cost(l,s,data) gives the distance between reasonable secret
%   bit string and real secret bit string,


%%%%compute two kind of outputs from function circuit%%%%%%
for i = 1:1:1 %you can change value of i for multiple input
output_true(:,:,i) = qcircuit(l);
end


%%%%%caculate probability for all outputbitstring%%%%%%
for j = 1:1:1
    for i =1:1:1
        poststate = partialmeasure(output_true(:,:,j),i); %measure a part of bit state
        bitprob(:,i,j) = sample(poststate); % sample and estimate probability from state,to be simle we just take the probability here
    end
end

%%%%%solve the linear congruences to claculate s%%%%%%%%
for i =1:1:1
    linearoutput = ccircuit(bitprob(:,:,i),l,s); 
end


 

%%%%%%%% set cost %%%%%%%%

%the one used in encoder, when cost vlaue reach to 0, it means we find the reasonable secret bit string
%we add the threshold to aviod s=00000 and lead s to integer
costvalue = real(sum((sum(sum(linearoutput)))))+1./(1+exp(100*s(1)-10)+exp(100*s(2)-10)+exp(100*s(3)-10)+exp(100*s(4)-10)+exp(100*s(5)-10))+sin(s(1)*pi)^2+sin(s(2)*pi)^2+sin(s(3)*pi)^2+sin(s(4)*pi)^2+sin(s(5)*pi)^2+...
    sin(l(1)*2)^2+sin(l(2)*2)^2+sin(l(3)*2)^2+sin(l(4)*2)^2+sin(l(5)*2)^2+sin(l(6)*2)^2+sin(l(7)*2)^2+sin(l(8)*2)^2+sin(l(9)*2)^2+sin(l(10)*2)^2;
end