%%%% 该程序用于将一个有向无环网络分成互不相连的子网络，S是相互作用的Sparse矩阵
%%%% 返回一个N行2列的元胞：第一列为子网络涉及的节点ID,第二列为元素个数，且降序排列
function Modules=SplitNetwork(S)
[r,c]=find(S);
Pairs=[r c]; 
Modules={};

while(length(Pairs)>0)
  Tree=Pairs(1,1);m=1;Tree_Size=0;                %以Pairs第一个素数出发搜索包含该元素的子网络           
      while(Tree_Size<length(Tree))                
              Tree_Size=length(Tree);
              row=ismember(Pairs(:,1),Tree);
              row=find(row);
              Tree=[Tree,Pairs(row',2)'];
              Pairs(row',:) = [];
              
              row=ismember(Pairs(:,2),Tree);
              row=find(row);
              Tree=[Tree,Pairs(row',1)'];
              Pairs(row',:) = [];
              
             Tree=unique(Tree);                                  
      end
      Module=[{Tree},length(Tree)];
      Modules=[Modules;Module];                                         %将新搜出来的子网络赋给元胞    
end

Modules=sortrows(Modules,2);
Modules=flipud(Modules);
end