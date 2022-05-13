%%%% 批量显示网络
%%%% 读取多个NODE和EDGE表格，每个表格各显示一张网络
function DisplayNetworks(NODEs,EDGEs,TopN)
if nargin<3
        TopN=10;
end

for i=1:length(NODEs)
        if i>TopN
                return;
        end
        DisplayNetwork(NODEs{i},EDGEs{i});
end
end

%%%%读取NODE和EDGE表格，只显示一张网络，不分割
function DisplayNetwork(NODE,EDGE)
[NODE,EDGE]=CheckNetwork(NODE,EDGE);
BG=ConstructNetwork(NODE,EDGE);
BG=ModifyNode(BG,NODE);
BG=ModifyEdge(BG,EDGE);
view(BG);
end

%%%% 创建网络矩阵，获得biograph对象
function BG=ConstructNetwork(NODE,EDGE)
Node=NODE(2:end,1);
NodeNum=length(Node);

EdgeID=EDGE(2:end,1:2);
EdgeID=cell2mat(EdgeID);
EdgeID(:,end+1)=1;

S=sparse(EdgeID(:,1),EdgeID(:,2),EdgeID(:,3),NodeNum,NodeNum);
BG=biograph(S);
end

%%%% 将NODE的属性赋给BG对象的所有节点
function BG=ModifyNode(BG,NODE)
Header=NODE(1,:);
NODE=Cell2Table(NODE);
Names=NODE.ID;
NodeNum=length(Names);
ID=cellstr(string(1:NodeNum));

Num=find(strcmpi(Header,'color'));
ColorID=NODE{:,Num};
Colors=idx2color(ColorID);

Num=find(strcmpi(Header,'shape'));
Shapes=NODE{:,Num};

for i=1:NodeNum
        BG.Nodes(i).ID=ID{i};
        BG.Nodes(i).FontSize=18;
        BG.Nodes(i).Size=[10,10];
        BG.Nodes(i).LineWidth=2;
        BG.Nodes(i).TextColor=[1,1,1];
        BG.Nodes(i).Label=Names{i};
        BG.Nodes(i).Color=Colors(i,:);
        BG.Nodes(i).Shape=Shapes{i};
end
end

%%%% 将EDGE的属性赋给BG对象的所有边
function BG=ModifyEdge(BG,EDGE)
EDGE=Cell2Table(EDGE);
ColorID=EDGE.Color;
Colors=idx2color(ColorID);
EdgeNum=length(ColorID);

for i=1:EdgeNum
        BG.Edges(i).LineWidth=2;
        BG.Edges(i).LineColor=Colors(i,:);
end
end