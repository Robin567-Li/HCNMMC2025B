function [total_score,L_list] = t2_m_score_100ms(num,m_t)

U_t = m_t;
num_flag = zeros(num,1);
Q_list = zeros(100,10);
L_list = zeros(100,10);
chengfadian = {};
n = 0;
for i = 1:size(U_t,1)
    for j = 1:size(U_t,2)
        [iii,ii] = min(num_flag);
        Q = ceil(num_flag(ii));
        num_flag(ii) = U_t(i,j) + Q;
        Q_list(i,j) = Q;
        L_list(i,j) = num_flag(ii);
        if any(num_flag(ii) > 500) && U_t(i,j) ~= 0 
            % fprintf("第%d毫秒,用户%d受到惩罚,Q为%d,总用时L为%d\n",i,j,Q,num_flag(ii));
            n = n + 1;
            chengfadian{n} = [i,j];
        end
    end
    if any(num_flag > 0)
        [iiii] = find(num_flag > 0);
        num_flag(iiii) = num_flag(iiii) - 1;
    end
end
score_list = sum(Q_list <= 100)./10000;  % Q_list
for i = chengfadian
    i = cell2mat(i);
    score_list(i(1),i(2)) = -1;
end
total_score = sum(score_list,"all");

end