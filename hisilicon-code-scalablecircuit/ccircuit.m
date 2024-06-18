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
global groupstructure
rsuper = l(1:n*(n-1)/2);

for i = 1:1:length(s)
sprob(i,:) = probdis(s(i));
% s2 = probdis(s(2));
% s3 = probdis(s(3));
% s4 = probdis(s(4));
% s5 = probdis(s(5));
end

sdistribution = sprob(1,:);
for i = 2:1:length(s)
sdistribution = kron(sdistribution,sprob(i,:));                                                                                                    
end


for i = 1:1:n*(n-1)/2
rinteger(i) = round(sin(rsuper(i))^2);
end
%%%%%%%set all possible group structure in advance%%%%%
rdec = bin2dec(num2str(rinteger));
%initialpoint = 1;
fullbreakpoint = intpartgen(n);
breakpointforn = fullbreakpoint{n+1};
%breakpoint(find(breakpoint==0))=[];
[breakpointforn_x,breakpointforn_y] = size(breakpointforn);
swapbreakpointfull = [];
for i = 1:1:breakpointforn_x
    swapbreakpoint{i} = unique(perms(breakpointforn(i,:)),'row');
    swapbreakpointfull = [swapbreakpointfull;swapbreakpoint{i}];
end
[swapbreakpointfull_x,swapbreakpointfull_y] = size(swapbreakpointfull);
groupstrmax = zeros(breakpointforn_x,(n-1)*n/2);
indexnumber = flip(1:1:n);
for m = 1:1:swapbreakpointfull_x
    for i = 1:1:swapbreakpointfull_y
        countnumber = 0;
        %countnumber = countnumber+breakpointforn(i);
        if swapbreakpointfull(m,i) == 0
            continue
        end
        if swapbreakpointfull(m,i) == 1
            countnumber = countnumber+1;
            groupstrmax(m,countnumber) = 0;
        else
            for j = 1:1:swapbreakpointfull(m,i)
                countnumber = countnumber+1;
                groupstrmax(m,countnumber) = 1;
            end
            for k = 1:1:indexnumber(i)-swapbreakpointfull(m,i)
                countnumber = countnumber+1;
                groupstrmax(m,countnumber) = 0;
            end
        end
    end
end
breakpointstr = num2str(groupstrmax);
breakpointdec = bin2dec(breakpointstr);
[breakpointdec,index,rest] = unique(breakpointdec,'rows','stable');
breakpointfornall = swapbreakpointfull(index,:);
[breakpointfornall_x,breakpointfornall_y] = size(breakpointfornall);

for i = 1:1:breakpointfornall_x
    breakpoint{i,1} = breakpointdec(i);
    breakpointfortem = breakpointfornall(i,:);
    breakpointfortem(find(breakpointfortem==0))=[];
    breakpoint{i,2} = 2.^breakpointfortem;
end

% breakpoint{initialpoint,1} = bin2dec('0000000000');%2 2 2 2 2
% breakpoint{initialpoint,2} = [2 2 2 2 2];
% breakpoint{initialpoint+1,1} = bin2dec('0000000001');%2 2 2 4
% breakpoint{initialpoint+1,2} =[2 2 2 4];
% breakpoint{initialpoint+2,1} = bin2dec('0000000100');%2 2 4 2 
% breakpoint{initialpoint+2,2} = [2 2 4 2];
% breakpoint{initialpoint+3,1} = bin2dec('0000000111');%2 2 8
% breakpoint{initialpoint+3,2} = [2 2 8];
% breakpoint{initialpoint+4,1} = bin2dec('0000100000');%2 4 2 2 
% breakpoint{initialpoint+4,2} = [2 4 2 2]; 
% breakpoint{initialpoint+5,1} = bin2dec('0000100001');%2 4 4
% breakpoint{initialpoint+5,2} = [2 4 4];
% breakpoint{initialpoint+6,1} = bin2dec('0000110100');%2 8 2
% breakpoint{initialpoint+6,2} =[2 8 2];
% breakpoint{initialpoint+7,1} = bin2dec('0000111111');%2 16
% breakpoint{initialpoint+7,2} = [2 16];
% breakpoint{initialpoint+8,1} = bin2dec('0000110100');%2 8 2
% breakpoint{initialpoint+8,2} = [2 8 2];
% breakpoint{initialpoint+9,1} = bin2dec('1000000000');%4 2 2 2
% breakpoint{initialpoint+9,2} = [4 2 2 2];
% breakpoint{initialpoint+10,1} = bin2dec('1000000001');%4 2 4
% breakpoint{initialpoint+10,2} = [4 2 4];
% breakpoint{initialpoint+11,1} = bin2dec('1000000100');%4 4 2
% breakpoint{initialpoint+11,2} = [4 4 2];
% breakpoint{initialpoint+12,1} = bin2dec('1000000111');%4 8 
% breakpoint{initialpoint+12,2} = [4 8]; 
% breakpoint{initialpoint+13,1} = bin2dec('1100100000');%8 2 2
% breakpoint{initialpoint+13,2} = [8 2 2];
% breakpoint{initialpoint+14,1} = bin2dec('1100100001');%8 4
% breakpoint{initialpoint+14,2} = [8 4];
% breakpoint{initialpoint+15,1} = bin2dec('1110110100');%16 2 
% breakpoint{initialpoint+15,2} = [16 2];
% breakpoint{initialpoint+16,1} = bin2dec('1111111111');%32
% breakpoint{initialpoint+16,2} = [32];





%%%%set breakpoint to distinguish which group structure it belongs to%%%%
[lengthofbreak,breakpoint_y] = size(breakpoint);
for i = 1:1:lengthofbreak
   %midpiontofbreak(i) =  round((breakpoint{i,1}+breakpoint{i+1,1})/2);
   breakpointvalue(i) =  breakpoint{i,1};
end
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
for i = 1:1:2^n
    output = output + sum(mod(y_dec.*alpha*s_dec(i,:)',d).*bitprob*sdistribution(i));
end






end