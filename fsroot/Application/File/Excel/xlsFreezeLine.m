function xlsFreezeLine(ExcelFile,SheetName,Range)
filename=file2fullfile(ExcelFile);
if nargin<3
    Range='A2';
end


hExcel = actxserver('Excel.Application'); %%%%创建Excel对象
Workbook=invoke(hExcel.Workbooks, 'open',filename); %%%% 激活工作薄
% hExcel.Visible = 1;

hSheet=hExcel.Worksheets.get('Item',SheetName);%%%%获取SheetName对象
hRange = get(hSheet,'Range',Range);%%%%获取Range对象

hRange.Select; %%%% 选定Range范围
hExcel.ActiveWindow.FreezePanes = 1; %%%% Range范围，冻结窗口
hRange.Select;
hRange.AutoFilter; %%%% 在Range范围，进行过滤

invoke(Workbook, 'Save'); %%%% 保存工作薄
invoke(hExcel, 'Quit'); %%%% 退出Excel对象
delete(hExcel); %%%% 删除Excel对象

end
