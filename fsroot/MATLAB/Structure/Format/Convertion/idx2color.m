%%%% index转变成RGB的cell数组
%%%% Index可以是八种单字母颜色；也可以是单个值，在distinguishable_colors中取值
function Colors=idx2color(Index)
if iscellstr(Index)
    Colors=Index;
    return;
end

if isnumeric(Index)
    if size(Index,2)==3
        Colors=Index;
        return;
    end
    
    ColorMatrix = distinguishable_colors(1000);
    Colors=ColorMatrix(Index,:);
    return;
end

Colors=Index;
end
