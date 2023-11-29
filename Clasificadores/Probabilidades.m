clc % limpia pantalla
clear all % limpia todo
close all %cierra todo
warning off all  % apaga los warnings

colores = parula(1000);
c = 1;
cx = 0;
cy = 0;
resp = 0;
clasen = [];
probabilidads = [];
prob_n = [];
fprintf("CLASIFICADOR PROBABILIDADES\n\n");
n = input("Ingrese un numero de clases: ");
nRepre = input("Dame el numero de representantes para tus clases: ");
disp = input("Ingresa la dispersion: ");
vx=input('dame coord del vector en x=');
vy=input('dame coord del vector en y=');


vector=[vx;vy];

for c = 1:n;
  fprintf("Dame X para la clase %d: ", c);
  cen_gravX(c) = input('');
  fprintf("Dame Y para la clase %d: ", c);
  cen_gravY(c) = input('');


end

for c = 1:n;
   %%CREANDO LA CLASE  
  cx=((rand(1,nRepre)*disp)+cen_gravX(c));
  cy=((rand(1,nRepre)*disp)+cen_gravY(c));
  clasen = [cx ; cy];
  clasex(c,:) = cx;
  clasey(c,:) = cy;
  %%AUTOMATIZANDO PROCESO
  
  media = mean(clasen,2);
  dato1_x=clasen(1,:)-media(1,:);
  dato1_y=clasen(2,:)-media(2,:);
  dato1_tot_c1=[dato1_x;dato1_y];
  dato2_tot_c1=dato1_tot_c1';
  varianza1=(1/5)*dato1_tot_c1*dato2_tot_c1;

  %%CALCULA PROBABILIDADES
  dato1=vector(:,:)-media(:,:);
  dato1=dato1';
  dato2=dato1';
  inv_varianza1=inv(varianza1);
  a=exp(-0.5*dato1*inv_varianza1*dato2);
  
  b=(1/(2*pi)*det(varianza1)^(-0.5));
  probabilidads(c)=b*a;
  
  %%DIBUJANDO LAS CLASES
  color_actual = colores(c , :);
  plot(cx(1, :), cy(1, :), 'o', 'MarkerSize', 10, 'MarkerFaceColor', color_actual);
  etiquetas_leyenda{c} = ['Clase ', num2str(c)];
  
  
  hold on
end

for c = 1:n;
    %%NORMALIZANDO
  prob_n(c) = (probabilidads(c)/(sum(probabilidads)))*100;
end

maximo=max(max(prob_n))
valor=find(prob_n==maximo)
fprintf('el vector desconocido pertenece a la clase=%d\n',valor)

plot(vector(1,:),vector(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
legend('Vector', etiquetas_leyenda);

resp = input("¿Quieres intentar con otro vector? (1 = si / 2 = no): ");
if resp == 1
    while resp == 1
        vx=input('dame coord del vector en x=');
        vy=input('dame coord del vector en y=');
        vector=[vx;vy];

        for c = 1:n;
    
      clasen = [clasex(c,:) ; clasey(c,:)];
      %%AUTOMATIZANDO PROCESO
      
      media = mean(clasen,2);
      dato1_x=clasen(1,:)-media(1,:);
      dato1_y=clasen(2,:)-media(2,:);
      dato1_tot_c1=[dato1_x;dato1_y];
      dato2_tot_c1=dato1_tot_c1';
      varianza1=(1/5)*dato1_tot_c1*dato2_tot_c1;
    
      %%CALCULA PROBABILIDADES
      dato1=vector(:,:)-media(:,:);
      dato1=dato1';
      dato2=dato1';
      inv_varianza1=inv(varianza1);
      a=exp(-0.5*dato1*inv_varianza1*dato2);
      
      b=(1/(2*pi)*det(varianza1)^(-0.5));
      probabilidads(c)=b*a;
      
      %%DIBUJANDO LAS CLASES
      color_actual = colores(c , :);
      plot(clasex(c, :), clasey(c, :), 'o', 'MarkerSize', 10, 'MarkerFaceColor', color_actual);
      etiquetas_leyenda{c} = ['Clase ', num2str(c)];
      
      
      hold on
    end
    
    for c = 1:n;
        %%NORMALIZANDO
      prob_n(c) = (probabilidads(c)/(sum(probabilidads)))*100;
    end
    
    maximo=max(max(prob_n))
    valor=find(prob_n==maximo)
    fprintf('el vector desconocido pertenece a la clase=%d\n',valor)
    
    plot(vector(1,:),vector(2,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
    legend('Vector', etiquetas_leyenda);

    resp = input("¿Quieres intentar con otro vector? (1 = si / 2 = no): ");
    end

end
