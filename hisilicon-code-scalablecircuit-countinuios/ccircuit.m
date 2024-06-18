function output  = ccircuit(bitprob,l,s,n)
%   This function computes information from quantum circuit and output cost
%   of linear congruences
%   This function has 3 required arguments:
%      bitprob: probability distribution of measured bit
%      s: parameters from quantum circuit that control the group structure
%      l: all parameters 
%   output  = ccircuit(bitprob,s,l) gives the secret bit string from given
%   data string, to do that we solve the linear congruences in training
%   way,
global groupstructure breakpointvalue  breakpoint
rsuper = l(1:n*(n-1)/2);

% for i = 1:1:length(s)
% sprob(i,:) = probdis(s(i));
% % s2 = probdis(s(2));
% % s3 = probdis(s(3));
% % s4 = probdis(s(4));
% % s5 = probdis(s(5));
% end

% sdistribution = sprob(1,:);
% for i = 2:1:length(s)
% sdistribution = kron(sdistribution,sprob(i,:));                                                                                                    
% end



for i = 1:1:n*(n-1)/2
rinteger(i) = round(sin(rsuper(i))^2);
end




%%%%%%%set all possible group structure in advance%%%%%
rdec = bin2dec(num2str(rinteger));
%initialpoint = 1;

%midpointwithr = [midpiontofbreak rdec];
%rposition =  find(sort(midpointwithr) == rdec);
[rvalue,rposition] = min(abs(breakpointvalue-rdec));
groupstructure = double(breakpoint{rposition,2});
lengthofgroup = length(groupstructure);
if lengthofgroup == 1
    d =  groupstructure;
else 
    d = 2;
    for i = 1:1:lengthofgroup 
        d =  lcm(groupstructure(i),d);
    end
end

measurebitnumber = log2(groupstructure);
sgroup = bin2group(s,groupstructure);

% if lengthofgroup == 1
%     y_dec = bin2dec(num2str(y(1:measurebitnumber(1))));
% else
%     y_dec(1) =  bin2dec(num2str(y(1:measurebitnumber(1))));
%     setpointofy = measurebitnumber(1);
%     for i = 1:1:lengthofgroup-1
%         y_dec(i+1) =  bin2dec(num2str(y(setpointofy:setpointofy+measurebitnumber(i+1))));
%         setpointofy = setpointofy + measurebitnumber(i+1);
%     end
% end

%%%%%caculate the sum of linear equation set%%%%%%%
lengthofsdistribution = 2^length(s);
positionofsdistribution = [1:1:lengthofsdistribution]-1;
positionofsdistribution = positionofsdistribution';
binofsdistribution = dec2bin(positionofsdistribution,n);
[ssize_x,ssize_y] = size(binofsdistribution);

if lengthofgroup == 1
    for j = 1:1:ssize_x
        s_dec(j,:) = bin2dec(binofsdistribution(j,1:measurebitnumber(1)));
    end
else
    for j = 1:1:ssize_x
        s_dec(j,1) =  bin2dec(binofsdistribution(j,1:measurebitnumber(1)));
        setpointofs = measurebitnumber(1);
        for i = 1:1:lengthofgroup-1
            s_dec(j,i+1) =  bin2dec(binofsdistribution(j,setpointofs+1:setpointofs+measurebitnumber(i+1)));
            setpointofs = setpointofs + measurebitnumber(i+1);
        end
    end
end

y_dec = s_dec;




alpha = d./groupstructure;
output = 0;
output = output + sum(mod(y_dec.*alpha*sgroup',d).*bitprob);







end