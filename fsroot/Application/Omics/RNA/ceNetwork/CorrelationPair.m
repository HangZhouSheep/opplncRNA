%%%% 对Tables中先后每两张表的各行之间的两两线性相关系数，满足阈值返回ID pairs；支持无穷张表
%%%% 每个Table必须是第一列为ID，名称会保留；后面都是数值，标准格式
%%%% Distance='Pearson' (default) | 'Kendall' | 'Spearman';
%%%% 支持多阈值，Rcutoffs大于0寻找正相关，小于0寻找反相关（适用于ceRNA网络）
%%%% Pairs的格式为4列的cell：table_i，table_j，{Name Pairs}，{R,P}
%%%% eg. CorrelationPair({Table1,Table2}, 'Spearman')
%%%% eg. CorrelationPair({Table1,Table2}, 'Spearman',-0.9,0.05)
%%%% eg. CorrelationPair({Table1,Table2,Table3}, 'Spearman',[-0.9,-0.8],[0.05,0.05])
%%%% eg. CorrelationPair({Table1,Table2,Table3,Table4}, 'Spearman',[-0.9,-0.8,0.8],[0.05,0.05,0.05])
function Pairs=CorrelationPair(Tables,Distance,Rcutoffs,Pcutoffs)
if ~isSameColNum(Tables)
        Pairs=[];
        return;
end

if nargin==2
        Rcutoffs=[];
        Pcutoffs=[];
end

TableNum=length(Tables);
INDEX=num2repeat(1:TableNum);
PairNum=size(INDEX,1);

if length(Rcutoffs)==1
        Rcutoffs=repelem(Rcutoffs,PairNum);
end
if length(Pcutoffs)==1
        Pcutoffs=repelem(Pcutoffs,PairNum);
end

Pairs=[];
for i=1:PairNum
        n1=INDEX(i,1);
        n2=INDEX(i,2);

        Table1=Tables{n1};
        Name1=Table1(1,1);
        ID1=Table1(2:end,1);
        DATA1=cell2mat(Table1(2:end,2:end));

        Table2=Tables{n2};
        Name2=Table2(1,1);
        ID2=Table2(2:end,1);
        DATA2=cell2mat(Table2(2:end,2:end));

        [idx,idy,R,P]=FilterCorrelation(DATA1,DATA2,Distance,Rcutoffs(i),Pcutoffs(i));
        Pair=[[Name1,Name2];[ID1(idx),ID2(idy)]];
        Score=[{Distance,'pValue'};num2cell([R,P])];

        Pairs=[Pairs;[num2cell([n1,n2]),{Pair},{Score}]];
end
end

%%%% 每两张表之间的行迭代；返回坐标[idx, idy]，相关系数，p值
function [idx,idy,R,P]=FilterCorrelation(DATA1,DATA2,Distance,Rcutoff,Pcutoff)
[R,P]=Correlation(Distance,DATA1',DATA2');

if nargin>3
        if Rcutoff>=0
                [idx,idy]=find(R>=Rcutoff & P<=Pcutoff);
        elseif Rcutoff<0
                [idx,idy]=find(R<=Rcutoff & P<=Pcutoff);
        end
else
        [idx,idy]=find(R);
end

R=IndexMatrix(R,idx,idy);
P=IndexMatrix(P,idx,idy);
end
