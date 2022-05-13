%%%% 将字符串或字符串数组最前和最后的空格去除
function Str=TrimString(Str)
Str=regexprep(Str,'^\s+','');
Str=regexprep(Str,'\s+$','');
end