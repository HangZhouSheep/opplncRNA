%%%% 此程序与MergeAllTables不同
%%%% 把所有表格根据KeyCols列全部串联起来；每张表格的KeyCols列是下一张表格的关键字
%%%% MainTable=JoinTables(Tables,KeyCols,'inner')
function MergedTable=JoinTables(Tables,KeyCols,Orient)
MergedTable=Tables{1};

for i=1:length(Tables)-1
    Table=Tables{i};
    Keywords=Table(1,KeyCols);
    MergedTable=JoinTwoTable(MergedTable,Tables{i+1},Keywords,Orient);
end
end

function Table=JoinTwoTable(Table1,Table2,Keywords,Orient)
if strcmpi(Orient,'left')
    Table=LeftJoin(Table1,Table2,Keywords);
elseif strcmpi(Orient,'inner')
    Table=InnerJoin(Table1,Table2,Keywords);
elseif strcmpi(Orient,'right')
    Table=RightJoin(Table1,Table2,Keywords);
end
end