
function [nc,x,y,d,e,l,s, numeroVehiculos, capacidad] = leerInfo_VRP(path, name)

dirIni = pwd;
dir = path; %'C:\Users\nlcjohn\Desktop\VRP\PSolomon';
cd(dir)

% Leo datos del problema
fname = name;                % archivo de datos
A = importdata(strcat(fname,'.txt'), ' ',9);
v = sscanf(A.textdata{5},'%d');
numeroVehiculos = v(1);
capacidad = v(2);
 

%A.data = A.data(1:45,:); % recorte

nc = A.data(:,1); % número de cliente
x = A.data(:,2); % coordenada x 
y = A.data(:,3); % coordenada y
d = A.data(:,4); % demanda
e = A.data(:,5); % ready time
l = A.data(:,6); % due date
s = A.data(:,7); % service time

fprintf('Problema %5s, Capacidad=%d, Número max de vehículos=%d\n',fname,capacidad,numeroVehiculos)

% Regreso al directorio original
cd(dirIni)
