function output = swap(n)
if n == 2
    swapn = [1 0 0 0;
        0 0 1 0;
        0 1 0 0;
        0 0 0 1];
else
    swapn = eye(2^n);
    for i = 0:1:2^(n-2)-1
        number = dec2bin(i,n-2);
        swapnumber1 = ['0' number '1'];
        swapnumber2 = ['1' number '0'];
        swapn = swapindexinuf(swapn,swapnumber1,swapnumber2);
    end
end
output = swapn;

end