function [total_score,L_list] = t2_U_score_100ms(k,num,U_t)

U_t = U_t;

    num_flag = zeros(num,1);
    L_list = zeros(100,2);
    for i = 1:100
        for j = 1:size(U_t,2)
            [iii,ii] = min(num_flag);
            Q = ceil(num_flag(ii));
            num_flag(ii) = U_t(i,j) + ceil(num_flag(ii));
            L_list(i,j) = num_flag(ii);
            if any(num_flag(ii) > 5) && U_t(i,j) ~= 0 
                % fprintf("第%d毫秒,用户%d受到惩罚,Q为%d毫秒,总用时L为%.6f毫秒\n",i,j,Q,num_flag(ii));
            end
        end
        if any(num_flag > 0)
            [iiii] = find(num_flag > 0);
            num_flag(iiii) = num_flag(iiii) - 1;
        end
    end

L_list;
score_list = 0.95.^L_list;
score_list(score_list < 0.95^5) = -5;
total_score = sum(score_list,"all");


end