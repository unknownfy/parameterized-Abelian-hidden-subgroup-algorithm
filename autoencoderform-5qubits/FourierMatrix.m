function F = FourierMatrix(dim)
 
w = exp(2i*pi/dim); % primitive root of unity
F = (w.^((0:dim-1).'*(0:dim-1)))/sqrt(dim);