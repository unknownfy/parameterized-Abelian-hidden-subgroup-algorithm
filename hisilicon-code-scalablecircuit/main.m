%clear old data
clear global
clear
clc

%some standard quantum states and matrices we will use
ket0 = [1;0];
ket1 = [0;1];
rho0 = ket0*ket0';
rho1 = ket1*ket1';
sigma(:,:,1) = eye(2);     %Pauli matrix
sigma(:,:,2) = [0 1;1 0];
sigma(:,:,3) = [0 -1i;1i 0];
sigma(:,:,4) = [1 0;0 -1];
I = eye(2);  
I3 = eye(8);
M = eye(16);
NOT = [0,1;1,0];
n = 8;



%META-PARAMETERS FOR GRADIENT DESCENT
global delta %delta is size of parameter variation in probing cost landscape 
global  groupstructure
digitstring = [0:1:2^7-1  flip(0:1:2^7-1)];
digitstring2 = [1:1:2^7-1 0 0  flip(1:1:2^7-1)];
%digitstring = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15  15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0];
%digitstring = [0 1 2 3 4 5 6 7 7 6 5 4 3 2 1 0];
%digitstring = [0 1 0 1 0 1 0 1];
%digitstring = [0 1 2 3 3 2 1 0];
delta = 0.001;   %interval
eta = 0.01; % gradient descent jumpsize    
costline = 0.1;  %a cost value that is acceptable for you to save
lengthofstring = length(digitstring);


[compressedata,index] = unique(digitstring);


%initialize unitary parameters randomly upper-bounded by ub
ub = 1;      %upper bound of unitary parameters
for i = 1:1:(n-1)*n/2
    initialPi(i) = (((rand(1)))*ub);
    l(i) = initialPi(i);
end


for i =1:1:n
    s(i) = rand(1)*ub; 
end




l = [l s];
%OPTIONAL SECTION CONCERNING TERMINATING GRADIENT DESCENT
 
%flag = 0;   % the flag is 0 or 1, and 0 means gradient descent should be terminated.

%example flag defined by  differential of cost function
% for   j=1:1:2    % 

%    costvalue(j) = 0;
%    for r = 0.5:0.5:1
%        for theta = 0.1:1.5:pi
%            for phi = 0.1:3:2*pi              
%                lamda(1) = r*sin(theta)*cos(phi);
%                lamda(2) = r*sin(theta)*sin(phi);
%                lamda(3) = r*cos(theta);
%                rho = (sigma(:,:,1)+lamda(1)*sigma(:,:,2)+lamda(2)*sigma(:,:,3)+lamda(3)*sigma(:,:,4))/2;                
%                costvalue(j) = costvalue(j) + cost(l,rho);
%                lin = l;
%                for i = 1:1:4+4*4               
%                   l(i) = l(i)+delta; 
%                        lupdate(i) = -((cost(l,rho)-cost(lin,rho))/delta)*eta;
%                end
%                l = lin + lupdate;
%            end
%        end        
%    end
% end
%flag = flag||(abs(costvalue(2)-costvalue1(2))/delta>0.01);




%%
%%%%%%%% set number of CPU you want to use
%delete(gcp('nocreate'));
%parpool('local',4);      
%matlabpool local 12;

j = 3; %counts number of steps of gradient descent

%%%%%%%%%Gradient desent setting 
cosvaluesave = zeros(2^22,1);
m = 0;

v = 0;
beta1 = 0.9;
beta2 = 0.99;
eps = 1*10^(-8);
t = 0;
flag = 1;
flag2 = 1;

fullcount = 1;
fulldec = 0;
while flag2

while flag
    
%generate training data's Bloch sphere parameters
%    for r = 0.5:0.5:1
 %       for theta = 0.1:1.5:pi
 %           for phi = 0.1:3:2*pi 
                %choose density matrix rho uniformly from surface and inside of Bloch sphere, 
                %here we choose interval of angle to be 3 and 1.5 respectively, radius's 
                %interval to be 0.5        
 %               lamda(1) = r*sin(theta)*cos(phi);
  %              lamda(2) = r*sin(theta)*sin(phi);
  %              lamda(3) = r*cos(theta);
   %             rho = (sigma(:,:,1)+lamda(1)*sigma(:,:,2)+lamda(2)*sigma(:,:,3)+lamda(3)*sigma(:,:,4))/2;      

                lin = l;
                for i = 1:1:(n+1)*n/2
                    si = l((n-1)*n/2+1:1:(n+1)*n/2);
                    l(i) = lin(i)+delta;
                    s = l((n-1)*n/2+1:1:(n+1)*n/2);
                 %calculate update for each parameter according to difference of costvalue
                    decent = cost(digitstring,l,s,n)-cost(digitstring,lin,si,n);
                    lupdate(i) = ((decent)/delta);
                    l(i) = lin(i);
                end
                t = t + 1;
                m = beta1*m+(1-beta1)*lupdate;
                %v = [v;beta2*v(t,:)+(1-beta2)*lupdate.^2];
                v = beta2*v+(1-beta2)*lupdate.^2;
                m_hat = m/(1-beta1^t);
                %v_hat(t+1,:) = v(t+1,:)/(1-beta2^t);
                v_hat = v/(1-beta2^t);
                l = lin - (m_hat./(sqrt(v_hat)+eps))*eta+fulldec;
                %l = lin - (m_hat/(sum(sqrt(v_hat),1)+eps))*eta;
               costvalue(j) = cost(digitstring,l,s,n);
               testcostvalue(j) = cost(digitstring2,l,s,n);
         %   end
       % end    

    %end

    %save data space if cost value less than a certain small value
