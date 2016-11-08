function ruta = vecino_VRP(varargin)

persistent d capacidad

if(length(varargin)>1)
    fprintf('Guardar variables persistentes\n');
    d = varargin{1};
    capacidad = varargin{2};
    %split_list(d, capacidad);
    return
end

%fprintf('Fijar limites en vecino\n');

ruta = varargin{1};


%CHACA CHACA

one_two = randi([1,2]);

if(one_two == 1)
    %fprintf('ONE\n');
    
    ran_num = randi([1, length(ruta)]);
    
    while (sum(d(ruta{ran_num})) == 0)
        ran_num = randi([1, length(ruta)]);
    end
    
    r1 = ruta{ran_num};
 
    selector = randi([1,2]);
    
    if(selector == 1)
        %fprintf('two opt one\n');
        r1 = two_opt_one(r1);
        
    elseif(selector == 2)
        %fprintf('or opt one\n');
        r1 = or_opt_one(r1);
    end
    
    ruta{ran_num} = r1; 
    
    
else

    %fprintf('TWO\n');

    ran_num = randi([1, length(ruta)]);
    
    while (sum(d(ruta{ran_num})) == 0)
        ran_num = randi([1, length(ruta)]);
    end
    r1 = ruta{ran_num};
    
    
    
    ran_num2 = randi([2, length(ruta)]);
    
    while (sum(d(ruta{ran_num2})) == 0 || ran_num == ran_num2)
        ran_num2 = randi([2, length(ruta)]);
    end
    r2 = ruta{ran_num2};
    
    
    selector = randi([1,3]);
    
    
    if(selector == 1)
        %fprintf('relocate operator\n');
        [r1, r2] = relocate_operator(r1, r2);
    elseif(selector == 2)
        %fprintf('exchange operator\n');
        [r1, r2] = exchange_oper_two(r1, r2);
    elseif(selector == 3)
        %fprintf('two opt two\n');
        [r1, r2] = two_opt(r1,r2);
    end

    
    % assign back
    
   
    %%check truck overflow
    
    if(sum(d(r1)) > capacidad)
        
        %fprintf('split list r1 2\n');
        [r1, list] = split_list(r1);
        for i = 1:length(list)
            if(length(list{i}) > 2)
                ruta{length(ruta) + 1} = list{i};
            end
        end

    end  
    
    if(sum(d(r2)) > capacidad)
        
         %fprintf('split list r2 2\n');

        [r2, list] = split_list(r2);
        for i = 1:length(list)
            if(length(list{i}) > 2)
                ruta{length(ruta) + 1} = list{i};
            end
        end

    end
    
    
     if(length(r1) <= 2)
        ruta(ran_num) = [];
        if(ran_num < ran_num2)
            ran_num2 = ran_num2 - 1;
        end
        
    else
       ruta{ran_num} = r1; 
    end
        
    if(length(r2) <= 2)
        ruta(ran_num2) = [];
    else
        ruta{ran_num2} = r2;
    end
    
    
end

