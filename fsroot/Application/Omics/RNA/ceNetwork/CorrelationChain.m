%%%% 对Tables中先后每两张表的各行之间的两两线性相关系，满足阈值返回ID pairs；支持无穷张表
%%%% 主要是调用CorrelationPair，把结果输出到文件
function [Chains,Pairs]=CorrelationChain(Tables,Distance,Rcutoffs,Pcutoffs)
if ~isSameColNum(Tables)
        Pairs=[];
        Chains=[];
        return;
end

Pairs=CorrelationPair(Tables,Distance,Rcutoffs,Pcutoffs);
NamePairs=Pairs(:,3);

%%%% 输出每两张表之间的ID Pair表，包含ID和相关系数
%%% 输出结果可能过大
for i=1:size(Pairs,1)
        NamePair=NamePairs{i};
        OutFile=strjoin(NamePair(1,:),'-');
        OUT=[Pairs{i,3},Pairs{i,4}];
        disp(['Writing ', OutFile]);
        writecell(OUT,[OutFile,'.txt'],'Delimiter','\t');
end

%%%  把NamePairs表格全部inner串联起来； 输出lncRNA-miRNA-mRNA的ID表，三列
Chains = JoinTables(NamePairs,2,'inner');
% disp('Writing All Chains ...');
% writecell(Chains,'Chains.txt','Delimiter','\t');
% disp('Finished Writing.');
end