clc,clear,close all

format long g


[sum_total,U_count,e_count,m_count] = t3_p_count(10,30,10);

sum_list = zeros(125,1);
p3_list = cell(125,1);
U_count_list = cell(125,1);
e_count_list = cell(125,1);
m_count_list = cell(125,1);
n = 0;
% for p1 = [10,15,20,25,30]
%     for p2 = [10,15,20,25,30]
%         for p3 = [10,15,20,25,30]
%             n = n + 1;  % 101
%             [sum_total,U_count,e_count,m_count] = t3_p_count(p1,p2,p3);
%             sum_list(n) = sum(sum_total);
%             p3_list{n} = [p1,p2,p3];
%             U_count_list{n} = U_count;
%             e_count_list{n} = e_count;
%             m_count_list{n} = m_count; 
%         end
%     end
% end

% [sum_total,U_count,e_count,m_count] = t3_p_count(10,10,30)
[sum_total,U_count,e_count,m_count] = t3_p_count(10,30,10)
% [sum_total,U_count,e_count,m_count] = t3_p_count(30,10,10)