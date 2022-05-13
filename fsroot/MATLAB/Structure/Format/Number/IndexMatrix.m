%%%% 在矩阵X获得X(idx,idy)的值
%%%% idx和idy都是数组
%%%% 不能直接调用X(idx,idy)，返回的还是矩阵
function Array=IndexMatrix(X,idx,idy)
Array=X(sub2ind(size(X),idx,idy));
end
