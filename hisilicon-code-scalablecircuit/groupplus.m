function output = groupplus(groupstructure,a,b)

groupstructure = log2(groupstructure);
abin = dec2bin(a,sum(groupstructure));
bbin = dec2bin(b,sum(groupstructure));
count = 1;
for i = 1:1:length(groupstructure)
    agroup{i} = abin(count:1:count+groupstructure(i)-1);
    bgroup{i} = bbin(count:1:count+groupstructure(i)-1);
    result{i} = dec2bin(bin2dec(agroup{i}) + bin2dec(bgroup{i}));
    if groupstructure(i) == 1
        resultem = result{i};
        lengthofresult = length(result{i});
        result{i} = resultem(lengthofresult);

    else
        resultem = result{i};
        lengthofresult = length(result{i});
        result{i} = resultem(lengthofresult-groupstructure(i)+1:1:lengthofresult);
    end
    count = count+groupstructure(i);
end

output = [];
for i = 1:1:length(result)
    output = [output result{i}];
end