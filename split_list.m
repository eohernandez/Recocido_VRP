function [r1, list] = split_list(varargin)
%SPLIT_LIST Summary of this function goes here
%   Detailed explanation goes here

    persistent d capacidad
    
    list = {};
    if(length(varargin)>1)
        fprintf('Guardar split\n');
        d = varargin{1};
        capacidad = varargin{2};
        return
    end

    r1 = varargin{1};
    list = {};
    cap = sum(d(r1));
    while (cap > capacidad)
        temp = 0;
        stop = 0;
        for i = 1:length(r1)
            temp = temp + d(r1(i));
            if(temp > capacidad);
                stop = i-1;
                break; 
            end
        end
        
        
        r1_len = length(r1);
        list{length(list)+1} = [r1(1:stop) 1];
        
        r1 = [1 r1(stop+1:r1_len)];
        
        cap = sum(d(r1));
        
    end
    
end

