%%%% 每两张表之间每两列之间做相关系数计算，用的是corr函数对矩阵的直接操作
%%%% Distance='Pearson' | 'Kendall' | 'Spearman';
%%%% eg. [R,P]=Correlation('Spearman',DATA)
%%%% eg. [R,P]=Correlation('Spearman',DATA1,DATA2)

function [R,P]=Correlation(Distance,varargin)
DATAs=varargin;
DataNum=length(DATAs);

disp('Computing coefficients');
disp('This procedure very slow when the Matrix is bigger, Please wait ...');

if DataNum==1
        [R,P]=Corr1(DATAs{1},Distance);
elseif DataNum==2
        [R,P]=Corr2(DATAs{1},DATAs{2},Distance);
end
disp('Finished Computing');
end

%%%% 返回输入矩阵 X 中各列之间的两两线性相关系数矩阵
function [R,P]=Corr1(X,Distance)
[R,P]=corr(X,'type',Distance,'rows','pairwise');
end

%%%% 返回输入矩阵 X 和 Y 中各列之间的两两相关系数矩阵。
function [R,P]=Corr2(X,Y,Distance)
[R,P]=corr(X,Y,'type',Distance,'rows','pairwise');
end