%%%% 读取tab格式的文本，产生table的Cell变量
function Table=ReadTable(File)
Table=[];

if nargin<1
        File=UI_GetFile({'*.txt','Txt File (*.txt)'},'Open File ...');
end

if isempty(File)
        return;
end

disp(['Loading ',File, ' ...']);
Table=readcell(File,'delimiter', '\t');
end

