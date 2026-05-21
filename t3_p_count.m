function [sum_total,U_count,e_count,m_count] = t3_p_count(p1,p2,p3)

format long g

filePathbs1 = fullfile('附件', '附件3', 'BS1.xlsx'); 
filePathbs2 = fullfile('附件', '附件3', 'BS2.xlsx'); 
filePathbs3 = fullfile('附件', '附件3', 'BS3.xlsx'); 
filePath = fullfile('附件', '附件3', 'taskflow.xlsx'); 

phibs1 = readmatrix(filePathbs1,'Sheet','大规模衰减',"Range","B2:AW1001"); % U2 e4 m10
U_phibs1 = phibs1(:,1:6);
e_phibs1 = phibs1(:,7:18);
m_phibs1 = phibs1(:,19:48);

phibs2 = readmatrix(filePathbs2,'Sheet','大规模衰减',"Range","B2:AW1001"); % U2 e4 m10
U_phibs2 = phibs2(:,1:6);
e_phibs2 = phibs2(:,7:18);
m_phibs2 = phibs2(:,19:48);

phibs3 = readmatrix(filePathbs3,'Sheet','大规模衰减',"Range","B2:AW1001"); % U2 e4 m10
U_phibs3 = phibs3(:,1:6);
e_phibs3 = phibs3(:,7:18);
m_phibs3 = phibs3(:,19:48);

h1 = readmatrix(filePathbs1,'Sheet','小规模瑞丽衰减',"Range","B2:AW1001"); % U2 e4 m10
U_h1 = h1(:,1:6);
e_h1 = h1(:,7:18);
m_h1 = h1(:,19:48);

h2 = readmatrix(filePathbs2,'Sheet','小规模瑞丽衰减',"Range","B2:AW1001"); % U2 e4 m10
U_h2 = h2(:,1:6);
e_h2 = h2(:,7:18);
m_h2 = h2(:,19:48);

h3 = readmatrix(filePathbs3,'Sheet','小规模瑞丽衰减',"Range","B2:AW1001"); % U2 e4 m10
U_h3 = h3(:,1:6);
e_h3 = h3(:,7:18);
m_h3 = h3(:,19:48);

taskflow = readmatrix(filePath,'Sheet','用户任务流',"Range","B2:AW1001");
U_taskflow = taskflow(:,1:6);
e_taskflow = taskflow(:,7:18);
m_taskflow = taskflow(:,19:48);


axis_xy = readmatrix(filePath,'Sheet','用户位置',"Range","B2:CS1001");
U_axis_xy = axis_xy(:,1:12);    % 6
e_axis_xy = axis_xy(:,13:36);   % 12
m_axis_xy = axis_xy(:,37:96);   % 30


% p1 = 10;     % dbm
% p2 = 10; 
% p3 = 10; 
b = 360000; % Hz
U_i = 10;   % RB占用量
e_i = 5;
m_i = 2;
NF = 7;
alpha = 0.95;
e_r_LSA = 50;  % Mbps


U_N0 = -174+10.*log10(U_i.*b)+NF;
U_N0 = 10.^(U_N0/10);

U1_p_rx = (10.^((p1-U_phibs1)./10)).*(abs(U_h1)).^2;
U2_p_rx = (10.^((p2-U_phibs2)./10)).*(abs(U_h2)).^2;
U3_p_rx = (10.^((p3-U_phibs3)./10)).*(abs(U_h3)).^2;

U1_Gamma = ( U1_p_rx ) ./ (U2_p_rx + U3_p_rx + U_N0);
U2_Gamma = ( U2_p_rx ) ./ (U1_p_rx + U3_p_rx + U_N0);
U3_Gamma = ( U3_p_rx ) ./ (U1_p_rx + U2_p_rx + U_N0);
U1_Gamma1 = ( U1_p_rx ) ./ (U_N0);
U2_Gamma1 = ( U2_p_rx ) ./ (U_N0);
U3_Gamma1 = ( U3_p_rx ) ./ (U_N0);

