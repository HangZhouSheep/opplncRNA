%%%%把Array变成2个配对的形式
%%%% eg. Array=1:6； 变成[1,2;2,3;3,4;4,5;5,6]
function INDEX=num2repeat(Array)
[RowNum,ColNum]=size(Array);
if RowNum<ColNum
        Array=Array';
end

Array1=Array(1:end-1);
Array2=Array(2:end);

INDEX = [Array1,Array2];
end