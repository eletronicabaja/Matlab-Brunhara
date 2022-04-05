clear; clc; close all;

data=load('D:\Users\SOPA_\Documents\Desktop\Baja\Dados\ENDURO_INDOOR\25_01_2020_endF.txt');

%===|Converte os dados do arquivo em Variaveis|===%
counter = data(:,1);
freio = data(:,2);
accel.a = data(:,3);
accel.b = data(:,4);
accel.c = data(:,5);
vel = data(:,6);
rpm = data(:,7);
% lat = data(:,8)*10000+data(:,9);
% long = data(:,10)*10000+data(:,11);
lat = data(:,9);
long = data(:,11);
dire = data(:,12);
dat13 = data(:,13);

%===|Filtragem dos dados|===%
ff = 30;
aff = 50;
rpm = smoothdata(rpm,'gaussian',ff);
vel = smoothdata(vel,'gaussian',ff);
dire = smoothdata(dire,'gaussian',ff);
accel.a = smoothdata(accel.a,'gaussian',aff);
accel.b = smoothdata(accel.b,'gaussian',aff);
accel.c = smoothdata(accel.c,'gaussian',aff);
freio = smoothdata(freio,'gaussian',1);

gff = 2;
lat = smoothdata(lat,'gaussian',gff);
long = smoothdata(long,'gaussian',gff);

%===|Plota os Gráficos de Dados|===%
figure('Name','All Data');
hold on;
grid on;
plot(vel, 'color', [0, 0, 1]);
plot(rpm, 'color', [1, 0, 0]);
plot(freio);
plot(accel.a);
plot(accel.b);
plot(accel.c);
plot(dire);
plot(dat13);
legend('Velocidade', 'Rotação', 'Freio', 'Acel ?', 'Acel ?', 'Acel ?', 'Esterço', '?');
hold off;

inicio = 8000;
fim = 73000;

figure('Name','GPS');
hold on;
grid on;
plot(long(inicio:fim), lat(inicio:fim), 'color', [0, 0, 0], 'LineWidth', 2);
hold off;

%% 
figure('Name', 'Histograma de Velocidade');
hold on;
grid on;
histogram(vel(inicio:fim)./100, 'FaceColor', [39/255, 39/255, 61/255], 'EdgeColor', [39/255, 39/255, 61/255]);
title('\fontsize{32}Histograma de Velocidade em Pista');
xlabel('\fontsize{20}Km/H')
hold off;

%% 
figure('Name','Pontos de Frenagem');
hold on;
grid on;
z = zeros(size(lat(inicio:fim)));
c = freio(inicio:fim);
surface([long(inicio:fim), long(inicio:fim)],...
        [lat(inicio:fim), lat(inicio:fim)],... 
        [z,z],...
        [c,c],...
        'facecolor','none','edgecolor','interp',...
        'linewidth',3);   
map = [
    24/255 94/255 246/255
    255/255 0/255 0/255
    255/255 0/255 0/255
    ];
colormap(map);
%colorbar;
title('\fontsize{32}Pontos de Frenagem em Pista');
hold off;

%% 
figure('Name','Velocidade em Pista');
hold on;
grid on;
z = zeros(size(lat(inicio:fim)));
c = vel(inicio:fim)./100;
surface([long(inicio:fim), long(inicio:fim)],...
        [lat(inicio:fim), lat(inicio:fim)],... 
        [accel.b(inicio:fim),accel.b(inicio:fim)],...
        [c,c],...
        'facecolor','none','edgecolor','interp',...
        'linewidth',3);   
map = zeros(100,3);
map(:,1) = linspace(39/255,255/255);
map(:,2) = linspace(39/255,200/255);
map(:,3) = linspace(61/255,11/255);
colormap(map);
cbar = colorbar;
cbar.Label.String = 'Velocidade (Km/h)';
cbar.Label.FontSize = 16;
cbar.FontSize = 18;
title('\fontsize{32}Velocidade em Pista');
hold off;