function resp = Verificarmask(m,r,c,n)
%Función que verifica que los vecianos n a la derecha-izquierda y arriba-abajo
%de la coordenado (r,c) sean mayores
resp = false;
flag=true;
[lr,lc] = size(m);
crO = 0.09; %CAMBIO NECESARIO 
RFa = 2;
i=1;

%esquina superior izquierda (1,1)'revisado'
if(r==1 && c==1)
    RFaux=RFa;
    while i<=n && flag
        if(RFaux<=lr)
            crA = m(RFaux,c);
            if(crA<crO)
                flag=false;
            end
            RFaux=RFaux+1;
            i=i+1;
        else
            flag=false;
        end
    end
    if(flag && i>n)
        j=1;
        RFaux=RFa;
        while j<=n && flag
            if(RFaux<=lc)
                crA = m(r,RFaux);
                if(crA<crO)
                    flag=false;
                end
                RFaux=RFaux+1;
                j=j+1;
            else
                flag=false;
            end
        end
    end
    if(flag && i>n && j>n)
            resp=true;
    end
else
    %esquina superior derecha (1,n) 'revisado'
    if(r==1 && c==lc)
        RFaux=RFa;
        while i<=n && flag
            if(RFaux<=lr)
                crA= m(RFaux,c);
                if(crA<crO)
                    flag=false;
                end
                RFaux=RFaux+1;
                i=i+1;
            else
                flag=false;
            end
        end
        if(flag && i>n)
            j=1;
            xyA = c-1;
            while j<=n && flag
                if(xyA>=1)
                    crA=m(r,xyA);
                    if(crA<crO)
                        flag=false;
                    end
                    xyA=xyA-1;
                    j=j+1;
                else
                    flag=false;
                end
            end
        end
        if(flag && i>n && j>n)
            resp=true; 
        end      
    else
        %esquina inferior izquierda (n,1) 'revisado'
        if(r==lr && c==1)
            xyA = r-1;
            while i<=n && flag
                if (xyA>=1)
                    crA=m(xyA,c);
                    if(crA<crO)
                        flag=false;
                    end
                    xyA=xyA-1;
                    i=i+1;
                else
                    flag=false;
                end
            end
            if(flag && i>n)
                j=1;
                RFaux=RFa;
                while j<=n && flag
                    if(RFaux<=lc)
                        crA=m(r,RFaux);
                        if(crA<crO)
                            flag=false;
                        end
                        RFaux=RFaux+1;
                        j=j+1;
                    else
                        flag=false;
                    end
                end
            end
            if(flag && i>n && j>n)
                resp=true;
            end
        else
            %esquina inferiro derecha (n,n) 'revisado'
            if(r==lr && c==lc)
                xA=r-1;
                while i<=n && flag
                    if(xA>=1)
                        crA=m(xA,c);
                        if(crA<crO)
                            flag=false;
                        end
                        xA=xA-1;
                        i=i+1;
                    else
                        flag=false;
                    end
                end
                if(flag && i>n)
                    j=1;
                    yA=c-1;
                    while j<=n && flag
                        if(yA>=1)
                            crA=m(r,yA);
                            if(crA<crO)
                                flag=false;
                            end
                            yA=yA-1;
                            j=j+1;
                        else
                            flag=false;   
                        end
                    end
                end
                if(flag && i>n && j>n)
                    resp=true;
                end
            else
               %Otros casos
               %disp('otros')
               resp=Verificarmask2(m,r,c,n,lr,lc,crO);
            end
        end    
    end
end          
        
end

function resp = Verificarmask2(m,r,c,n,lr,lc,crO)
%Función de Otros casos en Verificarmask(m,r,c)
resp= false;
flagU=true;
flagD=true;
flagR=true;
flagL=true;
RFa=2;
i=1;
%crO=0.6

