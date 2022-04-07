clear; clc; close all;

%==|Load data|==%
log = load('D:\Users\SOPA_\Documents\Desktop\Baja\Dados\testTempFrei\2020_02_06_test1.txt');

%==|Index data|==%
counter =log(:,1);
speed   =log(:,5);
rpm     =log(:,8);

%==|Plot data|==%
figure  ('Name',	'Full Log');
hold    on;
grid    on;
%plot    (counter,   'Black');
plot    (speed,     'Blue');
plot    (rpm,       'Red');
hold    off;