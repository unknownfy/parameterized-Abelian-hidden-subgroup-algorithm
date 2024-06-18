function costvalue = cost(digitstring,l,s,n)
%   This function computes the sum of linear congruence set 
%   This function has 2 required arguments:
%      l: vector of all parameter
%      s: parameter of group structure
%   costvalue = cost(l,s,data) gives the distance between reasonable secret
%   bit string and real secret bit string,




%tic
%%%%compute two kind of outputs from function circuit%%%%%%
for i = 1:1:1 %you can change value of i for multiple input
output_true(:,:,i) = qcircuit(digitstring,l,n);
end
%qcircuittime = toc


%tic
%%%%%caculate probability for all outputbitstring%%%%%%
for j = 1:1:1
    for i =1:1:1
        %poststate = partialmeasure(output_true(:,:,j),i,n); %measure a part of bit state
        bitprob(:,i,j) = sample(output_true(:,:,j),n); % sample and estimate probability from state,to be simle we just take the probability here
    end
end
%sampletime = toc

%tic
%%%%%solve the linear congruences to claculate s%%%%%%%%
for i =1:1:1
    linearoutput = ccircuit(bitprob(:,:,i),l,s,n); 
end
%ccircuit = toc

 
%tic
%%%%%%%% set cost %%%%%%%%

%the one used in encoder, when cost vlaue reach to 0, it means we find the reasonable secret bit string
%we add the threshold to aviod s=00000 and   lead s to integer
costvalue = real(sum((sum(sum(linearoutput)))));
underline = 0;
for i = 1:1:n
    underline = underline + exp(100*s(i)-10);
end
costvalue  = costvalue+1./(1+underline);
for i = 1:1:n 
    costvalue = costvalue + sin(s(i)*pi)^2;
end
for i = 1:1:(n-1)*n/2
    costvalue = costvalue + sin(l(i)*pi)^2;
end
%costvaluetime =toc
