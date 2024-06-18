function output  = bin2group(s,groupstrcuture)


grouplength = length(groupstrcuture);


for i = 1:1:grouplength
        sgroup(i) = 0;
    for j =1:1:log2(groupstrcuture(i))
        sgroup(i) = sgroup(i)+s(j)*2^(j-1);

    end
end

output = sgroup;


end
