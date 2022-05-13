%%%% 利用输出文件对话框获得文件路径
function FullFileName=UI_PutFile(Suffix,Prompt)
if nargin<2
    Prompt='Save to ...';
end
if nargin<1
    Suffix={'*.xlsx;*.xls','Excel File (*.xlsx, *.xls)'; '*.*',  'All Files (*.*)'};
end

FullFileName=[];

[file,path] = uiputfile(Suffix,Prompt);
if isequal(file,0) || isequal(path,0)
    return;
end

FullFileName = fullfile(path,file);
end