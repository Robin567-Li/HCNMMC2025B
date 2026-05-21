clc,clear,close all

format short

filePath = fullfile('附件', '附件1', 'channel_data.xlsx'); 

axis_xy = readmatrix(filePath,'Sheet','用户位置',"Range","B2:AG2");

hold on

for i = 1:16
    scatter(axis_xy(2*i-1),axis_xy(2*i),15,"r","filled")
end
% scatter(0, 0, 15,"b","filled")
labels = {'U1', 'U2', 'e1', 'e2', 'e3', 'e4', 'm1', 'm2', 'm3', 'm4','m5','m6','m7','m8','m9','m10'};

% 在每个点上添加标注
for i = 1:16
    text(axis_xy(2*i-1), axis_xy(2*i), labels{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
% text(0, 0, 'BS', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

xlabel("X轴")
ylabel("Y轴")
title("第一问和第二问用户位置")