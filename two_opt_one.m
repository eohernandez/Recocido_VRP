function [route1] = two_opt_one(route1)
%2-OPT Summary of this function goes here
%   Detailed explanation goes here
    if(length(route1) > 2 )                
        temp1 = randi([2, length(route1) - 1]);
        temp2 = randi([2, length(route1) - 1]);
        
        min_num = min(temp1, temp2);
        max_num = max(temp1, temp2);
        
        route1(min_num:max_num) = route1(max_num:-1:min_num);
        
    end
end

