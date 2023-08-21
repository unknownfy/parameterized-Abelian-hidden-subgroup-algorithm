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

m1 = load('8qubitscase6.mat');
m2 = load('8qubitscase7.mat');
m3 = load('8qubitscase8.mat');
m4 = load('8qubitscase9.mat');
m5 = load('8qubitscase10.mat');
m6 = load('8qubitscase11.mat');
m7 = load('8qubitscase12.mat');
m8 = load('8qubitscase13.mat');
m9 = load('8qubitscase14.mat');
m10 = load('8qubitscase15.mat');


y1 = m1.costvalue;
y2 = m2.costvalue;
y3 = m3.costvalue;
y4 = m4.costvalue;
y5 = m5.costvalue;
y6 = m6.costvalue;
y7 = m7.costvalue;
y8 = m8.costvalue;
y9 = m9.costvalue;
y10 = m10.costvalue;

xlength = min([length(y1),length(y2),length(y3),length(y4),length(y5),length(y6),length(y7),length(y8),length(y9),length(y10)]);

y1f = y1(3:1:xlength);
y2f = y2(3:1:xlength);
y3f = y3(3:1:xlength);
y4f = y4(3:1:xlength);
y5f = y5(3:1:xlength);
y6f = y6(3:1:xlength);
y7f = y7(3:1:xlength);
y8f = y8(3:1:xlength);
y9f = y9(3:1:xlength);
y10f = y10(3:1:xlength);

xspace = 1:1:xlength-2;
ymean = mean([y1f;y2f;y3f;y4f;y5f,y6f;y7f;y8f;y9f;y10f],1);
ystd1 = ymean+std([y1f;y2f;y3f;y4f;y5f,y6f;y7f;y8f;y9f;y10f],0,1);
ystd2 = ymean-std([y1f;y2f;y3f;y4f;y5f,y6f;y7f;y8f;y9f;y10f],0,1);
yvar = var([y1f;y2f;y3f;y4f;y5f,y6f;y7f;y8f;y9f;y10f],1);
h = fill([xspace,fliplr(xspace)],[ystd1,fliplr(ystd2)],'r');
set(h,'edgealpha',0,'facealpha',0.3)
hold on
plot(xspace,ymean,'r')
%errorbar(1:1:xlength-2,ymean,ystd)