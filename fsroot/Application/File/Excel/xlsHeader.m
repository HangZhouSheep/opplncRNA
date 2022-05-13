%%%% Excel的表头进行高亮标识
function xlsHeader(ExcelFile,SheetName,Headline)
if nargin<3
    Headline=1;
end

Range=[num2str(1),':',num2str(Headline)];
Range2=['A',num2str(Headline+1)];

xlsfont(ExcelFile,SheetName,Range,'font','Arial','fontstyle','bold','color',2,'interior',5,1,4);
xlsalign(ExcelFile,SheetName,Range,'Horizontal',3);

xlsFreezeLine(ExcelFile,SheetName,Range2);
end
