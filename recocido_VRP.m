%% Problema de la clase, proyeccto

fprintf('START!\n');
%% Leer el archivo

path = 'C:\Users\nlcjohn\Desktop\VRP\PSolomon';
file_name = 'rc106';
[nc, x, y, d, e, l, s, numeroVehiculos, capacidad] = leerInfo_VRP(path, file_name);

costoVRP(nc,x,y,d,e,l,s,capacidad);

vecino_VRP(d, capacidad);

imp_test('imp', file_name, nc,x,y);

% create a list {1, i}
ruta = {};
for i = 2:length(nc-1)
    ruta{i-1} = [1 (nc(i) + 1) 1];
end



%vecino_VRP(ruta);


%{
while(length(ruta) > 34)

    fprintf('ruta: %d\n', length(ruta));
    ruta = vecino_VRP(ruta);
    %
    r2 = ruta;
    while(costoVRP(ruta) < costoVRP(r2))
        r2 = vecino_VRP(r2);
        %fprintf('Better\n');
    end
    ruta = r2;
    
    %
end

grafica_VRP(ruta, file_name, nc, x, y);
tabulacion_VRP(ruta, nc, l, d, e, capacidad);

%}
%
c0 = 200;               % 200
p.cadIntAcep = 300;     % 300
p.cadInt = 500;         % 500
p.maxCad = 5;           % 5
p.alfa = 0.80;        % .9999

p.frecImp = 30;        
p.variarC = 0;
p.x0 = ruta;
p.FcnObj = @costoVRP;         %funcion objetivo costoVRP
p.FcnVec = @vecino_VRP;     %funcion de vecindad Vecino VRP
p.Imp = @imp_test;       %funcion de impresion tabulacionvrp
p.min = 1;

%res = recocido(p,c0);
res = recocido(p,c0);

%

fprintf('end\n');

