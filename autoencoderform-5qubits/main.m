%clear old data
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


    

%META-PARAMETERS FOR GRADIENT DESCENT
global delta %delta is size of parameter variation in probing cost landscape 
delta = 0.001;   %interval
eta = 0.01; % gradient descent jumpsize    
costline = 0.1;  %a cost value that is acceptable for you to save



%initialize unitary parameters randomly upper-bounded by ub
ub = 1;      %upper bound of unitary parameters
for i = 1:1:4+3+2+1
    initialPi(i) = (((rand(1)))*ub);
    l(i) = initialPi(i);
end

 
for i =1:1:5
    s(i) = rand(1); 
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
while 1     
%while flag
    
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
                for i = 1:1:4+3+2+1+5 
                    si = [l(11) l(12) l(13) l(14) l(15)];
                    l(i) = lin(i)+delta;
                    s = [l(11) l(12) l(13) l(14) l(15)];
                 %calculate update for each parameter according to difference of costvalue
                    lupdate(i) = ((cost(l,s)-cost(lin,si))/delta);
                    l(i) = lin(i);
                end
                t = t + 1;
                m = beta1*m+(1-beta1)*lupdate;
                %v = [v;beta2*v(t,:)+(1-beta2)*lupdate.^2];
                v = beta2*v+(1-beta2)*lupdate.^2;
                m_hat = m/(1-beta1^t);
                %v_hat(t+1,:) = v(t+1,:)/(1-beta2^t);
                v_hat = v/(1-beta2^t);
                l = lin - (m_hat./(sqrt(v_hat)+eps))*eta;
                %l = lin - (m_hat/(sum(sqrt(v_hat),1)+eps))*eta;
               costvalue(j) = cost(l,s);
         %   end
       % end

    %end

    %save data space if cost value less than a certain small value
%%    
    if costvalue(j) < costline
        save 10qubitscase  %save the parameter set
        costline = costvalue(j);
    end
    
%     if costline < 0.001
%        fdecoder = decoder(l,data(1,:));%genarate time series according l and s
%        break
%     end
    %costvalue(j) = cost(l,rho);
    costvalue(j)
    j = j+1;
    %flag = 0;
    %flag = flag||(abs(costvalue(j)-costvalue1(j-1))/delta>0.01);
end
 min(costvalue(find(costvalue-min(costvalue))))