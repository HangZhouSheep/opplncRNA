%%%% 判断矩阵中整行或整列值是否都相同，或者整个矩阵每个元素是否相同
function Bool=IsSame(MATRIX,Orient)
if nargin<2
    Orient=3;
end

[RowNum,ColNum]=size(MATRIX);

Bool=[];
if Orient==1
    for j=1:ColNum
        Array=MATRIX(:,j);
        bool=IsSameArray(Array);
        Bool=[Bool,bool];
    end
elseif Orient==2
    for i=1:RowNum
        Array=MATRIX(i,:);
        bool=IsSameArray(Array);
        Bool=[Bool;bool];
    end
elseif Orient==3
    if isnumeric(MATRIX)
        Bool=all(all(MATRIX(1)==MATRIX));
    elseif iscell(MATRIX)
        Bool=all(all(strcmp(MATRIX{1},MATRIX)));
    end
end
end

%%%% 一个数组中的元素是否相同
function Bool=IsSameArray(Array)
if isnumeric(Array)
    Bool=all(Array(1)==Array);
elseif iscell(Array)
    Bool=all(strcmp(Array{1},Array));
end
end