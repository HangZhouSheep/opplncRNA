%%%% 数据库的 LeftJoin 方法；KeywordsAhead是形成的新表中 Keywords 是否提到最前面列。
%%%% 所有的Keywords列必须是字符串
function Table=LeftJoin(Table1,Table2,Keywords,KeywordsAhead)
if nargin<4
    KeywordsAhead=0;
end

if isempty(Table1)
    Table=Table2;
    return;
elseif isempty(Table2)
    Table=Table1;
    return;
end

Table=OuterJoin(Table1,Table2,'left',Keywords,KeywordsAhead);
if istable(Table1)
        Table=Cell2Table(Table);
end
end