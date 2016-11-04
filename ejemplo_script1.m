
% Minimización usando RS

c0 = 300;               % 200
p.cadIntAcep = 300;     % 300
p.cadInt = 500;         % 500
p.maxCad = 5;           % 5
p.alfa = 0.9999;        % .9999

p.frecImp = 30;        
p.variarC = 0;
p.x0 = [0 0]';
p.FcnObj = @f1;         %funcion objetivo costoVRP
p.FcnVec = @vecino;     %funcion de vecindad Vecino VRP
p.Imp = @imprime;       %funcion de impresion tabulacionvrp
p.min = 1;

res = recocido(p,c0);

Graficar

