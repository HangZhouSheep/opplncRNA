%%%% 适用于lncRNA-miRNA-mRNA和cirRNA-miRNA-mRNA的关系寻找
%%%% Tables：原始数据，多个表单，且第一列为ID号
% %%% DB：数据库名称，可以不加载，可以部分加载
%%%% eg. FindCeNetwork(Tables,'Spearman', -0.9,0.05,'lncRNA-miRNA-URS','miRNA-mRNA-Symbol')
%%%% eg. FindCeNetwork(Tables, 'Spearman',[-0.9,-0.8],[0.05,0.05])
%%%% eg. FindCeNetwork(Tables, 'Spearman',[-0.9,-0.8],[0.05,0.05],'lncRNA-miRNA-URS',[])
%%%% eg. FindCeNetwork(Tables, 'Spearman',[-0.9,-0.8],[0.05,0.05],[],'miRNA-mRNA-Symbol')
%%%% eg. FindCeNetwork(Tables, 'Spearman',-0.9,0.05,'miRNA-mRNA-Symbol')

function [Chain,DBs]=FindCeNetwork(Tables,Distance,Rcutoffs,Pcutoffs,varargin)
DBs=varargin;
Chain=[];

%%%% 处理ceRNA的原始数据，获得pairs
[Chains,Pairs]=CorrelationChain(Tables,Distance,Rcutoffs,Pcutoffs);
NamePairs=Pairs(:,3);

%%%% 数据库的pair和原始数据的pair进行比对
for i=1:length(DBs)
    DB=compareDatabase(DBs{i},NamePairs{i});
    if size(DB,1)==1
        disp('No database match');
        return;
    end
    DBs{i}=DB;
end

%%%% 所有表格关联
Chain = JoinTables(DBs,2,'inner');
end

%%%% 导入数据库，对前两列去冗余，并和NamePair进行比较
function DB=compareDatabase(DB,NamePair)
if isempty(DB)
    DB=NamePair;
    return;
end

disp('Loading Database ....');
DB=readtable(DB,'delimiter', '\t','ReadVariableNames',1);
DB=DB(:,1:2);
Header=DB.Properties.VariableNames;

DB=UniqueRows(DB);
disp(['Finished Loading ',strjoin(Header,'-')]);

%%%% 数据库的pair和原始数据的pair进行比对
DB=InnerJoin(NamePair,DB,Header);
end

