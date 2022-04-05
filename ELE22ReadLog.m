clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('D:\Baja\Eletronica\22\Dados\Setup Susp\2022_04_02\file001.txt');

%===|Converte os dados do arquivo em Variaveis|===%
d           = textscan(fid,'%s');
data        = cat(1,d{:});
dataexpand 	= cellfun(@num2cell,data,'UniformOutput',false);
alldata     = cat(1,dataexpand{:});

counter     = hex2dec(string(cell2mat(alldata(:,73:76))));
rpm         = hex2dec(string(cell2mat(alldata(:,1:4))));
vel         = hex2dec(string(cell2mat(alldata(:,5:8))));
fuel        = hex2dec(string(cell2mat(alldata(:,9:11))));
bat         = hex2dec(string(cell2mat(alldata(:,12:14))));
volante     = hex2dec(string(cell2mat(alldata(:,15:17))));
pedal       = hex2dec(string(cell2mat(alldata(:,18:20))));
acce.x      = hex2dec(string(cell2mat(alldata(:,21:24))));
acce.y      = hex2dec(string(cell2mat(alldata(:,25:28))));
acce.z      = hex2dec(string(cell2mat(alldata(:,29:32))));
gyro.x      = hex2dec(string(cell2mat(alldata(:,33:36))));
gyro.y      = hex2dec(string(cell2mat(alldata(:,37:40))));
gyro.z      = hex2dec(string(cell2mat(alldata(:,41:44))));
magn.x      = hex2dec(string(cell2mat(alldata(:,45:48))));
magn.y      = hex2dec(string(cell2mat(alldata(:,49:52))));
magn.z      = hex2dec(string(cell2mat(alldata(:,53:56))));
gps.lat     = hex2dec(string(cell2mat(alldata(:,57:64))));
gps.lon     = hex2dec(string(cell2mat(alldata(:,65:72))));
%=================================================%

%===|Calculos Adicionais|===%
acce.x = (65535 - gyro.x)./1672.0;
acce.y = (65535 - gyro.y)./1672.0;
acce.z = (65535 - gyro.z)./1672.0;
gyro.x = (65535 - gyro.x)./131.0;
gyro.y = (65535 - gyro.y)./131.0;
gyro.z = (65535 - gyro.z)./131.0;

ff      = 20;
rpm     = smoothdata(rpm,'gaussian',ff);
vel     = smoothdata(vel,'gaussian',ff);
fuel    = smoothdata(fuel,'gaussian',ff*5);
bat     = smoothdata(bat,'gaussian',ff*5);
volante = smoothdata(volante,'gaussian',ff);
pedal   = smoothdata(pedal,'gaussian',ff);

acce.x = smoothdata(acce.x,'gaussian',ff);
acce.y = smoothdata(acce.y,'gaussian',ff);
acce.z = smoothdata(acce.z,'gaussian',ff);
gyro.x = smoothdata(gyro.x,'gaussian',ff);
gyro.y = smoothdata(gyro.y,'gaussian',ff);
gyro.z = smoothdata(gyro.z,'gaussian',ff);
%===========================%

figure ('Name', 'All Data')
hold on;
plot(counter);
plot(rpm);
plot(vel);
plot(bat);
plot(volante);
plot(pedal);
plot(acce.x);
plot(acce.y);
plot(acce.z);
plot(gyro.x);
plot(gyro.y);
plot(gyro.z);
plot(magn.x);
plot(magn.y);
plot(magn.z);
hold off;

figure('Name', 'GPS');
hold on;
plot(gps.lon, gps.lat);
hold off;

%% 
figure ('Name', 'AV');
hold on;
plot (rpm, 'red');
yyaxis right;
plot (vel./100, 'blue');
hold off;

figure ('Name', 'CVT');
hold on;
plot (vel./100, rpm);
hold off;

%% 
figure ('Name', 'Accel & Gyro')
hold on;
plot (acce.x, 'red', 'LineStyle', '-');
plot (acce.y, 'green', 'LineStyle', '-');
plot (acce.z, 'blue', 'LineStyle', '-');
yyaxis right;
plot (gyro.x, 'red', 'LineStyle', '--');
plot (gyro.y, 'green', 'LineStyle', '--');
plot (gyro.z, 'blue', 'LineStyle', '--');
hold off;