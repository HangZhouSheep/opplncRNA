%%%% 判断workspace（base）中是否存在变量Var
function Bool=IsExistVar(Var)
Vars=evalin('base','who');
Bool=ismember(Var,Vars);
end