U1_r = U_i.*b.*log2(1+U1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
U2_r = U_i.*b.*log2(1+U2_Gamma) ./10e6 ;
U3_r = U_i.*b.*log2(1+U3_Gamma) ./10e6 ;
U1_r1 = U_i.*b.*log2(1+U1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
U2_r1 = U_i.*b.*log2(1+U2_Gamma1) ./10e6 ;
U3_r1 = U_i.*b.*log2(1+U3_Gamma1) ./10e6 ;

U1_t = 1000.*U_taskflow./U1_r  ; % 毫秒 ms
U2_t = 1000.*U_taskflow./U2_r  ;
U3_t = 1000.*U_taskflow./U3_r  ;
U1_t1 = 1000.*U_taskflow./U1_r1  ; % 毫秒 ms
U2_t1 = 1000.*U_taskflow./U2_r1  ;
U3_t1 = 1000.*U_taskflow./U3_r1  ;


e_N0 = -174+10.*log10(e_i.*b)+NF;
e_N0 = 10.^(e_N0/10);

e1_p_rx = (10.^((p1-e_phibs1)./10)).*(abs(e_h1)).^2;
e2_p_rx = (10.^((p2-e_phibs2)./10)).*(abs(e_h2)).^2;
e3_p_rx = (10.^((p3-e_phibs3)./10)).*(abs(e_h3)).^2;

e1_Gamma = ( e1_p_rx ) ./ (e2_p_rx + e3_p_rx + e_N0);
e2_Gamma = ( e2_p_rx ) ./ (e1_p_rx + e3_p_rx + e_N0);
e3_Gamma = ( e3_p_rx ) ./ (e1_p_rx + e2_p_rx + e_N0);
e1_Gamma1 = ( e1_p_rx ) ./ (e_N0);
e2_Gamma1 = ( e2_p_rx ) ./ (e_N0);
e3_Gamma1 = ( e3_p_rx ) ./ (e_N0);

e1_r = U_i.*b.*log2(1+e1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
e2_r = U_i.*b.*log2(1+e2_Gamma) ./10e6 ;
e3_r = U_i.*b.*log2(1+e3_Gamma) ./10e6 ;
e1_r1 = U_i.*b.*log2(1+e1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
e2_r1 = U_i.*b.*log2(1+e2_Gamma1) ./10e6 ;
e3_r1 = U_i.*b.*log2(1+e3_Gamma1) ./10e6 ;

e1_t = 1000.*e_taskflow./e1_r  ; % 毫秒 ms
e2_t = 1000.*e_taskflow./e2_r  ;
e3_t = 1000.*e_taskflow./e3_r  ;
e1_t1 = 1000.*e_taskflow./e1_r1  ; % 毫秒 ms
e2_t1 = 1000.*e_taskflow./e2_r1  ;
e3_t1 = 1000.*e_taskflow./e3_r1  ;


m_N0 = -174+10.*log10(m_i.*b)+NF;
m_N0 = 10.^(m_N0/10);

m1_p_rx = (10.^((p1-m_phibs1)./10)).*(abs(m_h1)).^2;
m2_p_rx = (10.^((p2-m_phibs2)./10)).*(abs(m_h2)).^2;
m3_p_rx = (10.^((p3-m_phibs3)./10)).*(abs(m_h3)).^2;

m1_Gamma = ( m1_p_rx ) ./ (m2_p_rx + m3_p_rx + m_N0);
m2_Gamma = ( m2_p_rx ) ./ (m1_p_rx + m3_p_rx + m_N0);
m3_Gamma = ( m3_p_rx ) ./ (m1_p_rx + m2_p_rx + m_N0);
m1_Gamma1 = ( m1_p_rx ) ./ (m_N0);
m2_Gamma1 = ( m2_p_rx ) ./ (m_N0);
m3_Gamma1 = ( m3_p_rx ) ./ (m_N0);

m1_r = U_i.*b.*log2(1+m1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
m2_r = U_i.*b.*log2(1+m2_Gamma) ./10e6 ;
m3_r = U_i.*b.*log2(1+m3_Gamma) ./10e6 ;
m1_r1 = U_i.*b.*log2(1+m1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
m2_r1 = U_i.*b.*log2(1+m2_Gamma1) ./10e6 ;
m3_r1 = U_i.*b.*log2(1+m3_Gamma1) ./10e6 ;

m1_t = 1000.*m_taskflow./m1_r  ; % 毫秒 ms
m2_t = 1000.*m_taskflow./m2_r  ;
m3_t = 1000.*m_taskflow./m3_r  ;
m1_t1 = 1000.*m_taskflow./m1_r1  ; % 毫秒 ms
m2_t1 = 1000.*m_taskflow./m2_r1  ;
m3_t1 = 1000.*m_taskflow./m3_r1  ;


[U_total, U_total_idx] = min(cat(3, U1_t, U2_t, U3_t), [], 3);  
[U_total1, U_total1_idx] = min(cat(3, U1_t1, U2_t1, U3_t1), [], 3);  
[e_total, e_total_idx] = min(cat(3, e1_t, e2_t, e3_t), [], 3); 
[e_total1, e_total1_idx] = min(cat(3, e1_t1, e2_t1, e3_t1), [], 3);
[m_total, m_total_idx] = min(cat(3, m1_t, m2_t, m3_t), [], 3); 
[m_total1, m_total1_idx] = min(cat(3, m1_t1, m2_t1, m3_t1), [], 3);
uu = (U_total-U_total1)./U_total1;
uu(isnan(uu)) = 0; 
ee = (e_total-e_total1)./e_total1;
ee(isnan(ee)) = 0; 
mm = (m_total-m_total1)./m_total1;
mm(isnan(mm)) = 0; 
sum_total = [sum(uu,"all"),sum(ee,"all"),sum(mm,"all")]./[6,12,30];

U_total_idxcount_1 = sum(U_total_idx(:) == 1); 
U_total_idxcount_2 = sum(U_total_idx(:) == 2);
U_total_idxcount_3 = sum(U_total_idx(:) == 3);
U_total1_idxcount_1 = sum(U_total1_idx(:) == 1);
U_total1_idxcount_2 = sum(U_total1_idx(:) == 2);
U_total1_idxcount_3 = sum(U_total1_idx(:) == 3);
U_count = [U_total_idxcount_1,U_total_idxcount_2,U_total_idxcount_3;
    U_total1_idxcount_1,U_total1_idxcount_2,U_total1_idxcount_3];

e_total_idxcount_1 = sum(e_total_idx(:) == 1); 
e_total_idxcount_2 = sum(e_total_idx(:) == 2);
e_total_idxcount_3 = sum(e_total_idx(:) == 3);
e_total1_idxcount_1 = sum(e_total1_idx(:) == 1);
e_total1_idxcount_2 = sum(e_total1_idx(:) == 2);
e_total1_idxcount_3 = sum(e_total1_idx(:) == 3);
e_count = [e_total_idxcount_1,e_total_idxcount_2,e_total_idxcount_3;
    e_total1_idxcount_1,e_total1_idxcount_2,e_total1_idxcount_3];

m_total_idxcount_1 = sum(m_total_idx(:) == 1); 
m_total_idxcount_2 = sum(m_total_idx(:) == 2);
m_total_idxcount_3 = sum(m_total_idx(:) == 3);
m_total1_idxcount_1 = sum(m_total1_idx(:) == 1);
m_total1_idxcount_2 = sum(m_total1_idx(:) == 2);
m_total1_idxcount_3 = sum(m_total1_idx(:) == 3);
m_count = [m_total_idxcount_1,m_total_idxcount_2,m_total_idxcount_3;
    m_total1_idxcount_1,m_total1_idxcount_2,m_total1_idxcount_3];

end