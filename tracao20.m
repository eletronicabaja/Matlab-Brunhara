clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('D:\Baja\Eletronica\2020\Dados-de-Testes\Transmissao\Teste Traçcao 21-12-18\file000.txt');

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rpm = str2double(string(cell2mat(alldata(:,1:4))));
vel = str2double(string(cell2mat(alldata(:,5:8))));
fc.a = str2double(string(cell2mat(alldata(:,9:12))));
fc.b = str2double(string(cell2mat(alldata(:,13:16))));
counter = str2double(string(cell2mat(alldata(:,17:20))));
%=================================================%

%===|Converte e Aplica Média Movel nos dados|===%
mm=8;
rpm = movmean(rpm,mm);
vel = movmean(vel,mm);
fc.a = movmean(fc.a,mm);
fc.b = movmean(fc.b,mm);

%===|Filtragem dos dados|===%
ff = 10;
rpm = smoothdata(rpm,'gaussian',ff);
fc.a = smoothdata(fc.a,'gaussian',ff);
fc.b = smoothdata(fc.b,'gaussian',ff);

%===|Plota os Gráficos de Dados|===%
figure('Name','All Data');
hold on;
grid on;
plot(counter,'Color',[0,0,0]);
plot(rpm, 'Color', [1,0,0]);
plot(vel, 'Color', [0,0,1]);
plot(fc.a);
plot(fc.b);
hold off;