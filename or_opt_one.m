function [route1] = or_opt_one(route1)

    r_len = length(route1);
    if (r_len == 4)
        
        route1 = [route1(1) route1(3) route1(2) route1(4) ];
        
    elseif(r_len > 4)                
        win_size = randi([2, r_len - 3]);
        
        displacement = 0;
        if((r_len - 3) > win_size)
            displacement = randi([0,(r_len -2) - win_size]);
        end
        %fprintf('displacement %d winsize %d\n', displacement, win_size);
        %chaca chaca
        start = 2 + displacement;
        last = displacement + win_size;
    
        %fprintf('start %d end %d\n', start, last);
        
        t_route = [route1(1:start-1) route1(last+1:r_len)];
        ran_num = randi([1, length(t_route)-1]);
       
        sub_route = route1(start:last);
        
        route1 = [t_route(1:ran_num) sub_route t_route(ran_num+1:length(t_route))];

    end
end

