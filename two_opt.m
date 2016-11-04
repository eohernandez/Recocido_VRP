function [route1, route2] = two_opt(route1, route2)
%2-OPT Summary of this function goes here
%   Detailed explanation goes here
    if(length(route1) > 2 && length(route2) > 2)
        min_num = min(length(route1),length(route2));
        win_size = randi([2, min_num - 2]);
        
        %if there is space to move the window
        displacement = 0;
        if((min_num - 2) > win_size)
            displacement = randi([0, ((min_num-1) - win_size)]);
        end
        
        %fprintf('displacement %d winsize %d\n', displacement, win_size);
        %chaca chaca
        start = 2 + displacement;
        last = displacement + win_size;
    
        %fprintf('start %d end %d\n', start, last);
        temp = route1(start:last);
        route1(start:last) = route2(start:last);
        route2(start:last) = temp;
        return
    end
end

