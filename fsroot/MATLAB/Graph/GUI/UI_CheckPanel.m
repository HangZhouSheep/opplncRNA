%%%% 获取AppDesigner的面板中的所有打钩的复选框的名称
%%%% uiCheckPanel为面板对象，如app.Database
function Names=UI_CheckPanel(uiCheckPanel)
CheckBox=uiCheckPanel.Children;
Names=[];

for i=1:length(CheckBox)
        if CheckBox(i).Value
                Name=CheckBox(i).Text;
                Names=[Names,{Name}];
        end
end
end