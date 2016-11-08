%% Problema de la clase, proyeccto

fprintf('START!\n');
%% Leer el archivo

path = 'C:\Users\nlcjohn\Desktop\VRP\PSolomon';
file_name = 'rc102';
[nc, x, y, d, e, l, s, numeroVehiculos, capacidad] = leerInfo_VRP(path, file_name);

costoVRP(nc,x,y,d,e,l,s,capacidad);

vecino_VRP(d, capacidad);
split_list(d, capacidad);

imp_test('imp', file_name, nc,x,y);


%crea una lista con una sola ruta
ruta = {};
ruta {1} = [1];
for i = 2:length(nc)-1
    ruta{1} = [ruta{1} (nc(i) + 1)];
end
ruta{1} = [ruta{1} 1];


% se generan distintas rutas de acuerdo a la descripcion 
[r2, list] = split_list(ruta{1});

ruta(1) = [];
for i = 1:length(list)
    if(length(list{i}) > 2)
        ruta{length(ruta) + 1} = list{i};
    end
end


c0 = 50;               % 200
p.cadIntAcep = 500;     % 300
p.cadInt = 1000;         % 500
p.maxCad = 7;           % 5
p.alfa = 0.20;        % .95
p.frecImp = 250;     % 30    

p.variarC = 0;
p.x0 = ruta;
p.FcnObj = @costoVRP;         %funcion objetivo costoVRP
p.FcnVec = @vecino_VRP;     %funcion de vecindad Vecino VRP
p.Imp = @imp_test;       %funcion de impresion tabulacionvrp
p.min = 1;

res = recocido(p,c0);

%n = 20;
%plotRecocido(p,n,c0)

%

fprintf('end\n');

