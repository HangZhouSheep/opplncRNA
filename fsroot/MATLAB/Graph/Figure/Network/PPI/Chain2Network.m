%%%% 根据链状表格Table，转换成Cytoscape的输入格式
%%%% CHAIN每行为Node1，Node2，Node3，Node4，……；前后两个Node形成一个Pair；即Node1-Node2-Node3-Node4
function [NODE,EDGE]=Chain2Network(CHAIN)
if isempty(CHAIN)
        NODE=[];
        EDGE=[];
        return;
end

NODE=getNode(CHAIN);
EDGE=getEdge(CHAIN);
disp('Finished Converting Chain Table  into Node and Edge Table');
end

%%%% 导出Nodes
function Nodes=getNode(CHAIN)
%%%% 定义每一列的属性
Shape={'circle','box','parallelogram','diamond'};

Nodes=[];
for j=1:size(CHAIN,2)
        Data=CHAIN(:,j);
        Data(IsEmpty(Data))=[];
        UniqueData=unique(Data);
        UniqueData(:,end+1)={j};
        UniqueData(:,end+1)=Shape(j);
        Nodes=[Nodes;UniqueData];
end
Nodes=[{'ID','Color','Shape'};Nodes];
end

%%%% 导出Edges
function Edges=getEdge(CHAIN)
Edges=[];
for j=1:size(CHAIN,2)-1
        CellData=CHAIN(:,j:j+1);
        CellData(:,end+1)={j};
        Edges=[Edges;CellData];
end

Edges=UniqueRows(Edges);
BOOL=IsEmpty(Edges);
Edges(find(any(BOOL,2)),:)=[];
Edges(:,end)=CellStr2CellNum(Edges(:,end));
Edges=[{'ID1','ID2','Color'};Edges];
end