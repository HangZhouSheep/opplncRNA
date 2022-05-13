%%%% 将网络按照是否有联系分割成独立的网络
function [NODEs,EDGEs,NetNum]=SeparateNetwork(NODE,EDGE)
Network=InitialNetwork(NODE,EDGE);
[NODEs,EDGEs]=DistillNetwork(Network,NODE,EDGE);
NetNum=Network.Number;
end

%%%% 创建整个网络的矩阵
function Network=InitialNetwork(NODE,EDGE)
[NODE,EDGE]=CheckNetwork(NODE,EDGE);

Node=NODE(2:end,1);
NodeNum=length(Node);

EdgeID=EDGE(2:end,1:2);
EdgeID=cell2mat(EdgeID);
EdgeID(:,end+1)=1;

S=sparse(EdgeID(:,1),EdgeID(:,2),EdgeID(:,3),NodeNum,NodeNum);
Net=SplitNetwork(S);

Network.Net=Net(:,1);
Network.Number=Net(:,2);
Network.Full=full(S);
end

%%%% 在总网络中提取分割的网络信息
function [NODEs,EDGEs]=DistillNetwork(Network,NODE,EDGE)
NODEs={};
EDGEs={};

Header=NODE(1,:);
NODE=NODE(2:end,:);

Nets=Network.Net;

for i=1:length(Nets)
        Net=Nets{i};
        NODEs{i}=[Header;NODE(Net,:)];
        Edge=SearchEdge(NODEs{i},EDGE);
        EDGEs{i}=Edge;
end
NODEs=NODEs';
EDGEs=EDGEs';
end

function EDGE=SearchEdge(NODE,EDGE)
Node=NODE(2:end,1);

Header=EDGE(1,:);
EDGE=EDGE(2:end,:);
Pairs=EDGE(:,1:2);

Rows=[];
for i=1:size(Pairs,1)
        Pair=Pairs(i,:);
        Bool=ismember(Pair,Node);
        if all(Bool)
                Rows=[Rows,i];
        end
end

EDGE=EDGE(Rows,:);
EDGE=[Header;EDGE];
end