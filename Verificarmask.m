function resp = Verificarmask(m,r,c)
%Función que verifica que los número a la derecha-izquierda y arriba-abajo
%de la coordenado (r,c) sean mayores
resp = false;
[lr,lc] = size(m);
crO = m(r,c);
RFa = 2;

%esquina superior izquierda (1,1)
if(r==1 && c==1)
    if(RFa<=lr && RFa<=lc)
        crA = m(RFa,c);
        if(crA>crO)
            crA = m(r,RFa);
            if(crA>crO)
                disp('caso 1')
                resp=true;
            end
        end
    end
else
    %esquina superior derecha (1,n)
    if(r==1 && c==lc)
        xyA = c-1;
        if(RFa<=lr && xyA<lc)
            crA= m(RFa,c);
            if(crA>crO)
                crA=m(r,xyA);
                if(crA>crO)
                    disp('caso 2')
                    resp=true;
                end
            end
        end
    else
        %esquina inferior izquierda (n,1)
        if(r==lr && c==1)
            xyA = r-1;
            if (xyA>=1 && RFa<=lc)
                crA=m(xyA,c);
                if(crA>crO)
                    crA=m(r,RFa);
                    if(crA>crO)
                        disp('caso 3')
                        resp=true;
                    end
                end
            end
        else
            %esquina inferiro derecha (n,n)
            if(r==lr && c==lc)
                xA=r-1; yA=c-1;
                if(xA>=1 && yA<lc)
                    crA=m(xA,c);
                    if(crA>crO)
                        crA=m(r,yA);
                        if(crA>crO)
                            disp('caso 4')
                            resp=true;
                        end
                    end
                end
            else
               %Otros casos
               disp('otros')
               resp=Verificarmask2(m,r,c,lr,lc,crO,RFa);
            end
        end    
    end
end          
        
end

function resp = Verificarmask2(m,r,c,lr,lc,crO,RFa)
%Función de Otros casos en Verificarmask(m,r,c)
resp= false;

%columna 1 o columna n con cualquier i
if(c==1 || c==lc)
    xU=r-1; xD=r+1;
    if(xU>=1 && xD<=lr)
        crU=m(xU,c); crD=m(xD,c);
        if(crU>crO || crD>crO)
            if(c==1 && RFa<=lc)
                crA=m(r,RFa);
                if(crA>crO)
                    disp('otro 1')
                    resp=true;
                end
            else
                yA=c-1;
                if(yA>=1)
                    crA=m(r,yA);
                    if(crA>crO)
                        disp('otro 2')
                        resp=true;
                    end
                end
            end
        end
    end
else
    %caso renglón 1 o renglon n con cualquie j
    if(r==1 || r==lr)
        yR=c+1; yL=c-1;
        if(yR<=lc && yL>=1)
            crR=m(r,yR);crL=m(r,yL);
            if(crR>crO || crL>crO)
                if(r==1 && RFa<=lr)
                    crA=m(RFa,c);
                    if(crA>crO)
                        disp('otro 3')
                        resp=true;
                    end
                else
                    xA=r-1;
                    if(xA>=1)
                        crA=m(xA,c);
                        if(crA>crO)
                            disp('otro 4')
                            resp=true;
                        end
                    end
                end
            end
        end
    else
        %último caso (i,j)
        xU=r-1; xD=r+1;
        yR=c+1; yL=c-1;
        if(xU>=1 && xD<=lr && yR<=lc && yL>=1)
            crU=m(xU,c); crD=m(xD,c);
            if(crU>crO || crD>crO)
                crR=m(r,yR);crL=m(r,yL);
                if(crR>crO || crL>crO)
                    disp('otro 5')
                    resp=true;
                end
            end
        end
    end        
end     

end
