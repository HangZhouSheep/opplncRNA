%%%% 判断所有表的列数是否相同
function Bool=isSameColNum(Tables)
ColNums=cellfun(@(x) size(x,2), Tables, 'UniformOutput',false); 
ColNums=cell2mat(ColNums);
if IsSame(ColNums)
        Bool=1;
else
    disp('RowNum for all Table are not equal');
    Bool=0;
end
end