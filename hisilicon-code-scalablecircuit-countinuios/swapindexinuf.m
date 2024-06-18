function uf = swapindexinuf(uf,index1,index2)
index1dec = bin2dec(index1)+1;
index2dec = bin2dec(index2)+1;
uf(index1dec,index1dec) = 0;
uf(index2dec,index2dec) = 0;
uf(index1dec,index2dec) = 1;
uf(index2dec,index1dec) = 1;
end