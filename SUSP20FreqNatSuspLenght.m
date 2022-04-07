clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('D:\Baja\Eletronica\2020\Dados-de-Testes\Susp\Frequencia Natural e Curso de Suspensão\setup1_curva.txt');

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rpm = str2double(string(cell2mat(alldata(:,1:4))));
vel = str2double(string(cell2mat(alldata(:,5:8))));
accel.x = str2double(string(cell2mat(alldata(:,9:13))));
accel.y = str2double(string(cell2mat(alldata(:,14:18))));
accel.z = str2double(string(cell2mat(alldata(:,19:23))));
gyro.x = str2double(string(cell2mat(alldata(:,24:28))));
gyro.y = str2double(string(cell2mat(alldata(:,29:33))));
gyro.z = str2double(string(cell2mat(alldata(:,34:38))));
anlg.a = str2double(string(cell2mat(alldata(:,39:42))));
anlg.b = str2double(string(cell2mat(alldata(:,43:46))));
counter = str2double(string(cell2mat(alldata(:,47:50))));
%=================================================%

%===|Converte e Aplica Média Movel nos dados|===%
mm=16;
rpm = movmean(rpm,mm);
vel = movmean(vel,mm);
accel.x = movmean(((accel.x - 32768)./1672.0),mm);
accel.y = movmean(((accel.y - 32768)./1672.0),mm);
accel.z = movmean(((accel.z - 32768)./1672.0),mm);
gyro.x = movmean(((gyro.x - 32768)./131.0),mm);
gyro.y = movmean(((gyro.y - 32768)./131.0),mm);
gyro.z = movmean(((gyro.z - 32768)./131.0),mm);

%===|Filtragem dos dados|===%
ff = 30;
rpm = smoothdata(rpm,'gaussian',ff/2);
vel = smoothdata(vel,'gaussian',ff/2);
accel.x = smoothdata(accel.x,'gaussian',ff);
accel.y = smoothdata(accel.y,'gaussian',ff);
accel.z = smoothdata(accel.z,'gaussian',ff);
gyro.x = smoothdata(gyro.x,'gaussian',ff);
gyro.y = smoothdata(gyro.y,'gaussian',ff);
gyro.z = smoothdata(gyro.z,'gaussian',ff);
anlg.a = smoothdata(anlg.a,'gaussian',ff);
anlg.b = smoothdata(anlg.b,'gaussian',ff);

susp.a = cosd(180 - (anlg.a) .* 270 ./ 4095);
susp.b = cosd(180 - (anlg.b) .* 270 ./ 4095);
susp.a = sqrt(210^2 + 245^2 - 2 * 210 * 245 * susp.a);
susp.b = sqrt(210^2 + 245^2 - 2 * 210 * 245 * susp.b);

%===|Plota os Gráficos de Dados|===%
figure('Name','All Data');
hold on;
grid on;
plot(counter,'Color',[0,0,0]);
plot(rpm, 'Color', [1,0,0]);
plot(vel, 'Color', [0,0,1]);
plot(accel.x);
plot(accel.y);
plot(accel.z);
plot(gyro.x);
plot(gyro.y);
plot(gyro.z);
plot(anlg.a);
plot(anlg.b);
legend('Counter', 'RPM', 'Velocidade', 'Acel X', 'Acel y', 'Acel Z', 'Gyro X', 'Gyro Y', 'Gyro Z', 'Anlg A', 'Anlg B', 'Location','northwest');
hold off;

%% 
%===|Plota os Gráficos de Dados Separados|===%
figure('Name','Data Boxes');
subplot(2,2,1);
hold on;
grid on;
yyaxis left;
plot(rpm);
ylabel('RPM');
yyaxis right;
plot(vel./100);
ylabel('Km/H');
yyaxis left;
title('Velocidade e Rotação');
legend('Rotação', 'Velocidade', 'Location','northwest');
hold off;

subplot(2,2,2);
hold on;
grid on;
plot(accel.x);
plot(accel.y);
plot(accel.z);
ylabel('m/s²');
title('Acelerometro');
legend('Acel X', 'Acel Y', 'Acel Z', 'Location','northwest');
hold off;

subplot(2,2,3);
hold on;
grid on;
plot(gyro.x);
plot(gyro.y);
plot(gyro.z);
ylabel('°/s');
title('Giroscopio');
legend('Gyro X', 'Gyro Y', 'Gyro Z', 'Location','northwest');
hold off;

subplot(2,2,4);
hold on;
grid on;
plot(susp.a);
plot(susp.b);
title('Curso de Suspensão');
legend('Traseira', 'Dianteira', 'Location', 'northwest');
hold off;

figure('Name', 'Aceleração Vertical');
hold on;
grid on;
plot( (1:length(accel.z)) .* 12.5 ./1000, accel.z, 'Color',[0.7,0.7,0]);
ylabel('m/s²');
xlabel('segundos');
title('Aceleração na Cabeça do Piloto');
hold off;

%% 
inicio  = 3881;
fim     = 4723;

figure('Name', 'Validação da Suspensão');
subplot(2,2,2);
hold on;
grid on;
plot(accel.x(inicio:fim));
plot(accel.y(inicio:fim));
plot(accel.z(inicio:fim));
ylabel('m/s²');
yyaxis right;
plot(gyro.x(inicio:fim), 'LineStyle', ':');
plot(gyro.y(inicio:fim), 'LineStyle', ':');
plot(gyro.z(inicio:fim), 'LineStyle', ':');
ylabel('°/s');
title('Acelerometro & Giroscópio');
legend('Acel X', 'Acel Y', 'Acel Z', 'Gyro X', 'Gyro Y', 'Gyro Z', 'Location','northwest');
hold off;

subplot(2,2,4);
hold on;
grid on;
plot(susp.a(inicio:fim));
plot(susp.b(inicio:fim));
title('Curso de Suspensão');
legend('Traseira', 'Dianteira', 'Location', 'northwest');
hold off;