%columna 1 con cualquier i 'revisado'
if(c==1 || c==lc)
    xU=r-1;
    while i<=n && flagU 
        if(xU>=1)
            crU=m(xU,c);
            if(crU<crO)
                flagU=false;
            end
            xU=xU-1;
            i=i+1;
        else
            flagU=false;
        end
    end
    xD=r+1;
    j=1;
    while j<=n && flagD
            if(xD<=lr)
                crD=m(xD,c);
                if(crD<crO)
                    flagD=false;
                end
                xD=xD+1;
                j=j+1;
            else
                flagD=false;
            end
    end
    if((flagU && i>n) || (flagD && j>n))
        if(c==1)
            RFaux=RFa;
            w=1;
            while w<=n && flagR
                if(RFaux<=lc)
                    crA=m(r,RFaux);
                    if(crA<crO)
                        flagR=false;
                    end
                    RFaux=RFaux+1;
                    w=w+1;
                else
                    flagR=false;
                end
            end
            if(flagR && w>n)
                resp=true;
            end
        else
            yA=c-1;
            z=1;
            while z<=n && flagL
                if(yA>=1)
                    crA=m(r,yA);
                    if(crA<crO)
                        flagL=false;
                    end
                    yA=yA-1;
                    z=z+1;
                else
                    flagL=false;
                end
            end
            if(flagL && z>n)
                resp=true;
            end
        end
    end
else
    %caso renglón 1 o renglon n con cualquie j
    if(r==1 || r==lr)
        yR=c+1;
        while i<=n && flagR
            if(yR<=lc)
                crR=m(r,yR);
                if(crR<crO)
                    flagR=false;
                end
                yR=yR+1;
                i=i+1;
            else
                flagR=false;
            end
        end
        yL=c-1;
        j=1;
        while j<=n && flagL
            if(yL>=1)
                crL=m(r,yL);
                if(crL<crO)
                    flagL=false;
                end
                yL=yL-1;
                j=j+1;
            else
                flagL=false;
            end
        end
        if((flagR && i>n) || (flagL && j>n))
            if(r==1)
                RFaux=RFa;
                w=1;
                while w<=n && flagD
                    if(RFaux<=lr)
                        crA=m(RFaux,c);
                        if(crA<crO)
                            flagD=false;
                        end
                        RFaux=RFaux+1;
                        w=w+1;
                    else
                        flagD=false;
                    end
                end
                if(flagD && w>n)
                    resp=true;
                end
            else
                xA=r-1;
                z=1;
                while z<=n && flagU
                    if(xA>=1)
                        crA=m(xA,c);
                        if(crA<crO)
                            flagU=false;
                        end
                        xA=xA-1;
                        z=z+1;
                    else
                        flagU=false;
                    end
                end
                if(flagU && z>n)
                    resp=true;
                end
            end
        end
    else
        %último caso (i,j)
        %disp('caso final')
        xU=r-1; 
        while i<=n && flagU
            if(xU>=1)
                crU=m(xU,c);
                if(crU<crO)
                    flagU=false;
                end
                xU=xU-1;
                i=i+1;
            else
                flagU=false;
            end
        end
        xD=r+1;
        j=1;
        while j<=n && flagD
            if(xD<=lr)
                crD=m(xD,c);
                if(crD<crO)
                    flagD=false;
                end
                xD=xD+1;
                j=j+1;
            else
                flagD=false;
            end
        end
        if((flagU && i>n) || (flagD && j>n))
            yR=c+1;
            w=1;
            while w<=n && flagR
                if (yR<=lc)
                    crR=m(r,yR);
                    if(crR<crO)
                        flagR=false;
                    end
                    yR=yR+1;
                    w=w+1;
                else
                    flagR=false;
                end
            end
            yL=c-1;
            z=1;
            while z<=n && flagL
                if(yL>=1)
                    crL=m(r,yL);
                    if(crL<crO)
                        flagL=false;
                    end
                    yL=yL-1;
                    z=z+1;
                else
                    flagL=false;
                end
            end
            if((flagR && w>n) || (flagL && z>n))
                resp=true;
            end 
        end
    end
end
end