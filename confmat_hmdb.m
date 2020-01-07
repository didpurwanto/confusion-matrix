clc
clear
close all

% load data_conf.mat
inp = 'hmdb_rgb flow.txt';
A = importdata(inp);
% data should be Nx3, where N is the number of video testing and row 1 is
% counter, row 2 is the ground truth, and row 3 is the predicted class.

% make conf
data_conf = create_table(A);

% create confusion matrix
classname = {'brush hair','cartwheel','catch','chew','clap','climb','climb stairs','dive','draw sword','dribble','drink','eat','fall floor','fencing','flic flac','golf','handstand','hit','hug','jump','kick','kick ball','kiss','laugh','pick','pour','pullup','punch','push','pushup','ride bike','ride horse','run','shake hands','shoot ball','shoot bow','shoot gun','sit','situp','smile','smoke','somersault','stand','swing baseball','sword','sword exercise','talk','throw','turn','walk','wave'};
nclass = length(classname);

fig = figure;
imagesc(data_conf); 
colormap(parula);
colorbar;

textStrings = num2str(data_conf(:),'%0.1f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding

set(gca,'XTick',1:nclass,...                         %# Change the axes tick marks
        'XTickLabel',classname, 'YTick',1:nclass,...
        'YTickLabel',classname, 'TickLength',[0 0]);
    set(gca,'XTickLabelRotation',45)
set(gca,'XTickLabelRotation',45)


n = length(data_conf);
acc = 0;
tmp = [];
for kk = 1:n
    temp = data_conf(kk,kk)/30;
    tmp = [tmp temp];
    acc = acc+temp;
end
[B,I] = sort(tmp);
for jj = 1:n
    t = I(jj);
    disp([classname{t}, '\t', num2str(B(jj))]);
end

disp('----------------')
disp(['FINAL ACC: ',num2str(acc/n)])


function cMatrix = create_table(A)
    label = A(:,2);
    predict = A(:,3);
    [cMatrix,~] = confusionmat(label,predict);
    
end