function [sum_total,U_count,e_count,m_count,U_total_idx,e_total_idx,m_total_idx] = t4_p_count(p1,p2,p3,pmbs)

format long g

filePathmbs = fullfile('附件', '附件4', 'MBS_1.xlsx');
filePathsbs_1 = fullfile('附件', '附件4', 'SBS_1.xlsx'); 
filePathsbs_2 = fullfile('附件', '附件4', 'SBS_2.xlsx'); 
filePathsbs_3 = fullfile('附件', '附件4', 'SBS_3.xlsx'); 
filePath = fullfile('附件', '附件4', 'taskflow.xlsx'); 

phimbs = readmatrix(filePathsbs_1,'Sheet','大规模衰减',"Range","B2:BS1001"); % U2 e4 m10
U_phimbs = phimbs(:,1:10);
e_phimbs = phimbs(:,11:30);
m_phimbs = phimbs(:,31:70);

phibs1 = readmatrix(filePathsbs_1,'Sheet','大规模衰减',"Range","B2:BS1001"); % U2 e4 m10
U_phibs1 = phibs1(:,1:10);
e_phibs1 = phibs1(:,11:30);
m_phibs1 = phibs1(:,31:70);

phibs2 = readmatrix(filePathsbs_2,'Sheet','大规模衰减',"Range","B2:BS1001"); % U2 e4 m10
U_phibs2 = phibs2(:,1:10);
e_phibs2 = phibs2(:,11:30);
m_phibs2 = phibs2(:,31:70);

phibs3 = readmatrix(filePathsbs_3,'Sheet','大规模衰减',"Range","B2:BS1001"); % U2 e4 m10
U_phibs3 = phibs3(:,1:10);
e_phibs3 = phibs3(:,11:30);
m_phibs3 = phibs3(:,31:70);

hmbs = readmatrix(filePathsbs_1,'Sheet','小规模瑞丽衰减',"Range","B2:BS1001"); % U2 e4 m10
U_hmbs = hmbs(:,1:10);
e_hmbs = hmbs(:,11:30);
m_hmbs = hmbs(:,31:70);

h1 = readmatrix(filePathsbs_1,'Sheet','小规模瑞丽衰减',"Range","B2:BS1001"); % U2 e4 m10
U_h1 = h1(:,1:10);
e_h1 = h1(:,11:30);
m_h1 = h1(:,31:70);

h2 = readmatrix(filePathsbs_2,'Sheet','小规模瑞丽衰减',"Range","B2:BS1001"); % U2 e4 m10
U_h2 = h2(:,1:10);
e_h2 = h2(:,11:30);
m_h2 = h2(:,31:70);

h3 = readmatrix(filePathsbs_3,'Sheet','小规模瑞丽衰减',"Range","B2:BS1001"); % U2 e4 m10
U_h3 = h3(:,1:10);
e_h3 = h3(:,11:30);
m_h3 = h3(:,31:70);

taskflow = readmatrix(filePath,'Sheet','用户任务流',"Range","B2:BS1001");
U_taskflow = taskflow(:,1:10);
e_taskflow = taskflow(:,11:30);
m_taskflow = taskflow(:,31:70);


axis_xy = readmatrix(filePath,'Sheet','用户位置',"Range","B2:EK1001");
U_axis_xy = axis_xy(:,1:20);    % 10
e_axis_xy = axis_xy(:,21:60);   % 20
m_axis_xy = axis_xy(:,61:140);   % 40

pmbs = 10;
p1 = 10;     % dbm
p2 = 10; 
p3 = 10; 
b = 360000; % Hz
U_i = 10;   % RB占用量
e_i = 5;
m_i = 2;
NF = 7;
alpha = 0.95;
e_r_LSA = 50;  % Mbps


U_N0 = -174+10.*log10(U_i.*b)+NF;
U_N0 = 10.^(U_N0/10);

Umbs_p_rx = (10.^((pmbs-U_phimbs)./10)).*(abs(U_hmbs)).^2;
U1_p_rx = (10.^((p1-U_phibs1)./10)).*(abs(U_h1)).^2;
U2_p_rx = (10.^((p2-U_phibs2)./10)).*(abs(U_h2)).^2;
U3_p_rx = (10.^((p3-U_phibs3)./10)).*(abs(U_h3)).^2;

Umbs_Gamma = ( Umbs_p_rx ) ./ (U_N0);
U1_Gamma = ( U1_p_rx ) ./ (U2_p_rx + U3_p_rx + U_N0);
U2_Gamma = ( U2_p_rx ) ./ (U1_p_rx + U3_p_rx + U_N0);
U3_Gamma = ( U3_p_rx ) ./ (U1_p_rx + U2_p_rx + U_N0);
U1_Gamma1 = ( U1_p_rx ) ./ (U_N0);
U2_Gamma1 = ( U2_p_rx ) ./ (U_N0);
U3_Gamma1 = ( U3_p_rx ) ./ (U_N0);

