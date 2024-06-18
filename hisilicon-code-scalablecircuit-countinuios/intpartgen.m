function intlist = intpartgen(N,maxnum,intlist)
table = integerparttable(N);
 %number of partitions for each number up to N
if nargin == 1
    maxnum = N;
elseif isempty(maxnum)
    maxnum = N;
elseif maxnum>N
    maxnum=N;
end
table = table(:,maxnum+1);
if nargin < 3
intlist{1} = uint8(0); %partitions of 0
intlist{2} = uint8(1); %partitions of 1
intlist{3} = uint8([2,0;1,1]); %partitions of 2
kstart = 3;
else
    kstart = length(intlist);
end
    
%in general   p{n} = [n , p{n-1}+1,p{n-2}+2 exc 1,p{n-3}+3 exc 1&2, 
                %..., p{ceil(n/2)}+floor(n/2),exc 1&2&...&floor(n/2)-1]
                
for k = kstart:N
%k  %uncomment to track output
    tempmat = uint8(zeros(table(k+1),min(k,maxnum))); count = 1;
    tempmat(1,1)=k;
    
    for j = 1:floor(k/2)
       temp = intlist{k-j+1};
       lg = temp>j-1 | temp == 0; %all non zero elements of temp 
       lg2 = all(lg==1,2);
       lg2 = lg2 & (any(temp==0,2)|size(temp,2)<maxnum); 
       %must have at least one space for another
       temp = temp(lg2,1:min(size(temp,2),maxnum-1));    
       %[temp,ones(size(temp,1),1)]
        tempmat(count+1:count+size(temp,1),1:size(temp,2)+1) = [temp,j*ones(size(temp,1),1)];
        count = count + size(temp,1);
    end
    if ~isequal(count,table(k+1))
        % 'fail'
        % k
    end
    tempmat = sort(tempmat,2,'descend');
    intlist{k+1} = tempmat;
end
if nargout == 0 %save if not outputting
    
    save(strcat('intpartlist_N=',num2str(N),'_maxnum=',num2str(maxnum),'.mat'),'intlist')
    
end