clc % borra pantalla
clear all  % limpia todo
close all % cierra todo
warning off all % apaga las advertencias

c = readtable('iris_train.csv');
c = table2array(c(:,2:5));
c1 = c(1:37,:);
c2 = c(37:74,:);
c3 = c(74:105,:);
acertados = 0;
errados  = 0;

pruebas = readtable('iris_test.csv');
pruebas = table2array(pruebas);

for x = 1:45;
    vectorP = pruebas(x,2:5);
    media1 = mean(c1,4);
    media2 = mean(c2,4);
    media3 =mean(c3,4);
    
    distancia1 = norm(vectorP-media1);
    distancia2 = norm(vectorP-media2);
    distancia3 = norm(vectorP-media3);
    
    distancias=[distancia1,distancia2,distancia3];
    
    minimo = min(distancias);
    
    dato=find(distancias == minimo);

    if dato == pruebas(x);
        acertados = acertados + 1;
    else
        errados = errados + 1;
    end
end

accuracy = (acertados*100)/45;
fprintf("el clasificador tiene un accuracy de %.2f porciento \n", accuracy);
