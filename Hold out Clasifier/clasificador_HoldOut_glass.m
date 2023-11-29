clc % borra pantalla
clear all  % limpia todo
close all % cierra todo
warning off all % apaga las advertencias

c = readtable('glass_train.csv');
c = table2array(c(:,2:11));
c1 = c(1:50,:);
c2 = c(51:107,:);
c3 = c(108:117,:);
c5 = c(118:124,:);
c6 = c(125:131,:);
c7 = c(132:149,:);
acertados = 0;
errados  = 0;

pruebas = readtable('glass_test.csv');
pruebas = table2array(pruebas);

for x = 1:65;
    vectorP = pruebas(x,2:11);
    media1 = mean(c1,10);
    media2 = mean(c2,10);
    media3 =mean(c3,10);
    media5 =mean(c5,10);
    media6 =mean(c6,10);
    media7 =mean(c7,10);
    
    distancia1 = norm(vectorP-media1);
    distancia2 = norm(vectorP-media2);
    distancia3 = norm(vectorP-media3);
    distancia4 = 1000000;
    distancia5 = norm(vectorP-media5);
    distancia6 = norm(vectorP-media6);
    distancia7 = norm(vectorP-media7);
    
    distancias=[distancia1,distancia2,distancia3,distancia4,distancia5,distancia6,distancia7];
    
    minimo = min(distancias);
    
    dato=find(distancias == minimo);

    if dato == pruebas(x);
        acertados = acertados + 1;
    else
        errados = errados + 1;
    end
end

accuracy = (acertados*100)/65;
fprintf("el clasificador tiene un accuracy de %.2f porciento \n", accuracy);
