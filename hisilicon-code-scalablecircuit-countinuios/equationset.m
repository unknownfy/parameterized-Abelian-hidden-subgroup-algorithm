function b = equationset(l)
d = 3;

A = [2 1 0 1; 
    1 0 2 0;
    1 2 2 1;
    0 1 1 0];%2121
Aexpect = zeros(4,1);
%%


% b = sin((A*l'.*pi)./d);




%%
for i = 1:1:4
    dis(i,:) = probdis(l(i));
end

for n = 1:1:4
    for i = 1:1:3
        for j = 1:1:3
            for k = 1:1:3
                for m = 1:1:3
                    Aexpect(n) = Aexpect(n)+A(n,:)*[(i-1); (j-1); (k-1); (m-1)]*dis(1,i)*dis(2,j)*dis(3,k)*dis(4,m);
                end
            end
        end
    end
end



b = sin((Aexpect.*pi)./d);

% A = [1 2;
%     2 1;
%     1 1;
%     0 1;
%     1 0];
% 
% b = sin((A*l'.^2*pi)./2);




end