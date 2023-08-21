clear
clc
hiddenSize1 = 3;
input = [0     0     1     1     2     2     3     3;
     0     1     0     1     2     3     2     3;
     0     1     1     0     2     3     3     2;
     0     1     2     3     0     1     2     3;
     0     1     2     3     1     0     3     2;
%      0     1     2     3     2     3     0     1;
%      0     1     2     3     3     2     1     0;
     ]';
ttest = [  0     1     2     3     2     3     0     1;
          0     1     2     3     3     2     1     0;
     ]';
 autoenc1 = trainAutoencoder(input,hiddenSize1,...
     'MaxEpochs',1200);
%      'EncoderTransferFunction','satlin',...
%      'DecoderTransferFunction','purelin',...
%      'L2WeightRegularization',0.01,...
%      'SparsityRegularization',4,...
%      'SparsityProportion',0.10

% inputReconstructed = predict(autoenc,input);
% mseError = mse(input-inputReconstructed)
feat1 = encode(autoenc1,input);
output1 = decode(autoenc1,feat1);

% autoenc2 = trainAutoencoder(feat1,3);
% feat2 = encode(autoenc2,feat1);
% output2 = decode(autoenc2,feat2);
% output3 = decode(autoenc1,output2);
% deepnet = stack(autoenc1,autoenc2);
% 
% 
% deepnet = train(deepnet,input,feat2);
% deepouput = deepnet(input);
view(autoenc1)
%view(deepnet)
%inputReconstructed = predict(deepnet,input);
%show_result(deepnet)