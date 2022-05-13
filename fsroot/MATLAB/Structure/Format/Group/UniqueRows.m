%%%% 对数据进行去行冗余；不排序；支持cell和table格式
function [UniqueGroup,varargout]=UniqueRows(CellData)
if istable(CellData)
    [UniqueGroup,GroupCount]=FindUnique(CellData);
elseif iscell(CellData)
    [UniqueGroup,GroupCount]=ForCell(CellData);
elseif isstring(CellData)
    [UniqueGroup,GroupCount]=ForCell(CellData);
end
varargout{1}=GroupCount;
end

%%%% 为cell数据进行去行冗余
function [UniqueGroup,GroupCount]=ForCell(CellData)
ColNum=size(CellData,2);
Header=strcat('Col',num2CellStr(1:ColNum));
Table=[Header;CellData];
Table=CellNum2CellStr(Table);
Table=Cell2Table(Table);

[UniqueGroup,GroupCount]=FindUnique(Table);
UniqueGroup=Table2Cell(UniqueGroup);
UniqueGroup=UniqueGroup(2:end,:);
GroupCount=Table2Cell(GroupCount);
GroupCount=GroupCount(2:end,:);
end

%%%% 为table数据进行去行冗余，保持标题行
function [UniqueGroup,GroupCount]=FindUnique(Table)
ColNum=size(Table,2);

UniqueGroup=groupsummary(Table,1:ColNum);
GroupCount=UniqueGroup(:,end);
UniqueGroup=UniqueGroup(:,1:end-1);
end




