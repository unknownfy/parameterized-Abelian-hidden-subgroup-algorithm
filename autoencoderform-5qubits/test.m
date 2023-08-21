clear
clc

x = 0:0.01:2*pi;
y = sin(x);
subplot(131)
plot(x,y)
%z = fft(y);
z = y.*exp(-2*pi*-1j*x);
c = y.*exp(-1j*x);
xlabel('time'),ylabel('f(x)')
hold on 
%c = exp(2*pi*1i*x);
subplot(132)
plot(real(z),imag(z))
hold on
plot(mean(real(z)),mean(imag(z)),'r*')
xlabel('real'),ylabel('imag')
subplot(133)
plot(real(c),imag(c))
hold on
plot(mean(real(c)),mean(imag(c)),'r*')
xlabel('real'),ylabel('imag')

x = linspace(-2.0,2.0);
y = x;
[x,y] = meshgrid(x,y);
z = 1./(1.0+exp(100*x-10)+exp(100*y-10));
mesh(x,y,z)

sigma(:,:,1) = eye(2);
sigma(:,:,2) = [0 1;1 0];
sigma(:,:,3) = [0 -1i;1i 0];
sigma(:,:,4) = [1 0;0 -1];
H = 1/(sqrt(2))*[1 1; 1 -1];
A = expm(3*1i*sigma(:,:,2));
trace(-1i*sigma(:,:,1)*logm(H))/2
trace(-1i*sigma(:,:,2)*logm(H))/2
trace(-1i*sigma(:,:,3)*logm(H))/2
trace(-1i*sigma(:,:,4)*logm(H))/2
expm(1i*(1.5708*sigma(:,:,1)-1.1107*sigma(:,:,2)-1.1107*sigma(:,:,4)))
u = [1.5708 -1.1107 0 -1.1107];
l = [u u u 7 7 7 7 0 1 0];
s = [l(17) l(18) l(19)];
omiga = linspace(-2.0,2.0);
 dis = [0.9999.*(omiga<=0)+(-0.9998*omiga+0.9999).*(omiga>0&omiga<1)+0.0001.*(omiga>=1);
        0.0001.*(omiga<=0)+(0.9998*omiga+0.0001).*(omiga>0&omiga<1)+0.9999.*(omiga>=1)];
dis = [0.998.*(omiga<=-1)+(-0.997*omiga+0.001).*(omiga>-1&omiga<0)+0.001.*(omiga>=0); 
      0.001.*(omiga<=-1)+(0.997*omiga+0.998).*(omiga>-1&omiga<=0)+(-0.997*omiga+0.998).*(omiga>0&omiga<=1)+0.001.*(omiga>1);
      0.001.*(omiga<=0)+(0.997*omiga+0.001).*(omiga>0&omiga<=1)+0.998.*(omiga>1)];
%plot(omiga,dis)
%a(1) = mod(3^1,17);
a(1) = 5;
for i =2:1:16
    a(i) = mod(14^a(i-1),17);
end

swap = [1 0 0 0;
        0 0 1 0;
        0 1 0 0;
        0 0 0 1];

Us10 = eye(2^4);
Us10 = swapindexinuf(Us10,'0100','0101');
Us10 = swapindexinuf(Us10,'1100','1101');

Us01 = eye(2^4);
Us01 = swapindexinuf(Us01,'1000','1001');
Us01 = swapindexinuf(Us01,'1100','1101');
