%%%% 导入Txt文件，进行BOOL表格筛选；支持多个关键字及条件的筛选值为1
%%%% 输出所有的列
%%%% Type为intersect或者union
%%%% eg. DB=FilterDatabase('miRNA-mRNA.txt','intersect','ENCORI','TarBase');
function DB=FilterDatabase(dbFile,Type,varargin)
Keywords=varargin;

disp('Loading Database ....');
DB=readtable(dbFile,'delimiter', '\t','ReadVariableNames',1);   %%%% 速度比readcell快
Header=DB.Properties.VariableNames;
disp('Finished Loading.');

KeyCol=IndexKeywords(Keywords,Header);
db=DB(:,KeyCol);
db=table2array(db);

if strcmpi(Type,'intersect')
        DB=DB(all(db,2),:);
elseif strcmpi(Type,'union')
        DB=DB(any(db,2),:);
end

disp('Finished Filtering.');
end

%%%% 找到关键字所处的列
function KeyCol=IndexKeywords(Keywords,Header)
for i=1:length(Keywords)
        Keyword=Keywords{i};
        KeyCol(i)=find(strcmp(Keyword,Header));
end
end
