function [costo,b,cap,term] = costoVRP(varargin)

% costoVRP(nc,x,y,d,e,l,s,C)
% [costo,b] = costoVRP(sol)

persistent nc x y d e l s D C

if length(varargin)>1
   nc= varargin{1}; % número de cliente
   x = varargin{2}; % coordenada x
   y = varargin{3}; % coordenada y
   d = varargin{4}; % demanda
   e = varargin{5}; % ready time
   l = varargin{6}; % due date
   s = varargin{7}; % service time (no se va a usar)
   C = varargin{8}; % capacidad de los vehículos
   
   % Cálculo de la matriz de distancias
   D = zeros(length(nc));
   for i=1:length(nc)
      for j=i+1:length(nc)
         D(i,j) = norm([x(i) y(i)]-[x(j) y(j)]); %distancia euclidiana
         D(j,i) = D(i,j); % misma distancia
      end
   end  
   return
end
   

% Cálculo de la distancia total recorrida y de tiempo de inicio por cliente
sol = varargin{1};
costo = 0;
term = zeros(length(sol),1);
cap = zeros(length(sol),1);
b = zeros(size(nc));
for nRuta=1:length(sol) % desde 1 hasta el numero de rutas que tengo
   ruta = sol{nRuta}; % extraemos la ruta y la ponemos en ruta
   for ind=2:length(ruta)
      j = ruta(ind);
      i = ruta(ind-1);
      if ind<length(ruta)
         b(j) = max(e(j),b(i)+s(i)+D(i,j)); % maximo del early o (b, cuando comenzaste a atender al anerior, mas el tiempo que te tomo + el tiempo de la distancia al anterior) creo
         costo = costo + D(i,j);
      else
         term(nRuta) = max(e(j),b(i)+s(i)+D(i,j));
      end
   end
   costo = costo + D(ruta(end-1),ruta(end));
   cap(nRuta) = sum(d(ruta));
end

% Falta evaluar que no se violen las siguientes restricciones:
%    b(i) >= e(i)
%    b(i) <= l(i)
%    cap(i) < C
   