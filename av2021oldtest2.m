clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('C:\Users\SOPA_\Desktop\file003.txt');

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rot = str2double(string(cell2mat(alldata(:,1:4))));
vel = str2double(string(cell2mat(alldata(:,5:8))));
anlg0 = str2double(string(cell2mat(alldata(:,9:12))));
anlg1 = str2double(string(cell2mat(alldata(:,13:16))));
tempAmb = str2double(string(cell2mat(alldata(:,17:20))));
tempObj = str2double(string(cell2mat(alldata(:,21:24))));
%=================================================%


%===|Aplica Média Movel nos dados|===%
rot = movmean(rot,16);
vel = movmean(vel,8);
anlg0 = movmean(anlg0,1);
anlg1 = movmean(anlg1,1);
tempAmb = movmean(tempAmb,1);
tempObj = movmean(tempObj,1);


%===|Plota os Gráficos de Dados|===%
figure('Name','Run');
hold on;
plot(rot,'Color',[1,0,0]);
plot(vel,'Color',[0,0,1]);
plot(anlg0,'Color',[0,1,0]);
plot(anlg1,'Color',[0,0.5,0]);
plot(tempAmb,'Color',[1,0,1]);
plot(tempObj,'Color',[1,0,0.5]);
hold off;

%===|DEFINE POSIÇÃO DO INICIO E FIM DO TESTE|===%
inicio = 1000;
fim = 1400;

%===|Plota o Gráfico de Rot x Vel|===%
figure('Name','Rot x Vel');
hold on;
plot(vel(inicio:fim)./100, rot(inicio:fim),'Color',[1,0,0]);
hold off;