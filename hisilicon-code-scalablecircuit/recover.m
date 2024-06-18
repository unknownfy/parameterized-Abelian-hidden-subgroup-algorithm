function output = recover(groupstrcture,compresseddata,possibles,lengthofstring)

lengthofcompresseddata = length(compresseddata);





fullmark = [];


nextstartpoint = 0;

achieveflag = 1;
compressnumbercounter = 1;
while achieveflag
    markofeachloop = [];
    recoverdata(nextstartpoint+1) = compresseddata(compressnumbercounter);
    nextindex = bin2dec(groupplus(groupstrcture,nextstartpoint,possibles));
    uniqflag =0;
    markofeachloop(1) = nextstartpoint+1;
    markofeachloop(2) = nextindex+1;
    eachloopcounter = 1;
    while uniqflag == 0
        recoverdata(nextindex+1) = recoverdata(nextstartpoint+1);
        nextindex = bin2dec(groupplus(groupstrcture,nextindex,possibles));
        markofeachloop(eachloopcounter+2) = nextindex+1;
        uniqflag = length(markofeachloop)-length(unique(markofeachloop));
        eachloopcounter = eachloopcounter + 1;
    end
    fullmark = sort([fullmark unique(markofeachloop)]);

    if length(fullmark) == lengthofstring
        achieveflag = 0;
    else
        for i = 1:1:length(fullmark)
            nextstartpointmark = fullmark(i)-i;
            if i == length(fullmark)
                nextstartpoint = length(fullmark);
            end
            if nextstartpointmark ~= 0
                nextstartpoint = i-1;
                break
            end
        end
    end
compressnumbercounter = compressnumbercounter+1;
end


output = recoverdata;

end