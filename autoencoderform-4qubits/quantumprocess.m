function outputstate = quantumprocess(gate,inputstate)
%%%%%%%%%%apply gate on inputstate%%%%%%%%
Uprocsess = gate{1};
for k = 2:numel(gate)
    Uprocsess = kron(Uprocsess,gate{k});
end
outputstate = Uprocsess*inputstate*Uprocsess';

