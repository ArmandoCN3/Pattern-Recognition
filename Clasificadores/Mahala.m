clc
clear all
close all
warning off all

cx = [];
cy = [];
resp = 1;
clasen = 0;
colores = parula(1000);
fprintf("CLASIFICADOR  MAHALA\n\n");
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
    %%CALCULANDO DISTANCIAS
      media = mean(clasen,2);
      dato = (clasen-media);
      dato1 = dato';
      dato1_f = 0.25 * (dato * dato1);
      cov = inv(dato1_f);
      distancia(c) = (vector-media)' * (cov) * (vector-media);

    %%DIBUJANDO LAS CLASES
      color_actual = colores(c , :);
      plot(cx(c, :), cy(c, :), 'o', 'MarkerSize', 10, 'MarkerFaceColor', color_actual);
      etiquetas_leyenda{c} = ['Clase ', num2str(c)];
      hold on
      plot(vector(1,:),vector(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
      legend(etiquetas_leyenda);

    end
    
    %%CLASIFICANDO EL VECTOR
     d_final = min(distancia);
    chipocludo = find(distancia == d_final);
    fprintf("El vector pertenece a la clase: %d\n", chipocludo);
    
    resp = input("¿Quieres intentar con otro vector? (1 = si / 2 = no): ");
end