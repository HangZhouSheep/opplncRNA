%%%% 判断CellData是否是NaN，返回BOOL矩阵
function BOOL=IsNaN(CellData)
BOOL=cellfun(@(x) any(isnan(x(:))), CellData,'UniformOutput',false);
BOOL=cell2mat(BOOL);
end
