%%%% 数据库的 InnerJoin 方法；KeywordsAhead是形成的新表中 Keywords 是否提到最前面列。
function Table=InnerJoin(Table1,Table2,Keywords,KeywordsAhead)
if nargin<4
        KeywordsAhead=0;
end

if isempty(Table1)
        Table=Table2;
        return;
end
if isempty(Table2)
        Table=Table1;
        return;
end

Table=OuterJoin(Table1,Table2,'inner',Keywords,KeywordsAhead);
if istable(Table1)
        Table=Cell2Table(Table);
end
end
