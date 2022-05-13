%%%% 判断CellData是否为空，返回BOOL矩
function BOOL=IsEmpty(CellData)
BOOL1=cellfun(@(x) any(isempty(x(:))), CellData);
BOOL2=IsNaN(CellData);
BOOL=BOOL1|BOOL2;
end