function output  = ccircuit(bitprob,l,s)
%   This function computes information from quantum circuit and output cost
%   of linear congruences
%   This function has 3 required arguments:
%      bitprob: probability distribution of measured bit
%      s: parameters from quantum circuit that control the group structure
%      l: all parameters 
%   output  = ccircuit(bitprob,s,l) gives the secret bit string from given
%   data string, to do that we solve the linear congruences in training
%   way,
rsuper = l(1:6);


s1 = probdis(s(1));
s2 = probdis(s(2));
s3 = probdis(s(3));
s4 = probdis(s(4));

n = 4;

sdistribution = kron(kron(s1,s2),kron(s3,s4));                                                                                                    

for i = 1:1:6
rinteger(i) = round(sin(rsuper(i))^2);
end
%%%%%%%set all possible group structure in advance%%%%%
rdec = bin2dec(num2str(rinteger));
initialpoint = 1;
breakpoint{initialpoint,1} = bin2dec('000000');%2 2 2 2 
breakpoint{initialpoint,2} = [2 2 2 2];
breakpoint{initialpoint+1,1} = bin2dec('000001');% 2 2 4
breakpoint{initialpoint+1,2} =[2 2 4];
breakpoint{initialpoint+2,1} = bin2dec('000100');% 2 4 2 
breakpoint{initialpoint+2,2} = [2 4 2];
breakpoint{initialpoint+3,1} = bin2dec('000111');%2 8
breakpoint{initialpoint+3,2} = [2 8];
breakpoint{initialpoint+4,1} = bin2dec('100000');%4 2 2
breakpoint{initialpoint+4,2} = [4 2 2]; 
breakpoint{initialpoint+5,1} = bin2dec('111000');%8 2
breakpoint{initialpoint+5,2} = [8 2];
breakpoint{initialpoint+6,1} = bin2dec('111111');%16
breakpoint{initialpoint+6,2} = [16];

%%%%set breakpoint to distinguish which group structure it belongs to%%%%

[lengthofbreak,breakpoint_y] = size(breakpoint);
for i = 1:1:lengthofbreak-1
   midpiontofbreak(i) =  round((breakpoint{i,1}+breakpoint{i+1,1})/2);
end

midpointwithr = [midpiontofbreak rdec];
rposition =  find(sort(midpointwithr) == rdec);
groupstructure = breakpoint{rposition,2};
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

lengthofsdistribution = length(sdistribution);
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
    s_dec(j,1) =  bin2dec(binofsdistribution(1:measurebitnumber(1)));
    setpointofs = measurebitnumber(1);
    for i = 1:1:lengthofgroup-1
        s_dec(j,i+1) =  bin2dec(binofsdistribution(j,setpointofs:setpointofs+measurebitnumber(i+1)));
        setpointofs = setpointofs + measurebitnumber(i+1);
    end
    end
end

y_dec = s_dec;


alpha = d./groupstructure;
output = 0;
for i = 1:1:2^n
    output = output+ sum(mod(y_dec.*alpha*s_dec(i,:)',d).*bitprob*sdistribution(i));
end





end