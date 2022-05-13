%%%% 新版的excel写入程序；MarkLines为需要做高亮标记的行
function xlswrite2(Excel,Table,SheetName,Headline,MarkLines)
warning off MATLAB:xlswrite:AddSheet
SheetName=CorrectFileName(SheetName);

if istable(Table)
        Table=Table2Cell(Table);
end

if nargin<4
        Headline=1;
        MarkLines=[];
elseif nargin<5
        MarkLines=[];
end

xlsWrite(Excel,Table,SheetName);
DeleteEmptyExcelSheets(Excel);

%%%% 注释标题行
xlsHeader(Excel,SheetName,Headline);

%%%% 注释MarkLines
if isempty(MarkLines)
        disp(['Finish writing ',Excel, ' for sheet ', SheetName]);
        return;
end

MarkLines=Headline+MarkLines;
Ranges=MakeRangeStr(MarkLines);

for i=1:length(Ranges)
        xlsfont(Excel,SheetName,Ranges{i},'fontstyle','bold','color',3,'interior',4,1,5);
end

disp(['Finish writing ',Excel, ' for sheet ', SheetName]);
end

%%%% 制作range的字符串，不能太长，因此分到一个cell中
function Ranges2=MakeRangeStr(MarkLines)
[RN,CN]=size(MarkLines);
if RN<CN
        MarkLines=MarkLines';
end

MarkLength=length(MarkLines);
Ranges={};
for i=1:20:MarkLength
        if (MarkLength-i)<20
                Lines=MarkLines(i:end);
        else
                Lines=MarkLines(i:i+19);
        end
        Ranges=[Ranges,{Lines}];
end

Ranges2={};
for i=1:length(Ranges)
        Line=Ranges{i};
        Range=strcat(num2str(Line),':',num2str(Line));
        Range(:,end+1)=',';

        Lines=[];
        for ii=1:length(Line)
                Lines=[Lines,Range(ii,:)];
        end
        Lines=Lines(1:end-1);

        Lines=regexprep(Lines,' ','');
        Ranges2=[Ranges2,Lines];

end

end
