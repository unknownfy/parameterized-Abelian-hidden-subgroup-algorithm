function outputgate = combinegate(gate)
Uprocsess = gate{1};
for k = 2:numel(gate)
    Uprocsess = kron(Uprocsess,gate{k});
end
outputgate = Uprocsess;
end