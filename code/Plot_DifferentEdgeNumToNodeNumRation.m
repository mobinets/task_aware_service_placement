%Plot_DifferentEdgeNumToNodeNumRation
%最后论文使用了这个函数画的图，DAG的复杂度（其实就是边的数量与点的数量的比值）

userNum = 1;
Servernum = 5;
%Tasknum = 30;
Tasknum = 15;

%Ration = [0,2,4,6,8,10];
Ration = [0,1,2,3,4,5,6];
len = length(Ration(:));

for i=1:len
    
    for times = 1 : 10
    Graph = GenarateGraph_DifferentEdgeNum(Tasknum,Tasknum * Ration(i));
    % 这里设置userNum为1，直接给Taskgraph赋值就行了
    Taskgraph = zeros(Tasknum,Tasknum,userNum);
    Taskgraph(:,:,1) = Graph;
%   [Taskgraph,Graph] = GenarateGraphCommon_2(Graph,Tasknum,userNum,0.3);
    %[ServerMemory,TaskMemory,Possionrate,Transferrate,Computespeed_Local,ComputeSpeed_server,EdgeWeight,TaskSize] = GenerateData(userNum,Servernum,Tasknum);
    [ServerMemory,TaskMemory,Possionrate,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server,EdgeWeight,TaskSize] = GenerateData_NetworkConnect(round(Servernum*(Servernum-1)/4),userNum,Servernum,Tasknum);
    Taskgraph = FulFillTaskgraph(Taskgraph,EdgeWeight,TaskSize,userNum,Tasknum);
    
%      for j = 1 : userNum
%          [~, ~] = countTaskLayer(Taskgraph(:,:,j),Tasknum,times,const(i),j);
%      end

    %[preCache,preTaskComputationSpeed,preFinishTime] = P1_RankOnNum(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Computespeed_Local,ComputeSpeed_server);
    [preCache_p3,preTaskComputationSpeed_p3,preFinishTime_p3] = P3_network(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server);
     
     
    %[preCache_infocom,preTaskComputationSpeed_infocom,preFinishTime_infocom] = P1_infocom(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Computespeed_Local,ComputeSpeed_server);
    %[preCache_iwqos,preTaskComputationSpeed_iwqos,preFinishTime_iwqos] = P1_iwqos(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Computespeed_Local,ComputeSpeed_server);
    [preCache_iwqos,preTaskComputationSpeed_iwqos,preFinishTime_iwqos] = P1_iwqos_network(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server);
     
    %[preCache_infocom2,preTaskComputationSpeed_infocom2,preFinishTime_infocom2] = Copy_of_P1_infocom(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Computespeed_Local,ComputeSpeed_server);
    [preCache_infocom,preTaskComputationSpeed_infocom,preFinishTime_infocom] = P1_infocom_network(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server);
    
    [~,~,preFinishTime_best] = P1_IterateNum_network(3000,Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server);
    
    Ration(i)
    
%     y(i) = preFinishTime_p3;
%     y2(i) = preFinishTime_infocom;
%     y3(i) = preFinishTime_iwqos;
%     y4(i) =  preFinishTime_best;
        z(i,times) = preFinishTime_p3;
        z2(i,times) = preFinishTime_infocom;
        z3(i,times) = preFinishTime_iwqos;
        z4(i,times) = preFinishTime_best;
        
    end
end

for i = 1 : length(Ration)
    y(i) = mean(z(i,:));
    y2(i) = mean(z2(i,:));
    y3(i) = mean(z3(i,:));
    y4(i) = mean(z4(i,:));
end

hold on;
plot(Ration,y4);
plot(Ration,y);
plot(Ration,y2);
plot(Ration,y3);



% for i=1:len
%     Graph = GenarateGraph_DifferentEdgeNum(Tasknum,Tasknum * Ration(i));
%     % 这里设置userNum为1，直接给Taskgraph赋值就行了
%     Taskgraph = zeros(Tasknum,Tasknum,userNum);
%     Taskgraph(:,:,1) = Graph;
%     
%      %[ServerMemory,TaskMemory,Possionrate,Transferrate,Computespeed_Local,ComputeSpeed_server,EdgeWeight,TaskSize] = GenerateData(userNum,Servernum,Tasknum);
%      [ServerMemory,TaskMemory,Possionrate,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server,EdgeWeight,TaskSize] = GenerateData_NetworkConnect(round(Servernum*(Servernum-1)/4),userNum,Servernum,Tasknum);
%      Taskgraph = FulFillTaskgraph(Taskgraph,EdgeWeight,TaskSize,userNum,Tasknum);
%      
%      for kk = 1:20
%      
%     [preCache_iwqos,preTaskComputationSpeed_iwqos,preFinishTime_iwqos] = P1_iwqos_network(Tasknum,userNum,Servernum,ServerMemory,TaskMemory,Possionrate,Taskgraph,Transferrate,Transferrate_network,Computespeed_Local,ComputeSpeed_server);
%      
%     sum_iwqos(i,kk) = preFinishTime_iwqos;
%     
%      end
%     
%      Ration(i)
%     
%  
% end

