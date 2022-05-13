%%%% 数据结构Table转成Cell
function Table=Cell2Table(Table,AddNewHeader)
if istable(Table)
    return;
end

if  nargin<2
        AddNewHeader=0;
end

if AddNewHeader
        ColNum=size(Table,2);
        Header=cellstr('C'+string(1:ColNum));
        Table = cell2table(Table,'VariableNames', Header);
else
        Header=Table(1,:);
        Table = cell2table(Table(2:end,:),'VariableNames', Header);
end
end
