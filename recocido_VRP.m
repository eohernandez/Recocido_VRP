%% Problema de la clase, proyeccto

fprintf('START!\n');
%% Leer el archivo

path = 'C:\Users\nlcjohn\Desktop\VRP\PSolomon';
file_name = 'rc106';
[nc, x, y, d, e, l, s, numeroVehiculos, capacidad] = leerInfo_VRP(path, file_name);

costoVRP(nc,x,y,d,e,l,s,capacidad);

vecino_VRP(d, capacidad);

% create a list {1, i}
ruta = {};
for i = 2:length(nc-1)
    ruta{i-1} = [1 (nc(i) + 1) 1];
end

vecino_VRP(ruta);


while(length(ruta) > 14)
    fprintf('ruta: %d\n', length(ruta));
    ruta = vecino_VRP(ruta);
    r2 = ruta;
    while(costoVRP(ruta) > costoVRP(r2))
        ruta = vecino_VRP(ruta);
    end
    ruta = r2;
end

%{
c0 = 300;               % 200
p.cadIntAcep = 300;     % 300
p.cadInt = 500;         % 500
p.maxCad = 5;           % 5
p.alfa = 0.9999;        % .9999

p.frecImp = 30;        
p.variarC = 0;
p.x0 = [0 0]';
p.FcnObj = @costoVRP;         %funcion objetivo costoVRP
p.FcnVec = @vecino_VRP;     %funcion de vecindad Vecino VRP
p.Imp = @tabulacion_VRP;       %funcion de impresion tabulacionvrp
p.min = 1;

res = recocido(p,c0);

%}

grafica_VRP(ruta, file_name, nc, x, y);
tabulacion_VRP(ruta, nc, l, d, e, capacidad);