Umbs_r = U_i.*b.*log2(1+Umbs_Gamma) ./10e6 ;
U1_r = U_i.*b.*log2(1+U1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
U2_r = U_i.*b.*log2(1+U2_Gamma) ./10e6 ;
U3_r = U_i.*b.*log2(1+U3_Gamma) ./10e6 ;
U1_r1 = U_i.*b.*log2(1+U1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
U2_r1 = U_i.*b.*log2(1+U2_Gamma1) ./10e6 ;
U3_r1 = U_i.*b.*log2(1+U3_Gamma1) ./10e6 ;

Umbs_t = 1000.*U_taskflow./Umbs_r ;
U1_t = 1000.*U_taskflow./U1_r  ; % 毫秒 ms
U2_t = 1000.*U_taskflow./U2_r  ;
U3_t = 1000.*U_taskflow./U3_r  ;
U1_t1 = 1000.*U_taskflow./U1_r1  ; % 毫秒 ms
U2_t1 = 1000.*U_taskflow./U2_r1  ;
U3_t1 = 1000.*U_taskflow./U3_r1  ;


e_N0 = -174+10.*log10(e_i.*b)+NF;
e_N0 = 10.^(e_N0/10);

embs_p_rx = (10.^((pmbs-e_phimbs)./10)).*(abs(e_hmbs)).^2;
e1_p_rx = (10.^((p1-e_phibs1)./10)).*(abs(e_h1)).^2;
e2_p_rx = (10.^((p2-e_phibs2)./10)).*(abs(e_h2)).^2;
e3_p_rx = (10.^((p3-e_phibs3)./10)).*(abs(e_h3)).^2;

embs_Gamma = ( embs_p_rx ) ./ (e_N0);
e1_Gamma = ( e1_p_rx ) ./ (e2_p_rx + e3_p_rx + e_N0);
e2_Gamma = ( e2_p_rx ) ./ (e1_p_rx + e3_p_rx + e_N0);
e3_Gamma = ( e3_p_rx ) ./ (e1_p_rx + e2_p_rx + e_N0);
e1_Gamma1 = ( e1_p_rx ) ./ (e_N0);
e2_Gamma1 = ( e2_p_rx ) ./ (e_N0);
e3_Gamma1 = ( e3_p_rx ) ./ (e_N0);

embs_r = U_i.*b.*log2(1+embs_Gamma) ./10e6 ;
e1_r = U_i.*b.*log2(1+e1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
e2_r = U_i.*b.*log2(1+e2_Gamma) ./10e6 ;
e3_r = U_i.*b.*log2(1+e3_Gamma) ./10e6 ;
e1_r1 = U_i.*b.*log2(1+e1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
e2_r1 = U_i.*b.*log2(1+e2_Gamma1) ./10e6 ;
e3_r1 = U_i.*b.*log2(1+e3_Gamma1) ./10e6 ;

embs_t = 1000.*e_taskflow./embs_r ;
e1_t = 1000.*e_taskflow./e1_r  ; % 毫秒 ms
e2_t = 1000.*e_taskflow./e2_r  ;
e3_t = 1000.*e_taskflow./e3_r  ;
e1_t1 = 1000.*e_taskflow./e1_r1  ; % 毫秒 ms
e2_t1 = 1000.*e_taskflow./e2_r1  ;
e3_t1 = 1000.*e_taskflow./e3_r1  ;


m_N0 = -174+10.*log10(m_i.*b)+NF;
m_N0 = 10.^(m_N0/10);

mmbs_p_rx = (10.^((pmbs-m_phimbs)./10)).*(abs(m_hmbs)).^2;
m1_p_rx = (10.^((p1-m_phibs1)./10)).*(abs(m_h1)).^2;
m2_p_rx = (10.^((p2-m_phibs2)./10)).*(abs(m_h2)).^2;
m3_p_rx = (10.^((p3-m_phibs3)./10)).*(abs(m_h3)).^2;

mmbs_Gamma = ( mmbs_p_rx ) ./ (m_N0);
m1_Gamma = ( m1_p_rx ) ./ (m2_p_rx + m3_p_rx + m_N0);
m2_Gamma = ( m2_p_rx ) ./ (m1_p_rx + m3_p_rx + m_N0);
m3_Gamma = ( m3_p_rx ) ./ (m1_p_rx + m2_p_rx + m_N0);
m1_Gamma1 = ( m1_p_rx ) ./ (m_N0);
m2_Gamma1 = ( m2_p_rx ) ./ (m_N0);
m3_Gamma1 = ( m3_p_rx ) ./ (m_N0);

mmbs_r = U_i.*b.*log2(1+mmbs_Gamma) ./10e6 ;
m1_r = U_i.*b.*log2(1+m1_Gamma) ./10e6 ;    % Mbps   bps = bit/s
m2_r = U_i.*b.*log2(1+m2_Gamma) ./10e6 ;
m3_r = U_i.*b.*log2(1+m3_Gamma) ./10e6 ;
m1_r1 = U_i.*b.*log2(1+m1_Gamma1) ./10e6 ;    % Mbps   bps = bit/s
m2_r1 = U_i.*b.*log2(1+m2_Gamma1) ./10e6 ;
m3_r1 = U_i.*b.*log2(1+m3_Gamma1) ./10e6 ;

mmbs_t = 1000.*m_taskflow./mmbs_r ;
m1_t = 1000.*m_taskflow./m1_r  ; % 毫秒 ms
m2_t = 1000.*m_taskflow./m2_r  ;
m3_t = 1000.*m_taskflow./m3_r  ;
m1_t1 = 1000.*m_taskflow./m1_r1  ; % 毫秒 ms
m2_t1 = 1000.*m_taskflow./m2_r1  ;
m3_t1 = 1000.*m_taskflow./m3_r1  ;


[U_total, U_total_idx] = min(cat(3, U1_t, U2_t, U3_t, Umbs_t), [], 3);  
[U_total1, U_total1_idx] = min(cat(3, U1_t1, U2_t1, U3_t1, Umbs_t), [], 3);  
[e_total, e_total_idx] = min(cat(3, e1_t, e2_t, e3_t, embs_t), [], 3); 
[e_total1, e_total1_idx] = min(cat(3, e1_t1, e2_t1, e3_t1, embs_t), [], 3);
[m_total, m_total_idx] = min(cat(3, m1_t, m2_t, m3_t, mmbs_t), [], 3); 
[m_total1, m_total1_idx] = min(cat(3, m1_t1, m2_t1, m3_t1, mmbs_t), [], 3);
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
U_total_idxcount_4 = sum(U_total_idx(:) == 4);
U_total1_idxcount_1 = sum(U_total1_idx(:) == 1);
U_total1_idxcount_2 = sum(U_total1_idx(:) == 2);
U_total1_idxcount_3 = sum(U_total1_idx(:) == 3);
U_total1_idxcount_4 = sum(U_total1_idx(:) == 4);
U_count = [U_total_idxcount_1,U_total_idxcount_2,U_total_idxcount_3,U_total_idxcount_4;
    U_total1_idxcount_1,U_total1_idxcount_2,U_total1_idxcount_3,U_total1_idxcount_4];

e_total_idxcount_1 = sum(e_total_idx(:) == 1); 
e_total_idxcount_2 = sum(e_total_idx(:) == 2);
e_total_idxcount_3 = sum(e_total_idx(:) == 3);
e_total_idxcount_4 = sum(e_total_idx(:) == 4);
e_total1_idxcount_1 = sum(e_total1_idx(:) == 1);
e_total1_idxcount_2 = sum(e_total1_idx(:) == 2);
e_total1_idxcount_3 = sum(e_total1_idx(:) == 3);
e_total1_idxcount_4 = sum(e_total1_idx(:) == 4);
e_count = [e_total_idxcount_1,e_total_idxcount_2,e_total_idxcount_3,e_total_idxcount_4;
    e_total1_idxcount_1,e_total1_idxcount_2,e_total1_idxcount_3,e_total1_idxcount_4];

m_total_idxcount_1 = sum(m_total_idx(:) == 1); 
m_total_idxcount_2 = sum(m_total_idx(:) == 2);
m_total_idxcount_3 = sum(m_total_idx(:) == 3);
m_total_idxcount_4 = sum(m_total_idx(:) == 4);
m_total1_idxcount_1 = sum(m_total1_idx(:) == 1);
m_total1_idxcount_2 = sum(m_total1_idx(:) == 2);
m_total1_idxcount_3 = sum(m_total1_idx(:) == 3);
m_total1_idxcount_4 = sum(m_total1_idx(:) == 4);
m_count = [m_total_idxcount_1,m_total_idxcount_2,m_total_idxcount_3,m_total_idxcount_4;
    m_total1_idxcount_1,m_total1_idxcount_2,m_total1_idxcount_3,m_total1_idxcount_4];

end