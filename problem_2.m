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

% [total_score,L_list] = t2_m_score(20,m_t);
% [total_score,L_list] = t2_e_score(10,e_t,e_r,e_r_LSA);
% [total_score,L_list] = t2_U_score(1,U_t);

uu = zeros(10,1);
for i = 1:10
    U_t100ms = U_t(100*(i-1)+1:100*i,:);
    [total_score,L_list] = t2_U_score_100ms(i,2,U_t100ms);
    L_list;
    for j = 1:100
        if any(L_list(j,:) > 101-j)
            L_list(j,:)
            i
        end
    end
    uu(i) = t2_U_score_100ms(i,2,U_t100ms)-t2_U_score_100ms(i,1,U_t100ms);
end
uu

% ee = zeros(10,1);
% for i = 1:10
%     e_t100ms = e_t(100*(i-1)+1:100*i,:);
%     e_r100ms = e_r(100*(i-1)+1:100*i,:);
%     ee(i) = t2_e_score_100ms(i,4,e_t100ms,e_r100ms,e_r_LSA)-t2_e_score_100ms(i,2,e_t100ms,e_r100ms,e_r_LSA);
% end
% ee

% m_t100ms = m_t(101:200,:);
% [total_score,L_list] = t2_m_score_100ms(1,m_t100ms)

% mm = zeros(10,1);
% for i = 1:10
%     m_t100ms = m_t(100*(i-1)+1:100*i,:);
%     mm(i) = t2_m_score_100ms(6,m_t100ms)-t2_m_score_100ms(1,m_t100ms);
% end
% mm
