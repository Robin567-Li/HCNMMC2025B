clc,clear,close all


data = [20, 20, 10]; 
labels = {'20个RB', '20个RB', '10个RB'}; % 标注类别及占比

pie3(data, labels);
title('第一问资源块分配结果');
legend("URLLC切片","eMBB切片","mMTC切片")