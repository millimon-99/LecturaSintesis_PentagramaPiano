function PDS_Proyecto2_TacosAlPastor(pentagrama, bpm)
%Leemos el n-pentagrama de la partitura.
i = imread(pentagrama); 
%Convertimos la imagen a escala de grises y obtenemos una sola matriz. 
i = rgb2gray(i);  
%Invertimos el color de la imagen para modificar los coefientes.
j = imcomplement(i);       

%Establecemos 3 vectores en donde almacenaremos las notas encontradas, la
%duracion de cada nota y los coeficientes de correlación para encontrar la
%nota que mas se asemeja. La longitud de los vectores debe ser más grande
%al número de pixeles de los pentagramas. 
vecNo = zeros(1,1500);    
vecCoef= zeros(1,1500);
vecDur = zeros(1,1500);

%Utilizamos un for para analizar cada una de las notas de nuestra
%biblioteca
for No=1:35
%Construimos el nombre de la nota en funcion al ciclo del for                  
nombre = No+".png"; 
%Leemos la n-nota
nota = imread(nombre); 
%Convertimos la nota a escala de grises y obtenemos una sola matriz 
nota = rgb2gray(nota); 
%Invertimos el color de la nota para invertir los coeficientes
notan = imcomplement(nota);
%Calculamos la matriz de correlacion entre la nota y la imagen
res = normxcorr2(notan,j);

%Obtenemos el numero de filas m y columnas n 
[m,n] = size(res);        
%Analizaremos cada celda de la matriz de correlaciones. 
    for i=1:m
        for i1=1:n
            aux = res(i,i1);
%Verificamos si la correlación de la celda  es mas grande a un
%valor definido para revisar si se trata de una nota.
            if aux > 0.09                                            
               cor = 0;
%Establecemos la cantidad de pixeles que analizaremos par corroborar que se
%trata de una nota. Segun se trate de una nota simple, doble o cuatro sera
%el numero de pixelee.
               if 22>No && No>=1
                   cor = 7;
               elseif 32>No && No>=22
                   cor = 10;
               elseif  36>No && No>=32
                   cor = 20;
               end
%El método verificarmask revisa los coeficientes mas cercanos a la celda
%para verificar si se trata de una nota o una correlacion alta aislada
               bandera = Verificarmask(res,i,i1,cor);  
% si bandera es true, entonces es una posible nota
               if bandera == true
%Revisamos si no se ha detectado una nota anterior en esa posicion o
%el coeficiente de corelacion es mayor a la posible nota anterior.                                                 
                  if vecNo(i1)==0 || aux>vecNo(i1)                         
                     if n>i1+cor
%Añadimos la nota con el coeficiente mas grande en la posicion encontrada.
%Asi mismo, llenamos una cantidad de celdas proporcional al numero de
%pixeles de la nota para evitar repetir notas. 
                         for z=i1:i1+cor 
                             vecNo(z) = No;
                             vecCoef(z) = aux;
% Si se trata de una nota negra, la reproduccion es de .5 del tiempo de una nota. 
                             if 22>No && No>=1 
                                 vecDur(z) = 0.5;
                             end
% Si se trata de una corchea,se reproduce 0.25 del tiempo total de una nota. 
                             if 32>No && No>=22 
                                 vecDur(z) = 0.25;                         
                             end
% Si se trata de una semicorchea,se reproduce 0.125 del tiempo total de una nota. 
                             if 36>No && No>=32    
                                 vecDur(z) = 0.125;                        
                             end
                         end
                     end
                     if i1>cor                                       
                         for z=i1-cor:i1
                             vecNo(z) = No;
                             vecCoef(z) = aux;
                              if 22>No && No>=1                     
                                 vecDur(z) = 0.5;
                             end
                             if 32>No && No>=22                    
                                 vecDur(z) = 0.25;
                             end
                             if 36>No && No>=32  
                                 vecDur(z) = 0.125;                        
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

while r<1500 
    aux2 = vecNo(r);
%Si hay una nota entonces el valor de la celda es diferente de 0
    if aux2 ~= 0  
        t = r;
        contador = 0;
% Para delimitar su se trata de una nota verificamos que la longitud de la
% nota coincida con el numero de pixeles
        while vecNo(t) == aux2         
            contador = contador + 1;
            t = t+1;
        end
%Verificamos si se trata de una nota negra
        if aux2>0 && 22>aux2   
            if contador > 20       
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
%Verificamos si se trata de dos corcheas
        elseif aux2>=22 && 32>aux2  
            if contador > 35               
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
% Verificamos si se trata de cuatro semicorcheas
        elseif aux2>=32 && 36>aux2      
            if contador > 50           
                vecNofil = [vecNofil,aux2];
                vecDurfil = [vecDurfil,vecDur(r)];
            end
        end
        r = r+contador+1;
% en este caso la celda tenia un cero, se deja pasar.
    else  
        r = r+1;
    end
end

% Obtenemos los vectores finales

frecuencias = [];
duracion = [];

%Asociamos cada nota con su respectiva frecuencia y duracion. 
for s=1: length(vecNofil)
    k = vecNofil (s);
    if 22>k && k>=1   
        frecuencia = notasimple(k);
        frecuencias = [frecuencias, frecuencia];
        duracion = [duracion, vecDurfil(k)];
    elseif 32>k && k>=22 
        disp(k)
        [frec1,frec2] = notadoble(k);
        frecuencias = [frecuencias, frec1];
        frecuencias = [frecuencias, frec2];
        duracion = [duracion, vecDurfil(k)];
        duracion = [duracion, vecDurfil(k)];
    elseif 35>k && k>=32
        [frec1,frec2,frec3,frec4] = notacuatro(k);
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

%calculamos la duración de cada nota en función del bpm de la cancion. 
dur = 60/bpm; 
resp = [];

for l=1:length(frecuencias)
    %Obtenemos la frecuencia de la nota n    
    frec = frecuencias(l);
    disp (notaAsociada(frec))
    %Obtenemos la  duración de la nota n
    durultima = duracion(1);
    q=44100*(dur*durultima);
    tn = (1:q)/44100;
    c=0;
    %Calculamos los primero 30 armonicos
    for p=1:30
    c = c+(1/p)*cos(2*pi*frec*tn);
    end
    %Definimos una señal f que sirve para atenuar la señal de la nota a
    %través del tiempo y dar el efecto de piano. 
    f=0.99*exp(-tn);
    cn=c.*f;
    resp = [resp cn];
end

fsnueva =44100;
sound(resp,fsnueva);

end
