%%%% 根据NumArray和AddString产生流水号；
%%%% Orient为before和after
%%%% AddSerial(1:5,'A','before')：产生A1,A2,A3,A4,A5
function Serial=AddSerial(NumArray,AddString,Orient)
if length(NumArray)==1
    NumArray=1:NumArray;
end

if strcmpi(Orient,'before')
    Serial=AddString + string(NumArray);
elseif strcmpi(Orient,'after')
    Serial=string(NumArray) + AddString;
end
Serial=cellstr(Serial);
end
