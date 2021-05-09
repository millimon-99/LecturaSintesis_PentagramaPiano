
i = imread('marcha1.png');   %Leemos el n-pentagrama de la partitura
i = rgb2gray(i);           %Convertimos la imagen a escala de grises y obtenemos una sola matriz 
j = imcomplement(i);       %Invertimos el color de la imagen para invertir los coef
%imshow(j);
%figure
vecNo = zeros(1,1500);     %CAMBIO %a
vecCoef= zeros(1,1500);%a
vecDur = zeros(1,1500);%a

for No=1:35              % Num corresponde al numero de notas que tengamos en la libreri    
nombre = No+".png"; 
nota = imread(nombre); %Leemos la n-nota
nota = rgb2gray(nota);     %Convertimos la nota a escala de grises y obtenemos una sola matriz 
notan = imcomplement(nota);%Invertimos el color de la nota para invertir los coef
%imshow(notan);
res = normxcorr2(notan,j); %Calculamos la correlacion entre la nota y la imagen

%surf(res);
%shading flat; 

[m,n] = size(res);         %Obtenemos el numero de filas m y columnas n 
sumatot = 0;               % variable para obtener el coef global
cont = 0;                  %Contar los pixeles con un coef correlacion mayor a 0;


%Saber si la nota esta en la n-seccion del pentagrama.
for i=1:m
    for i1=1:n
        aux = res(i,i1);                                                   %Sacamos el coef de correlacion del pixel 
        if aux > 0
            sumatot = sumatot + aux;
            cont = cont + 1;
        end
    end
end
coefglobal = sumatot/cont; 

if coefglobal > 0                                                          %Si es mayor a cero significa que por lo menos hay una nota
    for i=1:m
        for i1=1:n
            aux = res(i,i1);
            if aux > 0.09                                            % aqui estamos estableciendo que mas de 0.4 es una correlacion alta
               cor = 0;
               if 22>No && No>=1
                   cor = 7;
               elseif 32>No && No>=22
                   cor = 10;
               elseif  36>No && No>=32
                   cor = 20;
               end
               bandera = Verificarmask(res,i,i1,cor);                           %Verificamos que si sea la nota y no un punto extraordinario. 
               if bandera == true                                                  % si bandera es true, entonces es una posible nota
                  if vecNo(i1)==0 || aux>vecNo(i1)                         %No se ha detectado una nota anterior o el coef nuevo es mayor
                     if n>i1+cor                                     %Evitamos toparnos con un extremo de inicio a final
                         for z=i1:i1+cor 
                             vecNo(z) = No;
                             vecCoef(z) = aux;
                             if 22>No && No>=1 
                                 vecDur(z) = 0.5;                          % Se trata de una nota simple.
                             end
                             if 32>No && No>=22 
                                 vecDur(z) = 0.25;                         % Hay dos nota.
                             end
                             if 36>No && No>=32    
                                 vecDur(z) = 0.125;                        % Hay cuatro nota.
                             end
                         end
                     end
                     if i1>cor                                       %Evitamos toparnos con un extremo 
                         for z=i1-cor:i1
                             vecNo(z) = No;
                             vecCoef(z) = aux;
                              if 22>No && No>=1                     % Se trata de una nota simple.
                                 vecDur(z) = 0.5;
                             end
                             if 32>No && No>=22                     % Hay dos nota.
                                 vecDur(z) = 0.25;
                             end
                             if 36>No && No>=32  
                                 vecDur(z) = 0.125;                        % Hay cuatro nota.
                             end
                         end
                     end            
                  end 
               end
            end         
        end
    end
end
%Con el siguiente end ya habremos revisado todas las notas de nuestra
%libreria
end
%Filtramos los vectores de notas y duracion.

r = 1;
vecNofil = [];
vecDurfil = [];

while r<1500 %a   %CAMBIO el a coincide con el a del primer vector.
    aux2 = vecNo(r);
    if aux2 ~= 0  %Si hay una nota entonces el valor de la casilla es diferente de 0
        t = r;
        contador = 0;
        while vecNo(t) == aux2         % Queremos verificar si existe una nota entera
            contador = contador + 1;
            t = t+1;
        end
        if aux2>0 && 22>aux2   %se trata de una nota simple con una longitud mas chica
            if contador > 20        % CAMBIO si tiene la longitud de la mitad de una nota
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
        elseif aux2>=22 && 32>aux2  % se trata de dos notas con una longitud mediana
            if contador > 35               % CAMBIO si tiene la longitud de la mitad de una nota
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
        elseif aux2>=32 && 36>aux2      % se trata de dos notas con una longitud mediana
            if contador > 50           % CAMBIO si tiene la longitud de la mitad de una nota
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
        end
        r = r+contador+1;
    else  % en este caso la celda tenia un cero, se deja pasar.
        r = r+1;
    end
end

% Obtenemos los vectores finales

frecuencias = [];
duracion = [];

for k=1: length(vecNofil)
    if 22>k && k>=1   %Aqui hay una nota simple
        frecuencia = notasimple(vecNofil(k));
        frecuencias = [frecuencias, frecuencia];
        duracion = [duracion, vecDurfil(k)];
    elseif 32>k && k>=22  
        %[frec1,frec2] = notadoble(vecNofil(k));
         %frecuencias = [frecuencias, frec1];
         %frecuencias = [frecuencias, frec2];
         %duracion = [duracion, vecDurfil(k)];
         %duracion = [duracion, vecDurfil(k)];
         frecuencia = notasimple(vecNofil(k));
         duracion = [duracion, vecDurfil(k)];
    elseif 35>k && k>=32
        [frec1,frec2,frec3,frec4] = notacuatro(vecNofil(k));
         frecuencias = [frecuencias, frec1];
         frecuencias = [frecuencias, frec2];
         frecuencias = [frecuencias, frec3];
         frecuencias = [frecuencias, frec4];
         duracion = [duracion, vecDurfil(k)];
         duracion = [duracion, vecDurfil(k)];
         duracion = [duracion, vecDurfil(k)];
         duracion = [duracion, vecDurfil(k)];
    end
end

dur = 60/50; % aqui van los bpm 
resp = [];

for l=1:length(frecuencias)
    
    frec = frecuencias(l);
    durultima = duracion(1);
    q=44100*(dur*durultima);
    tn = (1:q)/44100;
    c=0;
    for p=1:30
    c = c+(1/p)*cos(2*pi*frec*tn);
    end
    f=0.99*exp(-tn);
    cn=c.*f;
    resp = [resp cn];

end

fsnueva =44100;
sound(resp,fsnueva);



