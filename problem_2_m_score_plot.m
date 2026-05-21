clc,clear,close all

format short g

filePath = fullfile('附件', '附件2', 'channel_data.xlsx'); 

phi = readmatrix(filePath,'Sheet','大规模衰减',"Range","B2:Q1001"); % U2 e4 m10
U_phi = phi(:,1:2);
e_phi = phi(:,3:6);
m_phi = phi(:,7:16);
h = readmatrix(filePath,'Sheet','小规模瑞丽衰减',"Range","B2:Q1001");
U_h = h(:,1:2);
e_h = h(:,3:6);
m_h = h(:,7:16);
taskflow = readmatrix(filePath,'Sheet','用户任务流',"Range","B2:Q1001");
U_taskflow = taskflow(:,1:2);
e_taskflow = taskflow(:,3:6);
m_taskflow = taskflow(:,7:16);
axis_xy = readmatrix(filePath,'Sheet','用户位置',"Range","B2:AG1001");
U_axis_xy = axis_xy(:,1:4);
e_axis_xy = axis_xy(:,5:12);
m_axis_xy = axis_xy(:,13:32);
p = 30;     % dbm
b = 360000; % Hz
U_i = 10;   % RB占用量
e_i = 5;
m_i = 2;
NF = 7;
alpha = 0.95;
e_r_LSA = 50; % Mbps


U_N0 = -174+10.*log10(U_i.*b)+NF;
U_N0 = 10.^(U_N0/10);
U_p_rx = (10.^((p-U_phi)./10)).*(abs(U_h)).^2;
U_Gamma = ( U_p_rx ) ./ (U_N0);
U_r = U_i.*b.*log2(1+U_Gamma) ./10e6 ;    % Mbps   bps = bit/s

U_t = 1000.*U_taskflow./U_r  ;             % 毫秒 ms


e_N0 = -174+10.*log10(e_i.*b)+NF;   
e_N0 = 10.^(e_N0/10);
e_p_rx = (10.^((p-e_phi)./10)).*(abs(e_h)).^2;
e_Gamma = ( e_p_rx ) ./ (e_N0);

e_r = e_i.*b.*log2(1+e_Gamma) ./10e6  ;   % Mbps   bps = bit/s
e_t = 1000.*e_taskflow./e_r ;              % 毫秒 ms


m_N0 = -174+10.*log10(m_i.*b)+NF;
m_N0 = 10.^(m_N0/10);
m_p_rx = (10.^((p-m_phi)./10)).*(abs(m_h)).^2;
m_Gamma = ( m_p_rx ) ./ (m_N0);
m_r = m_i.*b.*log2(1+m_Gamma) ./10e6 ;    % Mbps   bps = bit/s

m_t = 1000.*m_taskflow./m_r      ;         % 毫秒 ms


hold on
total_score_list = zeros(25,1);
for i = 1:50
    total_score_list(i) =  t2_m_score(i,m_t);
end
scatter(1:50,total_score_list,"r*")
plot(1:50,total_score_list,"r")
xlabel("mMTC切片数")
ylabel("用户得分")
title("1000ms情况下mMTC切片数与得分的关系")
