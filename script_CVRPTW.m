%% Problema de CVRPTW

%% Entrada de datos

dirIni = pwd;
dir = 'C:\Users\nlcjohn\Desktop\VRP\PSolomon';
cd(dir)

% Leo datos del problema
fname = 'rc106';                % archivo de datos
A = importdata(strcat(fname,'.txt'), ' ',9);
v = sscanf(A.textdata{5},'%d');
numeroVehiculos = v(1);
capacidad = v(2);
 

%A.data = A.data(1:45,:); % recorte

nc = A.data(:,1); % n�mero de cliente
x = A.data(:,2); % coordenada x 
y = A.data(:,3); % coordenada y
d = A.data(:,4); % demanda
e = A.data(:,5); % ready time
l = A.data(:,6); % due date
s = A.data(:,7); % service time

fprintf('Problema %5s, Capacidad=%d, N�mero max de veh�culos=%d\n',fname,capacidad,numeroVehiculos)

% Leer datos de la soluci�n
fid = fopen(strcat(fname,'_sol.txt'));
AA = textscan(fid,'%s');
fclose(fid);
BB = AA{1};
nRutas = str2num(BB{2});
u = {};
for i=1:nRutas
   tmp = BB{2+i};
   tmp = textscan(tmp,'%d-');
   t = tmp{1}'+1;
   u{i} = [1 t(1:end-1) 1];
end


% Regreso al directorio original
cd(dirIni)


%% Gr�fica de clientes

delta = -0.5;
clf
dg = 5;
plot(x(1),y(1),'sr',x(2:end),y(2:end),'ob','MarkerSize',12)
xlim([min(x)-dg max(x)+dg])
ylim([min(y)-dg max(y)+dg])
legend('     almacen','      clientes','Location','BestOutside')
xlabel('x')
ylabel('y')
title(sprintf('distribucion de clientes VRP: %s',fname))
hold on
for i=1:length(x)
   text(x(i)+delta,y(i)+delta,sprintf('%2d',nc(i)),'FontSize',8)
end
hold off

%% Gr�fica y evaluaci�n de una soluci�n u

costoVRP(nc,x,y,d,e,l,s,capacidad)
[costo,b,cap,term] = costoVRP(u);
delta = 0.5;
clf
colores = {'m','r','b','k','g'};
formas = {'.','o','x','+','s','d','v','^','p','<','>','h'};
nformas = length(formas);
ncolores = length(colores);
plot(x(1),y(1),'sb', 'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10)
xlim([min(x)-dg max(x)+dg])
ylim([min(y)-dg max(y)+dg])
xlabel('x')
ylabel('y')
title(sprintf('VRP-%s, %d clientes, costo=%f, %d rutas',fname,length(nc)-1,costo,length(u)))
hold on
leg = {};
leg{1} = '     almacen';
for i=1:length(u)
   str = sprintf('%c-%c',formas{mod(i,nformas)+1},colores{mod(i,ncolores)+1});
   plot(x(u{i}),y(u{i}),str,'MarkerSize',6)
   leg{i+1} = sprintf('%2d: (%d) %3d',i,length(u{i})-2,cap(i));
end
plot(x(1),y(1),'sb', 'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',10)
legend(leg,'Location','BestOutside')
for i=1:length(x)
   text(x(i)+delta,y(i)+delta,sprintf('%2d',nc(i)),'FontSize',8)
end
hold off


%% Tabulaci�n de soluci�n 

fprintf('\n')
fprintf('  Costo total: %f\n',costo)
fprintf('Tiempo m�ximo: %f\n',max(term))
fprintf('    Capacidad: %d\n',capacidad)
fprintf('Rutas:\n')
for i=1:length(u)
   
   
   
   fprintf('%3d: (%2d)',i,length(u{i})-2)
   fprintf(' [term=%5.2f,cap=%3d] ',term(i),cap(i))
   fprintf(' %d',nc(u{i}(2:end-1)))
   fprintf('\n')
end
fprintf('\n')

%% Tabulaci�n de clientes procesados

r = zeros(size(e));
for i=2:length(r)
   for j=1:length(u)
      if ~isempty(find(i==u{j},1))
         r(i) = j;
         break
      end
   end
end
cond1 = e<=b; % atender despu�s de ready time
cond2 = b<=l; % atender antes de due date
fprintf('\n')
fprintf(' nc     d       e       b       l   e<=b   b<=l  ruta\n')
for i=2:length(nc)
   fprintf('%3d: %4d %7.0f %7.0f %7.0f %5d %6d %5d\n',...
      nc(i),d(i),e(i),b(i),l(i),cond1(i),cond2(i),r(i))
end



%%


