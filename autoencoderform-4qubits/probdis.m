function dis = probdis(omiga)
%% d = 3
% dis = [0.998.*(omiga<=-1)+(-0.997*omiga+0.001).*(omiga>-1&omiga<0)+0.001.*(omiga>=0); 
%      0.001.*(omiga<=-1)+(0.997*omiga+0.998).*(omiga>-1&omiga<=0)+(-0.997*omiga+0.998).*(omiga>0&omiga<=1)+0.001.*(omiga>1);
%      0.001.*(omiga<=0)+(0.997*omiga+0.001).*(omiga>0&omiga<=1)+0.998.*(omiga>1)];
 
 %% d =2
 dis = [0.9999.*(omiga<=0)+(-0.9998*omiga+0.9999).*(omiga>0&omiga<1)+0.0001.*(omiga>=1);
        0.0001.*(omiga<=0)+(0.9998*omiga+0.0001).*(omiga>0&omiga<1)+0.9999.*(omiga>=1)];

end