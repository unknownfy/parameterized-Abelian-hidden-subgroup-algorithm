clear
clc
%%
m1 = load('nqubitscase_8qubits_11.mat');
m2 = load('nqubitscase_8qubits_12_test.mat');
m3 = load('nqubitscase_8qubits_13_test.mat');
m4 = load('nqubitscase_8qubits_11_cs.mat');
%m5 = load('nqubitscase_8qubits_9.mat');
% m6 = load('8qubitscase11.mat');
% m7 = load('8qubitscase12.mat');
% m8 = load('8qubitscase13.mat');
% m9 = load('8qubitscase14.mat');
% m10 = load('8qubitscase15.mat');


y1 = m1.costvalue;
y2 = m2.costvalue;
y3 = m3.costvalue;
y4 = m4.costvalue;
%y5 = m5.costvalue;
% y6 = m6.costvalue;
% y7 = m7.costvalue;
% y8 = m8.costvalue;
% y9 = m9.costvalue;
% y10 = m10.costvalue;

%xlength = min([length(y1),length(y2),length(y3),length(y4),length(y5),length(y6),length(y7),length(y8),length(y9),length(y10)]);


xlength = min([length(y1),length(y2),length(y3),length(y4)]);


y1f = [y1(length(y1)-xlength+3:1:length(y1)),0];
y2f = [y2(length(y2)-xlength+3:1:length(y2)),0];
y3f = [y3(length(y3)-xlength+3:1:length(y3)),0];
y4f = [y4(length(y4)-xlength+3:1:length(y4)),0];
%y5f = y5(length(y5)-xlength+3:1:length(y5));
% y6f = y6(3:1:xlength);
% y7f = y7(3:1:xlength);
% y8f = y8(3:1:xlength);
% y9f = y9(3:1:xlength);
% y10f = y10(3:1:xlength);

xspace = 1:1:xlength-1;
% ymean = mean([y1f;y2f;y3f;y4f;y5f;y6f;y7f;y8f;y9f;y10f],1);
% ystd1 = ymean+std([y1f;y2f;y3f;y4f;y5f;y6f;y7f;y8f;y9f;y10f],0,1);
% ystd2 = ymean-std([y1f;y2f;y3f;y4f;y5f;y6f;y7f;y8f;y9f;y10f],0,1);
% yvar = var([y1f;y2f;y3f;y4f;y5f;y6f;y7f;y8f;y9f;y10f],1);

ymean = mean([y1f;y2f;y3f;y4f],1);
ystd1 = ymean+std([y1f;y2f;y3f;y4f],0,1);
ystd2 = ymean-std([y1f;y2f;y3f;y4f],0,1);
yvar = var([y1f;y2f;y3f;y4f],1);

h1 = fill([xspace,fliplr(xspace)],[ystd1,fliplr(ystd2)],'r');
set(h1,'edgealpha',0,'facealpha',0.3)
hold on
plot(xspace,ymean,'r')
%%
% m11 = load('6qubitscase1.mat');
% m12 = load('6qubitscase2.mat');
% m13 = load('6qubitscase3.mat');
% m14 = load('6qubitscase4.mat');
% m15 = load('6qubitscase5.mat');
% m16 = load('6qubitscase6.mat');
% m17 = load('6qubitscase7.mat');
% m18 = load('6qubitscase8.mat');
% m19 = load('6qubitscase9.mat');
% m20 = load('6qubitscase10.mat');
% % m21 = load('6qubitcase11.mat');
% % m22 = load('6qubitcase12.mat');
% % m23 = load('6qubitcase13.mat');
% % m24 = load('6qubitcase14.mat');
% 
% g1 = m11.costvalue;
% g2 = m12.costvalue;
% g3 = m13.costvalue;
% g4 = m14.costvalue;
% g5 = m15.costvalue;
% g6 = m16.costvalue;
% g7 = m17.costvalue;
% g8 = m18.costvalue;
% g9 = m19.costvalue;
% g10 = m20.costvalue;
% % g3 = m13.costvalue;
% % g4 = m14.costvalue;
% % g5 = m15.costvalue;
% 
% slength = max([length(g1),length(g2),length(g3),length(g4),length(g5),length(g6),length(g7),length(g8),length(g9),length(g10)]);
% 
% g1f = [g1(3:1:length(g1)),zeros(1,slength-length(g1))];
% g2f = [g2(3:1:length(g2)),zeros(1,slength-length(g2))];
% g3f = [g3(3:1:length(g3)),zeros(1,slength-length(g3))];
% g4f = [g4(3:1:length(g4)),zeros(1,slength-length(g4))];
% g5f = [g5(3:1:length(g5)),zeros(1,slength-length(g5))];
% g6f = [g6(3:1:length(g6)),zeros(1,slength-length(g6))];
% g7f = [g7(3:1:length(g7)),zeros(1,slength-length(g7))];
% g8f = [g8(3:1:length(g8)),zeros(1,slength-length(g8))];
% g9f = [g9(3:1:length(g9)),zeros(1,slength-length(g9))];
% g10f = [g10(3:1:length(g10)),zeros(1,slength-length(g10))];
% % g5f = g5(3:1:slength);
% % g6f = g6(3:1:slength);
% % g7f = g7(3:1:slength);
% % g8f = g8(3:1:slength);
% % g9f = g9(3:1:slength);
% % g10f = g10(3:1:slength);
% 
% sspace = 1:1:slength-2;
% gmean = mean([g1f;g2f;g3f;g4f;g5f;g6f;g7f;g8f;g9f;g10f],1);
% gstd1 = gmean+std([g1f;g2f;g3f;g4f;g5f;g6f;g7f;g8f;g9f;g10f ],0,1);
% gstd2 = gmean-std([g1f;g2f;g3f;g4f;g5f;g6f;g7f;g8f;g9f;g10f ],0,1);
% gvar = var([g1f;g2f;g3f;g4f;g5f;g6f;g7f;g8f;g9f;g10f ],1);
% h2 = fill([sspace,fliplr(sspace)],[gstd1,fliplr(gstd2)],'b');
% %;g6f;g7f;g8f;g9f;g10f
% 
% 
% set(h2,'edgealpha',0,'facealpha',0.3)
% plot(sspace,gmean,'b')

%%
%legend('','average cost value for 8 qubits','','average cost value for 6 qubits')
legend('','average cost value for 8 qubits')
xlabel('Step')
ylabel('Cost value')
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];

%%for bar error bar
x = 1:2
data1 = [71.6347 71.7008 72.4118 71.288 71.5884 71.5521 71.6471 71.7525 72.9281 117.9807]./256
data = [0 mean(data1)];
errhigh = [0 std(data1)];
errlow = [0 std(data1)];
bar(x,data)
hold on

er = errorbar(x,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
ylabel("mean squared erroe")



