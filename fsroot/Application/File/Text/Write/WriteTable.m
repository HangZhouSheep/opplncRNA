%%%% WriteTable(Table); 
% %%% WriteTable(Table,'a.txt');
function WriteTable(Table,OutFile)
if isempty(Table)
        disp('No Data Write to Text');
        return;
end

if nargin<2
        OutFile=UI_PutFile({'*.txt', 'Text File (*.txt)'; '*.*',  'All Files (*.*)'},'Save Prediction Result to ....');
        if isempty(OutFile)
                return;
        end
end

disp(['Start Writing ',OutFile]);
writecell(Table, OutFile,'Delimiter','\t'); %% tsv
% writecell(Table, OutFile,'Delimiter',','); %% csv
disp(['Finished Writing.']);
end