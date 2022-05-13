%%%% 讲字符串的cell转化成数字的cell
function CellData=CellStr2CellNum(CellData)
CellData=cellfun(@(x) Str2Num(x), CellData, 'UniformOutput',false); 
end

function data=Str2Num(data)
if isempty(str2num(data))
else
    data=str2num(data);
end
end
