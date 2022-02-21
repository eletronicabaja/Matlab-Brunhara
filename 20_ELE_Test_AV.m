clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('D:\Baja\Eletronica\2020\Dados-de-Testes\Teste-de-AV\2021-09-15\setup2.txt');
setupn = 2; %numero do setup

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rot = str2double(string(cell2mat(alldata(:,5:8))));
vel = str2double(string(cell2mat(alldata(:,9:12))));
var0 = str2double(string(cell2mat(alldata(:,9:12))));
var1 = str2double(string(cell2mat(alldata(:,13:16))));
var2 = str2double(string(cell2mat(alldata(:,17:20))));
counter = str2double(string(cell2mat(alldata(:,1:4))));
%=================================================%


%===|Aplica Média Movel nos dados|===%
rot = movmean(rot,16);
vel = movmean(vel,8);
anlg0 = movmean(anlg0,1);
Tobj = movmean(Tobj,1);
dts = movmean(dts,1);
counter = movmean(counter,1);


%===|Plota os Gráficos de Dados|===%
figure('Name','Run');
hold on;
grid on;
plot(rot,'Color',[1,0,0]);
plot(vel,'Color',[0,0,1]);
plot(anlg0,'Color',[0,1,0]);
plot(Tobj,'Color',[0,0.5,0]);
plot(dts,'Color',[1,0,1]);
plot(counter,'Color',[0,0,0]);
hold off;

%% ===|DEFINE POSIÇÃO DO INICIO E FIM DO TESTE|===%
inicio = 12380;
fim = 13000;

%===|Plota o Gráfico de Rot x Vel|===%
figure('Name','Rotação x Velocidade');
hold on;
grid on;
plot(vel(inicio:fim)./100, rot(inicio:fim),'Color',[0,1,0]);

%===|Relação de Transmissão|===%
n_tra=7.6;
r_pneu=21/2*25.4*0.001;
rads_rpm=9.549296585514;
const=n_tra./3.6./(r_pneu)*rads_rpm;


vel_t1=0:15;
vel_t2=0:20;
vel_t3=0:30;
vel_t4=0:60;
rot_t1=vel_t1.*const.*(3.7);
rot_t2=vel_t2.*const.*(2.9);
rot_t3=vel_t3.*const.*(1.9);
rot_t4=vel_t4.*const.*(1.05);

%Plotando retas de relação:
plot(vel_t1,rot_t1)
plot(vel_t2,rot_t2)
plot(vel_t3,rot_t3)
plot(vel_t4,rot_t4)
hoje = datetime('today', 'Format', 'dd/MM/yyyy');

%Labels
ylabel('Rotação (RPM)');
xlabel('Velocidade (Km/h)');
legend('Dados', '3.7','2.9','1.9','1.05');
ylim([2200 4400])
xlim([0 50])
title(sprintf('%s - Setup %d', hoje, setupn))