function [ r1, r2 ] = relocate_operator( r1, r2 )
%RELOCATE_OPERATOR Summary of this function goes here
%   Detailed explanation goes here
    r1_len = length(r1);
    r2_len = length(r2);
    
   if(r1_len > 3 && r2_len > 3)
        num1 = randi([2,r1_len-1]);
        num2 = randi([2,r2_len-1]);
        
        tmp = r1(num1);
        r1 = [r1(1:num1-1) r2(num2) r1(num1+1:r1_len)];
        r2 = [r2(1:num2-1) tmp r2(num2+1:r2_len)];
    end

end

