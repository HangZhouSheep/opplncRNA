%%%% xlswrite2出错时，用这个命令
function xlsWrite(Excel,Table,SheetName)
warning off MATLAB:xlswrite:AddSheet

if istable(Table)
        Table=Table2Cell(Table);
end
if isnumeric(Table)
        Table=num2cell(Table);
end

writecell(Table,Excel,'Sheet',SheetName)
% disp(['Finish writing ',Excel, ' for sheet ', SheetName]);
end
