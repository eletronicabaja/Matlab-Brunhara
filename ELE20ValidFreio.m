clear; clc; close all;

%==|Load data|==%
log = load('D:\Users\SOPA_\Documents\Desktop\Baja\Dados\testTempFrei\2020_02_06_test1.txt');

%==|Index data|==%
counter =log(:,1);
acce.x  =log(:,2);
acce.y  =log(:,3);
acce.z  =log(:,4);
speed	=log(:,5);
strGau	=log(:,6);
brakeP  =log(:,7);
temp    =log(:,8);

%==|Filter data|==%
ff = 24;
speed   = smoothdata(speed./100,	'gaussian',ff);
brakeP  = smoothdata((brakeP * 3.3 / 4096) / 0.0008 / 14.7,...
                                    'gaussian',ff);
temp    = smoothdata(temp,          'gaussian',ff*3);
strGau  = smoothdata(strGau*3.3/4096/504*100000/3.3,...
                                    'gaussian',ff);

%==|Plot data|==%
figure  ('Name',	'Full Log');
hold    on;
grid    on;
yyaxis  left;
plot    (speed,     'LineStyle', '-',...
        'color', [84/255, 151/255, 253/255],...
        'LineWidth', 2);
yyaxis  right;
plot    (brakeP,    'LineStyle', '-',...
        'color', [255/255, 206/255, 10/255],...
        'LineWidth', 2);
plot    (temp,      'LineStyle', '-',...
        'color', [255/255, 0/255, 0/255],...
        'LineWidth', 2);
plot    (strGau,    'LineStyle', '-',...
        'color', [0/255, 0/255, 0/255],...
        'LineWidth', 2);
legend  ('Velocidade [Km/h]', 'Pressão na Linha [Atm]', 'Temperatura [ºC]',...
        'Deformação [10E-3 %]',...
        'Location','northwest');
hold    off;