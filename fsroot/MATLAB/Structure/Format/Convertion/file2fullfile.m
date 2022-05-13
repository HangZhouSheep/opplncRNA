function FullFileName=file2fullfile(FileName)
if regexp(FileName,':')
    FullFileName=FileName;
    return;
end

[fpath,Prefix,Extent] = fileparts(char(FileName));
filename=[Prefix,Extent];
FullFileName=fullfile(pwd,fpath,filename);
end
