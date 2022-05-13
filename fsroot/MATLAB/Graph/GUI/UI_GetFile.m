%%%% 利用文件对话框获得文件路径
function FullFileName=UI_GetFile(Suffix,Prompt)
if nargin<2
    Prompt='Open File ...';
end
if nargin<1
    Suffix={'*.xlsx;*.xls','Excel File (*.xlsx;*.xls)'};
end

FullFileName=[];

[filename,pathname] = uigetfile(Suffix,Prompt);
if isequal(filename,0) || isequal(pathname,0)
    return;
end

FullFileName = fullfile(pathname,filename);

FH = fopen(FullFileName,'rt');
if FH == -1
    msgbox('Error opening the file');
    fclose(FH);
    return;
end
fclose(FH);
end