clc % borra pantalla
clear all  % limpia todo
close all % cierra todo
warning off all % apaga las advertencias

c = readtable('iris_fold_1.csv');
c = table2array(c(1:15,2:5));
c1 = c(2:6,:);
c2 = c(6:10,:);
c3 = c(11:15,:);
acertados = 0;
errados  = 0;
porcentaje = 0;

for z = 1:9;
    if z ==1
        pruebas = readtable('iris_fold_2.csv');
        pruebas = table2array(pruebas);
    end
    if z ==2
        pruebas = readtable('iris_fold_3.csv');
        pruebas = table2array(pruebas);
    end
    if z ==3
        pruebas = readtable('iris_fold_4.csv');
        pruebas = table2array(pruebas);
    end
    if z ==4
        pruebas = readtable('iris_fold_5.csv');
        pruebas = table2array(pruebas);
    end
    if z ==5
        pruebas = readtable('iris_fold_6.csv');
        pruebas = table2array(pruebas);
    end
    if z ==6
        pruebas = readtable('iris_fold_7.csv');
        pruebas = table2array(pruebas);
    end
    if z ==7
        pruebas = readtable('iris_fold_8.csv');
        pruebas = table2array(pruebas);
    end
    if z ==8
        pruebas = readtable('iris_fold_9.csv');
        pruebas = table2array(pruebas);
    end
    if z ==9
        pruebas = readtable('iris_fold_10.csv');
        pruebas = table2array(pruebas);
    end
    for x = 1:15;
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

    porcentaje = porcentaje + ((acertados*100)/15);
    acertados= 0;
    errados = 0;
end

accuracy = porcentaje/9;
fprintf("el clasificador tiene un accuracy de %.2f porciento \n", accuracy);