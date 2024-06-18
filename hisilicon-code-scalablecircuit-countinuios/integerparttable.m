function [ table ] = integerparttable(nfinal )

intpart(1,nfinal,1,1); %clears table
for n = 2:nfinal
    intpart(uint32(n),uint32(n));
end
table = intpart(1,nfinal,2); %gets table
for n = 1:nfinal
 table(n+1,n+1:nfinal+1) =  table(n+1,n+1);  
end
end
function p = intpart(k,n,gettable,cleartable) %#ok<INUSD>
persistent table
if nargin == 4
    table = uint32(zeros(n+1)); %clears
%     table(1,:) = uint32(ones(1,1+n)); %n=0
%     table(2,2:n+1) = uint32(ones(1,n)); %n=1 k>1
%     table(:,2) = uint32(ones(n+1,1)); %k=0
    table(1,:) = uint32(1); %n=0
    table(2,2:n+1) = uint32(1); %n=1 k>1
    table(:,2) = uint32(1); %k=0
    p = 0; return
end
if nargin == 3
    p = table; return
end
k = uint32(k);
n = uint32(n);
if n < 0
    p = uint32(0); return
end
if k < 0
    p = uint32(0); return
end
if table(n+1,k+1) ~= 0
    p = table(n+1,k+1);  return
end
if n==0
    p = uint32(0); return
end
    table(n+1,k+1) = intpart(k,n-k) + intpart(k-1,n);
    p = table(n+1,k+1);
    for lp = n+2:length(table)
    table(n+1,lp) = table(n+1,n+1);
    end
end
