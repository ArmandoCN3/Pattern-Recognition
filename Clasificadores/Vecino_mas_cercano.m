clc
clear all
close all
warning off all

cx = [];
cy = [];
resp = 1;
clasen = 0;
conteo = 0;
k=0;
contCeros = 0;
colores = parula(1000);
fprintf("CLASIFICADOR VECINO MAS CERCANO\n\n");
n = input("Ingrese un numero de clases: ");
nRepre = input("Dame el numero de representantes para tus clases: ");
disp = input("Ingresa la dispersion: ");
k = input('Ingresa k: ');

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
       
       for z = 1:nRepre;
           distancias(c,z) = sqrt((clasen(1,z)-vx)^2 + ((clasen(2,z)-vy)^2));
       end

    %%DIBUJANDO LAS CLASES
      color_actual = colores(c , :);
      plot(cx(c, :), cy(c, :), 'o', 'MarkerSize', 10, 'MarkerFaceColor', color_actual);
      etiquetas_leyenda{c} = ['Clase ', num2str(c)];
      hold on
      
    end

     for c = 1:nRepre;
        minimo = min(min(distancias));
        apuntador = find(distancias == minimo);
        votos(c) = mod(apuntador,n);
        distancias(apuntador) = NaN;
     end

     for c = 1:n;
         contCeros = 0;
         for z = 1:k;
             if votos(z) == c
                 conteo = conteo+1;
             end
             if votos(z) == 0
                 contCeros = contCeros+1;
             end
         end
         resultados(c) = conteo;
         resultados(n) = contCeros;
         probabilidad(c) = (resultados(c)*100)/k;
         conteo = 0;
     end
     
     maximo = max(probabilidad);
     final = find(probabilidad == maximo);
     
    plot(vector(1,:),vector(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
    legend('Vector',etiquetas_leyenda);
    fprintf("El vector pertenece a la clase %d\n", final);
    fprintf("Tiene %d  vecinos", max(resultados));

      
    resp = input("¿Quieres intentar con otro vector? (1 = si / 2 = no): ");
end