%%%% 检查NODE和EDGE文件
%%%% 将边的名称改成Index；将错误的边删除
function [NODE,EDGE]=CheckNetwork(NODE,EDGE)
EDGE=Edge2Index(NODE,EDGE);
EDGE=DeleteEdge(EDGE);
end

%%%% 将边的名称改成Index（NODE表中的ID的顺序）
function EDGE=Edge2Index(NODE,EDGE)
Key=NODE(2:end,1);

Header=EDGE(1,:);
EDGE=EDGE(2:end,:);
Edge1=EDGE(:,1);
Edge2=EDGE(:,2);

[~,Idx1]=ismember(Edge1,Key);
[~,Idx2]=ismember(Edge2,Key);

Index=[Idx1,Idx2];
EDGE(:,1:2)=num2cell(Index);
EDGE=[Header;EDGE];
end

%%%% 删除一行只有1个值，以及2个值一样的边
function EDGE=DeleteEdge(EDGE)
Header=EDGE(1,:);
EDGE=EDGE(2:end,:);
Index=cell2mat(EDGE(:,1:2));

[idx,idy]=find(~Index);
Row1=find(idx); %%%% 只有1个值
Row2=find((Index(:,1)-Index(:,2))==0); %%%% 两个点一样

EDGE(Row1|Row2,:)=[];
EDGE=[Header;EDGE];
end