clear
clc
hiddenSize1 = 100;
% input = [0     0     1     1     2     2     3     3;
%      0     1     0     1     2     3     2     3;
%      0     1     1     0     2     3     3     2;
%      0     1     2     3     0     1     2     3;
%      0     1     2     3     1     0     3     2;
% %      0     1     2     3     2     3     0     1;
% %      0     1     2     3     3     2     1     0;
%      ]';
%ttest = [  0     1     2     3     2     3     0     1;
 %         0     1     2     3     3     2     1     0;
 %    ]';
 input =[0:1:2^7-1  flip(0:1:2^7-1)];
 ttest = [1:1:2^7-1 0 0 flip(1:1:2^7-1);
          2:1:2^7-1 1 0 0 1 flip(2:1:2^7-1);
          3:1:2^7-1 2 1 0 0 1 2 flip(3:1:2^7-1);
          4:1:2^7-1 3 2 1 0 0 1 2 3 flip(4:1:2^7-1)];
 autoenc1 = trainAutoencoder(input,hiddenSize1,...
     'MaxEpochs',400);
%      'EncoderTransferFunction','satlin',...
%      'DecoderTransferFunction','purelin',...
%      'L2WeightRegularization',0.01,...
%      'SparsityRegularization',4,...
%      'SparsityProportion',0.10

% inputReconstructed = predict(autoenc,input);
% mseError = mse(input-inputReconstructed)
feat1 = encode(autoenc1,input);
output1 = decode(autoenc1,feat1);

autoenc2 = trainAutoencoder(feat1,8);
feat2 = encode(autoenc2,feat1);
output2 = decode(autoenc2,feat2);
output3 = decode(autoenc1,output2);
deepnet = stack(autoenc1,autoenc2);


%deepnet = train(deepnet,input,feat2);
deepouput = deepnet(input);
% view(autoenc1)
% for i = 1:1:4
% inputReconstructed(i,:) = predict(autoenc1,ttest(i,:));
% end
%view(deepnet)
%inputReconstructed = deepnet(input);

for i = 1:1:4

%output1 = decode(autoenc1,feat1);
deepouput = deepnet(ttest(i,:));
output2 = decode(autoenc2,deepouput);
inputReconstructed(i,:) = decode(autoenc1,output2);


end
sum((inputReconstructed-ttest).^2,2)
%show_result(deepnet)