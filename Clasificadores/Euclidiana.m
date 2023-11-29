clc
clear all
close all
warning off all

cx = [];
cy = [];
resp = 1;
clasen = 0;
colores = parula(1000);
fprintf("CLASIFICADOR EUCLIDIANA\n\n");
n = input("Ingrese un numero de clases: ");
nRepre = input("Dame el numero de representantes para tus clases: ");
disp = input("Ingresa la dispersion: ");

for c = 1:n;
  fprintf("Dame X para la clase %d: ", c);
  cen_gravX(c) = input('');
  fprintf("Dame Y para la clase %d: ", c);
  cen_gravY(c) = input('');
end

for c = 1:n;
        %%CREANDO LA CLASE  
        cx(c,:)=((rand(1,nRepre)*disp)+cen_gravX(c));
        cy(c,:)=((rand(1,nRepre)*disp)+cen_gravY(c));
end

while resp == 1
    vx=input('dame coord del vector en x=');
    vy=input('dame coord del vector en y=');
    vector=[vx;vy];
    for c = 1:n;
       clasen = [cx(c,:) ; cy(c,:)];
        
       %%CALCULANDO POR EUCLIDIANA
       media = mean(clasen,2);
       distancia(c) = norm(vector-media);

    %%DIBUJANDO LAS CLASES
      color_actual = colores(c , :);
      plot(cx(c, :), cy(c, :), 'o', 'MarkerSize', 10, 'MarkerFaceColor', color_actual);
      etiquetas_leyenda{c} = ['Clase ', num2str(c)];
      hold on
      
    end
     plot(vector(1,:),vector(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
     etiquetas_leyenda{c+1} =['Vector']; 
     legend(etiquetas_leyenda);
    minimo = min(min(distancia));
    dato=find(distancia == minimo);
    fprintf("el vector pertenece a la clase %d\n", dato)

    resp = input("¿Quieres intentar con otro vector? (1 = si / 2 = no): ");
end