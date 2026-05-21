clc,clear,close all


filePath = fullfile('附件', '附件3', 'taskflow.xlsx'); 

axis_xy = readmatrix(filePath,'Sheet','用户位置',"Range","B2:CS1001");
axis_xy = axis_xy(1,:);

hold on

for i = 1:48  % 6 12 30
    scatter(axis_xy(2*i-1),axis_xy(2*i),15,"r","filled")
end

scatter(0, 500, 50,"b","filled")
scatter(-433.0127, -250, 50,"b","filled")
scatter(433.0127, -250, 50,"b","filled")

labels = {'U1', 'U2', 'U3', 'U4','U5', 'U6','e1', 'e2', 'e3', 'e4','e5', ...
    'e6', 'e7', 'e8','e9', 'e10','e11', 'e12','m1', 'm2', 'm3', 'm4','m5','m6','m7','m8','m9','m10',...
    'm11', 'm12', 'm13', 'm14','m15','m16','m17','m18','m19','m20'...
    'm21', 'm22', 'm23', 'm24','m25','m26','m27','m28','m29','m30'}
labels1 = {'BS1','BS2','BS3'};

% 在每个点上添加标注
for i = 1:48
    text(axis_xy(2*i-1), axis_xy(2*i), labels{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
text(0, 500, labels1{1}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(-433.0127, -250, labels1{2}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(433.0127, -250, labels1{3}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

xlabel("X轴")
ylabel("Y轴")
title("第三问用户和基站位置（0ms时）")

	% BS1: (0, 500)
	% BS2: (-433.0127, -250)
	% BS3: (433.0127, -250)