%===|Abre o arquivo|===
fid = fopen('C:\Users\SOPA_\Desktop\setup12.txt');

%===|Converte em String|===
d = textscan(fid,'%s');  
fclose(fid);
dados = d{1,1};

%===|Converte a String em Dados|===
 for i=1:length(dados)
     dados{i,1} = split(dados{i,1},"");
     dados{i,2} = str2double(sprintf('%s%s%s%s',dados{i,1}{6,1}, dados{i,1}{7,1}, dados{i,1}{8,1}, dados{i,1}{9,1}));
     dados{i,3} = str2double(sprintf('%s%s%s%s',dados{i,1}{10,1}, dados{i,1}{11,1}, dados{i,1}{12,1}, dados{i,1}{13,1}));
     dados{i,4} = str2double(sprintf('%s%s%s%s',dados{i,1}{14,1}, dados{i,1}{15,1}, dados{i,1}{16,1}, dados{i,1}{17,1}));
     dados{i,5} = str2double(sprintf('%s%s%s%s',dados{i,1}{18,1}, dados{i,1}{19,1}, dados{i,1}{20,1}, dados{i,1}{21,1}));
     dados{i,6} = str2double(sprintf('%s%s%s%s',dados{i,1}{22,1}, dados{i,1}{23,1}, dados{i,1}{24,1}, dados{i,1}{25,1}));
     dados{i,1} = str2double(sprintf('%s%s%s%s',dados{i,1}{2,1}, dados{i,1}{3,1}, dados{i,1}{4,1}, dados{i,1}{5,1}));
 end
 
 dados = cell2mat(dados);
 
%===|Salva os Dados em Variaveis|===
rot = dados(:,1);
vel = dados(:,2);
anlg0 = dados(:,3);
anlg1 = dados(:,4);
tempAmb = dados(:,5);
tempObj = dados(:,6);

figure('Name','Run');
hold on;
plot(rot,'Color',[1,0,0]);
plot(vel,'Color',[0,0,1]);
plot(anlg0,'Color',[0,1,0]);
plot(anlg1,'Color',[0,0.5,0]);
plot(tempAmb,'Color',[1,0,1]);
plot(tempObj,'Color',[1,0,0.5]);
hold off;

%===|DEFINE POSIÇÃO DO INICIO E FIM DO TESTE|===
inicio = 1000;
fim = 1400;

figure('Name','Vel x Rot');
hold on;
plot(vel(inicio:fim), rot(inicio:fim),'Color',[1,0,0]);
hold off;