%%    
    if costvalue(j) < costline
        save nqubitscase_8qubits_10  %save the parameter set
        costline = costvalue(j);
    end
    
%     if costline < 0.001
%        fdecoder = decoder(l,data(1,:));%genarate time series according l and s
%        break
%     end
%costvalue(j) = cost(l,rho);
    costvalueshow = costvalue(j)
    tsetcostvalueshow = testcostvalue(j)
    j = j+1;
    flag = 0;
    flag = flag||(abs(decent)/delta>0.05);

end
    totallength  = length(digitstring);
    lengthofcompress = length(compressedata);

for i = 1:1:length(s)
sprob(i,:) = probdis(s(i));
end

sdistribution = sprob(1,:);
for i = 2:1:length(s)
sdistribution = kron(sdistribution,sprob(i,:));                                                                                                    
end

fullcost(fullcount) = 0;
for i = 1:1:length(sdistribution)-1
    revoereddata = recover(groupstructure,compressedata,i,lengthofstring);
    fullcost(fullcount) = fullcost(fullcount)+sum(revoereddata-digitstring)*sdistribution(i);
end

fullcost(fullcount)

if fullcost(fullcount)<costline
flag2 = 0;
save nqubitscase_8qubits_10
else
flag = 1;
end

fullcount = fullcount+1;

while flag
    
%generate training data's Bloch sphere parameters
%    for r = 0.5:0.5:1
 %       for theta = 0.1:1.5:pi
 %           for phi = 0.1:3:2*pi 
                %choose density matrix rho uniformly from surface and inside of Bloch sphere, 
                %here we choose interval of angle to be 3 and 1.5 respectively, radius's 
                %interval to be 0.5        
 %               lamda(1) = r*sin(theta)*cos(phi);
  %              lamda(2) = r*sin(theta)*sin(phi);
  %              lamda(3) = r*cos(theta);
   %             rho = (sigma(:,:,1)+lamda(1)*sigma(:,:,2)+lamda(2)*sigma(:,:,3)+lamda(3)*sigma(:,:,4))/2;      

                lin = l;
                for i = 1:1:(n+1)*n/2
                    si = l((n-1)*n/2+1:1:(n+1)*n/2);
                    l(i) = lin(i)+delta;
                    s = l((n-1)*n/2+1:1:(n+1)*n/2);
                 %calculate update for each parameter according to difference of costvalue
                    decent = cost(digitstring,l,s,n)-cost(digitstring,lin,si,n);
                    lupdate(i) = ((decent)/delta);
                    l(i) = lin(i);
                end
                t = t + 1;
                m = beta1*m+(1-beta1)*lupdate;
                %v = [v;beta2*v(t,:)+(1-beta2)*lupdate.^2];
                v = beta2*v+(1-beta2)*lupdate.^2;
                m_hat = m/(1-beta1^t);
                %v_hat(t+1,:) = v(t+1,:)/(1-beta2^t);
                v_hat = v/(1-beta2^t);
                l = lin - (m_hat./(sqrt(v_hat)+eps))*eta+fulldec;
                %l = lin - (m_hat/(sum(sqrt(v_hat),1)+eps))*eta;
               costvalue(j) = cost(digitstring,l,s,n);
               testcostvalue(j) = cost(digitstring2,l,s,n);
         %   end
       % end    

    %end

    %save data space if cost value less than a certain small value
%%    
    if costvalue(j) < costline
        save nqubitscase_8qubits_10  %save the parameter set
        costline = costvalue(j);
    end
    
%     if costline < 0.001
%        fdecoder = decoder(l,data(1,:));%genarate time series according l and s
%        break
%     end
%costvalue(j) = cost(l,rho);
    costvalueshow = costvalue(j)
    tsetcostvalueshow = testcostvalue(j)
    j = j+1;
    flag = 0;
    flag = flag||(abs(decent)/delta>0.1);

end
    totallength  = length(digitstring);
    lengthofcompress = length(compressedata);

for i = 1:1:length(s)
sprob(i,:) = probdis(s(i));
end

sdistribution = sprob(1,:);
for i = 2:1:length(s)
sdistribution = kron(sdistribution,sprob(i,:));                                                                                                    
end

fullcost(fullcount) = 0;
for i = 1:1:length(sdistribution)-1
    revoereddata = recover(groupstructure,compressedata,i,lengthofstring);
    fullcost(fullcount) = fullcost(fullcount)+sum(revoereddata-digitstring)*sdistribution(i);
end

fullcost2 = fullcost(fullcount)
if fullcost(fullcount)<costlinereco
flag2 = 0;
save nqubitscase_8qubits_10
else
fulldec  = fullcost(2)-fullcost(1);


end
fullcount = fullcount+1;
end

revoereddata