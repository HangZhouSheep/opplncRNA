%%%% 读取单个Sheet的所有数据
%%%% 有重名的列会自动添加_1
function Full=xlsRead(Excel,SheetNo)
% Full = readtable(Excel,'Sheet',SheetNo,'PreserveVariableNames',true,'ReadVariableNames',true);
Full = readtable(Excel,'Sheet',SheetNo,'PreserveVariableNames',true);
Full = Table2Cell(Full);
% Full=Full(2:end,:);
end
