function ruta = vecino_VRP(varargin)

persistent d capacidad

if(length(varargin)>1)
    fprintf('Guardar variables persistentes\n');
    d = varargin{1};
    capacidad = varargin{2};
    return
end

%fprintf('Fijar limites en vecino\n');

ruta = varargin{1};


%CHACA CHACA

one_two = randi([1,2]);

if(one_two == 1)
    
    ran_num = randi([2, length(ruta)]);
    
    while (sum(d(ruta{ran_num})) == 0)
        ran_num = randi([2, length(ruta)]);
    end
    
    r1 = ruta{ran_num};
 
    selector = randi([1,2]);
    
    if(selector == 1)
        r1 = two_opt_one(r1);
    elseif(selector == 2)
        r1 = or_opt_one(r1);
    end
    
    ruta{ran_num} = r1;
    
    if(length(r1) <= 2)
        ruta{ran_num} = [];
    end
    
    %check truck overflow

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
        
        % create new route
        
        new_route = [r1(1:stop) 1];
        ruta{length(ruta)+ 1} = new_route;
        
        r1 = [1 r1(1:stop)];
        cap = sum(d(r1));
        
    end
    
    
else

    ran_num = randi([2, length(ruta)]);
    
    while (sum(d(ruta{ran_num})) == 0)
        ran_num = randi([2, length(ruta)]);
    end
    r1 = ruta{ran_num};
    
    
    
    ran_num2 = randi([2, length(ruta)]);
    
    while (sum(d(ruta{ran_num2})) == 0)
        ran_num2 = randi([2, length(ruta)]);
    end
    r2 = ruta{ran_num2};
    
    
    selector = randi([1,1]);
    
    
    if(selector == 1)
        [r1, r2] = relocate_operator(r1, r2);
    elseif(selector == 2)
        [r1, r2] = exchange_oper_two(r1, r2);   % ERROR
    elseif(selector == 3)
        [r1, r2] = two_opt(r1,r2);    % ERROR
    end

    
    % assign back
    
    
    ruta{ran_num} = r1;
    
    if(length(r1) <= 2)
        ruta{ran_num} = [];
    end
    
    ruta{ran_num2} = r2;
    
    if(length(r2) <= 2)
        ruta{ran_num2} = [];
    end
    
    %%check truck overflow
    
    
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
        
        % create new route
        
        new_route = [r1(1:stop) 1];
        ruta{length(ruta)+ 1} = new_route;
        
        r1 = [1 r1(1:stop)];
        cap = sum(d(r1));
        
    end
    
    
    cap = sum(d(r2));
    while (cap > capacidad)
        temp = 0;
        stop = 0;
        for i = 1:length(r2)
            temp = temp + d(r2(i));
            if(temp > capacidad);
                stop = i-1;
                break; 
            end
        end
        
        % create new route
        
        new_route = [r2(1:stop) 1];
        ruta{length(ruta)+ 1} = new_route;
        
        r2 = [1 r2(1:stop)];
        cap = sum(d(r2));
        
    end
    
end

