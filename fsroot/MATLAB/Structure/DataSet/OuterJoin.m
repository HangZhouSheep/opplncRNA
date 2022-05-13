%%%% 数据库的最基础的Join 方法；KeywordsAhead是形成的新表中 Keywords 是否提到最前面列。
%%%% 所有的Keywords列必须是字符串
function Table=OuterJoin(Table1,Table2,Type,Keywords,KeywordsAhead)
if nargin<4
    KeywordsAhead=0;
end

if ischar(Keywords)
    Keywords={Keywords};
end

[MergeHeader,Table1,Table2]=RenameTableHeader(Table1,Table2,Keywords,KeywordsAhead);
Table=OutJoin(Table1,Table2,Type,Keywords);

Table(1,:)=MergeHeader;
end

%%%% 修改表头，保留Keyword列，其他改成A或B开头的列名
function [MergeHeader,Table1,Table2]=RenameTableHeader(Table1,Table2,Keywords,KeywordsAhead)
Table1 = Table2Cell(Table1);
Table2 = Table2Cell(Table2);

Header1=Table1(1,:);
[Bool,Index]=ismember(Keywords,Header1);
KeyColumn=Index(Bool);

Table1(1,:)=AddSerial(length(Header1),'A','before');
Table1(1,KeyColumn)=Keywords;

if KeywordsAhead
    KEY=Table1(:,KeyColumn);
    Table1(:,KeyColumn)=[];
    Table1=[KEY,Table1];
end

Header2=Table2(1,:);
[Bool,Index]=ismember(Keywords,Header2);
KeyColumn=Index(Bool);

Table2(1,:)=AddSerial(length(Header2),'B','before');
Table2(1,KeyColumn)=Keywords;

Header2(KeyColumn)=[];
MergeHeader=[Header1,Header2];
end

%%%%合并后的table按照Table1进行排序
function Table=OutJoin(Table1,Table2,Type,Keywords)
Table1=Cell2Table(Table1);
Table2=Cell2Table(Table2);

[Table,IndexA] = outerjoin(Table1,Table2,'Keys',Keywords,'Type',Type,'MergeKeys',true);

IndexA = array2table(IndexA,'VariableNames',{'No'});
Table=[IndexA,Table];
Table=sortrows(Table,'No');
Table(:,{'No'})=[];

Table = Table2Cell(Table);
end