function outputstate = decoder(l,s,data)
%genarate time series according l and s
%we have a systematical way to do this but direct give it for simple

rsuper(1) = l(13);
rsuper(2) = l(14);
rsuper(3) = l(15);


s1 = probdis(s(1));
s2 = probdis(s(2));
s3 = probdis(s(3));

sdistribution = kron(kron(s1,s2),s3);

rinteger(1) = round(sin(rsuper(1)*pi/2)^2);
rinteger(2) = round(sin(rsuper(2)*pi/2)^2);
rinteger(3) = round(sin(rsuper(3)*pi/2)^2);

if rinteger(1)==0 && rinteger(2)==1 && rinteger(3)==1
    rinteger = [0 1 0];
end

if rinteger(1)==1 && rinteger(2)==0 && rinteger(3)==1
    rinteger = [1 0 0];
end

if rinteger(1)==1 && rinteger(2)==1 && rinteger(3)==0
    rinteger = [1 1 1];
end
    
bitvalue = 0;
sflag = zeros(7,8);
if sum(rinteger) == 3
%     for ssample = 1:1:7
%         bitvalue = 0;
%         for i = 1:1:8
%             if sflag(ssample,i) == 1
%                 continue
%             end
%             f(ssample,i) = bitvalue;
%             f(ssample,i+ssample) = bitvalue;
%             sflag(ssample,i+ssample) = 1;
%             bitvalue = bitvalue + 1;
%         end
%     end
f = [0 0 0 0 0 0 0 0;
     0 1 0 1 0 1 0 1;
     0 1 2 0 1 2 0 1;
     0 1 2 3 0 1 2 3;
     0 1 2 3 4 0 1 2;
     0 1 2 3 4 5 0 1;
     0 1 2 3 4 5 6 0;];
end

if sum(rinteger) == 1
%     for ssample = 1:1:7
%         bitvalue = 0;
%         for i = 1:1:4
%             if sflag(ssample,i) == 1
%                 continue
%             end
%             f2bit(ssample,i) = bitvalue;
%             f2bit(ssample,bitxor(i-1,ssample)+1) = bitvalue;
%             sflag(ssample,bitxor(i-1,ssample)+1) = 1;
%             bitvalue = bitvalue + 1;
%         end
%         for i = 1:1:2
%             if sflag(ssample,i) == 1
%                 continue
%             end
%             f1bit(ssample,i) = bitvalue;
%             f1bit(ssample,bitxor(i-1,ssample)+1) = bitvalue;
%             sflag(ssample,bitxor(i-1,ssample)+1) = 1;
%             bitvalue = bitvalue + 1;
%         end
if rinteger(1) == 1
    f = [0 0 1 1 2 2 3 3;
        0 1 0 1 0 1 0 1;
        0 1 1 0 0 1 1 0;
        0 1 2 3 0 1 2 3;
        0 1 2 3 1 0 3 2;
        0 1 0 1 0 1 0 1;
        0 1 0 1 0 1 1 0;];
end
if rinteger(2) == 1
    f = [0 0 1 1 0 0 1 1;
        0 1 0 1 2 3 2 3;
        0 1 1 0 0 1 1 0;
        0 1 2 3 0 1 2 3;
        0 0 1 1 0 0 1 1;
        0 1 2 3 2 3 0 1;
        0 1 1 0 0 1 1 0;];
end
if rinteger(3) == 1
    f = [0 0 0 0 1 1 1 1;
        0 1 0 1 2 3 2 3;
        0 0 0 0 1 1 1 1;
        0 1 2 3 0 1 2 3;
        0 1 0 1 1 0 1 0;
        0 1 2 3 2 3 0 1;
        0 1 0 1 1 0 1 0;];
end

end
    
if sum(rinteger) == 0
    for ssample = 1:1:7
        bitvalue = 0;
        for i = 1:1:8
            if sflag(ssample,i) == 1
                continue
            end
            f(ssample,i) = bitvalue;
            f(ssample,bitxor(i-1,ssample)+1) = bitvalue;
            sflag(ssample,bitxor(i-1,ssample)+1) = 1;
            bitvalue = bitvalue + 1;
        end
    end
end
outputstatedistribution = f(:,1:8);
outputstatedistribution = [0 0 0 0 0 0 0 0;outputstatedistribution];
outputstate = zeros(1,8);

for i=1:1:8
    outputstate =  outputstate + (outputstatedistribution(i,:)-data).^2*sdistribution(i);
end


%% for general case
% for i = 1:1:3
%     if rsuper(i)>0.8
%         rsuper(i) = 1;
%     else rsuper(i) = 0;
%     end
% end
% 
% if rsuper(1) == 1 && rsuper(2) == 1 && rsuper(3) == 1
%     base = 8;
% else if rsuper(1) == 1 || rsuper(2) == 1 || rsuper(2) == 1
%         if sum(rsuper) == 2
%             base = 2;
%         else
%             base = 4;
%         end
%     else if rsuper(1) == 0 && rsuper(2) == 0 && rsuper(3) == 0
%             base = 2;
%         end
%     end
% end
% 
% sbase = s; %%transfrom s to corresponding base
% 
% bitvalue = 0
% if base == 8
%     for i = 1:1:8
%         if flag(i) == 1
%             i = i+1;
%             continue
%         end
%         f(i) = bitvalue;
%         f(i+s) = bitvalue;
%         flag(i+s) = 1;
%         bitvalue = bitvalue + 1;
%     end
% end
% 
% if base == 4
%     if rsuper(1) ==1
%     for  i = 1:1:8
%         if flag(i) == 1
%             i = i+1;
%             continue
%         end
%         f(i) = bitvalue;
%         f(i+)
    
    




end