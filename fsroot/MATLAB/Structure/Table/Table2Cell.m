%%%% 数据结构Table转成Cell
function Table=Table2Cell(Table)
if ~istable(Table)
    return;
end

TableHeader=Table.Properties.VariableNames;
Table = table2cell(Table);
Table=[TableHeader;Table];
end
