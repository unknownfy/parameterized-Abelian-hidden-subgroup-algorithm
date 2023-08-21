function costvalue = cost(l,s,data)
%   This function computes the sum of linear congruence set w
%   This function has 3 required arguments:
%      l: vector of all parameter
%      s: parameter of group structure
%      data: classical data string
%   costvalue = cost(l,s,data) gives the distance between reasonable secret
%   bit string and real secret bit string,


 
 
[datax,datay] = size(data);
dataorigin = data;
for i =1:1:datax
    datainbianry(i,:) = reshape(dec2bin(data(i,:),2) - '0',1,16)+1;
end
%Pauli matrices
sigma(:,:,1) = eye(2);
sigma(:,:,2) = [0 1;1 0];
sigma(:,:,3) = [0 -1i;1i 0];
sigma(:,:,4) = [1 0;0 -1];

%%%%compute two kind of outputs from function circuit%%%%%%
for i = 1:1:1 %you can change value of i for multiple input
output_true(:,:,i) = qcircuit(l,datainbianry(i,:));
end


%%%%%caculate probability for all outputbitstring%%%%%%
for j = 1:1:1
    for i =1:1:4
        poststate = partialmeasure(output_true(:,:,j),i); %measure a part of bit state
        [bitstring(:,:,i),bitprob(:,i,j)] = sample(poststate); % sample and estimate probability from state,to be simle we just take the probability here
    end
end
 
%%%%%%%%%%solve the linear congruences to claculate s%%%%%%%%
for i =1:1:1
    linearoutput = ccircuit(bitprob(:,:,i),s,l); 
end

%%%%%%%%%%% set cost %%%%%%%%

%the one used in encoder, when cost vlaue reach to 0, it means we find the reasonable secret bit string
%we add the threshold to aviod s=000
costvalue = real(sum((sum(sum(linearoutput)))))+1./(1+exp(100*s(1)-10)+exp(100*s(2)-10)+exp(100*s(3)-10));
end