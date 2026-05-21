clc,clear,close all

format long g

[sum_total,U_count,e_count,m_count,U_total_idx,e_total_idx,m_total_idx] = t4_p_count(10,10,30,40);

count_list = [U_total_idx,e_total_idx,m_total_idx]

writematrix(count_list, 't4_MBS_SBS.xlsx'); 



