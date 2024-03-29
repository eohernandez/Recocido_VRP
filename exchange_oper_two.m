function [ r1, r2 ] = exchange_oper_two( r1, r2 )
%EXCHANGE_OPER_TWO Summary of this function goes here
%   Detailed explanation goes here

    r1_len = length(r1);
    r2_len = length(r2);
    
    
    if(r1_len == 3 || r2_len == 3)
        
        if(r1_len > r2_len)
            r1 = [r1(1:r1_len-1) r2(2) r1(r1_len)];
            r2 = [1 1];
        else
            
            r2 = [r2(1:r2_len-1) r1(2) r2(r2_len)];
            r1 = [1 1];
        end
        
        
    elseif(r1_len > 3 && r2_len > 3)
        
        r1  = r1(2:r1_len-1);
        r2  = r2(2:r2_len-1);
        
        %prepare r1
        r1_len = length(r1);
        
        win_size1 = randi([1,r1_len-1]);
        disp_max = (r1_len - win_size1);
        
        move1 = randi([1,disp_max]);
        
        r1_p = r1(move1:move1 + win_size1);
        r1_1 = r1(1:move1-1);
        r1_2 = r1(move1 + win_size1+1:r1_len);
        
        %prepare r2
        r2_len = length(r2);
        
        win_size2 = randi([1,r2_len-1]);
        disp_max2 = (r2_len - win_size2);
        
        move2 = randi([1,disp_max2]);
        
        r2_p = r2(move2: move2+ win_size2);
        r2_1 = r2(1:move2-1);
        r2_2 = r2(move2 + win_size2+1:r2_len);
        
        r1 = [1 r1_1 r2_p r1_2 1];
        r2 = [1 r2_1 r1_p r2_2 1];

    end

end



%{

 win_size1 = randi([2, r1_len - 2]);
        %if there is space to move the window
        displacement1 = 0;
        if((r1_len - 2) > win_size1)
            displacement1 = randi([0, ((r1_len-1) - win_size1)]);
        end
        
        win_size2 = randi([2, r2_len - 2]);
        %if there is space to move the window
        displacement2 = 0;
        if((r2_len - 2) > win_size2)
            displacement2 = randi([0, ((r2_len-1) - win_size2)]);
        end
        
        s1 = 2 + displacement1;
        l1 = displacement1 + win_size1;
        
        s2 = 2 + displacement2;
        l2 = displacement2 + win_size2;
        
        sub1 = r1(s1:l1);
        sub2 = r2(s2:l2);
        
        r1 = [r1(1:s1-1) sub2 r1(s1+1:r1_len)];
        r2 = [r2(1:s2-1) sub1 r2(s2+1:r2_len)];

%}
