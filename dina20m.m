clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('D:\Baja\Eletronica\22\Dados\Dinamometro\2022_02_23\setup1.txt');
setupn = 0; %numero do setup

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rpm = str2double(string(cell2mat(alldata(:,1:4))));
force = str2double(string(cell2mat(alldata(:,5:8))));
counter = str2double(string(cell2mat(alldata(:,9:12))));

%===|Aplica Média Movel nos dados|===%
counter = movmean(counter,1);
rpm = smoothdata(rpm,'gaussian',200);
force = smoothdata(force,'gaussian',2000);

braco = 0.635;

torque = force * braco;
powerKW = torque .* rpm ./ 60000.0;
powerHP = powerKW ./ 0.745699872;

figure ('Name','Dado x Tempo');
plot(counter,'color',[0,0,0]);
hold on;
plot(rpm,'color',[1,0,0]);
plot(force*100,'color',[0,1,0]);
plot(torque*100,'color',[0,0,1]);
plot(powerHP*100,'color',[1,0,0.5]);
plot(powerKW,'color',[1,0,1]);
hold off;

xi = 1391;
xf = 10650;
figure ('Name','Resultado');
hold on;
grid on;
yyaxis left;
plot(rpm(xi:xf),torque(xi:xf)./9.8,'color',[0,0,1],'linewidth',1);
yyaxis right;
plot(rpm(xi:xf), powerHP(xi:xf),'color',[1,0,0],'linewidth',1);
legend('Torque (KgFm)','Potência (HP)','Location','northwest')
hold off;