%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Trayectoria %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

intruso=0;
camara_out=0;
rango_out=0;


%Se calcula si es intruso o no
if(rand<prob_intruso)
    intruso=1;
    cont_intruso=cont_intruso+1;
end

%Asignamos las ID
id_c(jj,1)=ii_id_c;
ii_id_c=ii_id_c+1;
if(intruso==0)
    id_r(jj,1)=ii_id_r;
    ii_id_r=ii_id_r+1;
end

%Calculo aleatorio de los puntos iniciales y finales
%Inicio
x_in=(anchura_escenario-2*margen_inout)*rand+margen_inout;
y_in=0;

%Final
% if(rand<prob_inc)
%     x_out=anchura_escenario*rand;
%     y_out=altura_escenario;
% else
x_out=2*margen_out*rand+(x_in-margen_out);
y_out=altura_escenario;
% end

%Corregir el desvío para enmarcarlo en el escenario
while(x_out>anchura_escenario)
    x_out=x_out-rand;
end
while(x_out<0)
    x_out=x_out+rand;
end

%Calculo aleatorio de velocidad de una persona

if(rand<=prob_corr)
    veloc=(Vmax_corr-Vmin_corr)*rand+Vmin_corr;
else
    veloc=(Vmax_and-Vmin_and)*rand+Vmin_and;
end

%Descomponer velocidad en x e y
ang_p=atan2((y_in-y_out),(x_in-x_out));

vx=veloc*cos(ang_p);
if(x_out>x_in)
    vx=abs(vx);
else
    vx=-vx;
end
vy=abs(veloc*sin(ang_p));

%Buscamos el múltiplo de t_lect_sensores más próximo para el rango
t_ini_rango=t_lect_sensores;
while t_ini_rango<t
    t_ini_rango=t_ini_rango+t_lect_sensores;
end


%Rellenamos los vectores de las coordenadas de las trayectorias
if(intruso==0)
    xt_r(jj,1)=vx*(t_ini_rango-t)+x_in;
    yt_r(jj,1)=vy*(t_ini_rango-t)+y_in;
    
    ii=2;
    while rango_out==0
        xt_r(jj,ii)=vx*(ii-1)*t_lect_sensores+xt_r(jj,1);
        yt_r(jj,ii)=vy*(ii-1)*t_lect_sensores+yt_r(jj,1);
        
        if(xt_r(jj,ii)>anchura_escenario || xt_r(jj,ii)<0 || yt_r(jj,ii)<0 || yt_r(jj,ii)>altura_escenario)
            rango_out=1;
            xt_r(jj,ii)=-1;
            yt_r(jj,ii)=-1;
            imax_r=ii;
        end
        ii=ii+1;
        if(ii>Nmax)
            fprintf('\nAVISO: matrices de trackeo desbordas en número de muestras (columnas)');
            fprintf('\n %d\n',t);
            return;
        end
    end
end

%Calculamos y rellenamos cámara
x_in_c=((dif_altura_camara-y_in)*(x_out-x_in)/(y_out-y_in))+x_in;
y_in_c=dif_altura_camara;
altura_limite=altura_escenario-dif_altura_camara;

t_in_cam=((x_in_c-x_in)/vx)+t;

%Buscamos el múltiplo de t_lect_sensores más próximo para la cámara
t_ini_cam=t_lect_sensores;
while t_ini_cam<t_in_cam
    t_ini_cam=t_ini_cam+t_lect_sensores;
end

xt_c(jj,1)=vx*(t_ini_cam-t_in_cam)+x_in_c;
yt_c(jj,1)=vy*(t_ini_cam-t_in_cam)+y_in_c;

ii=2;
while camara_out==0
    xt_c(jj,ii)=vx*(ii-1)*t_lect_sensores+xt_c(jj,1);
    yt_c(jj,ii)=vy*(ii-1)*t_lect_sensores+yt_c(jj,1);
    
    if( yt_c(jj,ii)> altura_limite)
        camara_out=1;
        xt_c(jj,ii)=-1;
        yt_c(jj,ii)=-1;
        imax_c=ii;
    end
    ii=ii+1;
    if(ii>Nmax)
        fprintf('\nAVISO: matrices de trackeo desbordas en número de muestras (columnas)');
        fprintf('\n %d\n',t);
        return;
    end
end

%Calculo de los tiempos de cada muestra
if(intruso==0)
    t_r(jj,1)=t_ini_rango;
    for ii=2:imax_r
        if(xt_r(jj,ii)~=-1 && yt_r(jj,ii)~=-1)
            t_r(jj,ii)=t_r(jj,1)+(ii-1)*t_lect_sensores;
        else
            t_r(jj,ii)=-1;
        end
    end
end

t_c(jj,1)=t_ini_cam;

for ii=2:imax_c
    if(xt_c(jj,ii)~=-1 && yt_c(jj,ii)~=-1)
        t_c(jj,ii)=t_c(jj,1)+(ii-1)*t_lect_sensores;
    else
        t_c(jj,ii)=-1;
    end
end


%Calculo de los valores de ruido
n_c=(n_c_max-n_c_min)*rand+n_c_min;

if(intruso==0)
    n_r=(n_r_max-n_r_min)*rand+n_r_min;
    
    %Se le mete ruido
    if(intruso==0)
        for ii=1:imax_r
            if(xt_r(jj,ii)~=-1 && yt_r(jj,ii)~=-1)
                xt_r(jj,ii)=xt_r(jj,ii)+n_r*randn;
                yt_r(jj,ii)=yt_r(jj,ii)+n_r*randn;
            end
        end
    end
end

for ii=1:imax_c
    if(xt_c(jj,ii)~=-1 && yt_c(jj,ii)~=-1)
        xt_c(jj,ii)=xt_c(jj,ii)+n_c*randn;
        yt_c(jj,ii)=yt_c(jj,ii)+n_c*randn;
    end
end

%Redondeamos el tiempo a dos decimales
xt_r=roundn(xt_r,-2);
yt_r=roundn(yt_r,-2);
t_r=roundn(t_r,-2);

xt_c=roundn(xt_c,-2);
yt_c=roundn(yt_c,-2);
t_c=roundn(t_c,-2);

%Rango
if(intruso==0)
    t_r_ini(jj)=t_r(jj,1);
    while(t_r(jj,ii)~=-1)
        ii=ii+1;
    end
    t_r_end(jj)=t_r(jj,ii-1);
    
    t_r(jj,:)=-1;
    
end

%Cámara
t_c_ini(jj)=t_c(jj,1);

t_c_end(jj)=t_c(jj,imax_c-1);

t_c(jj,:)=-1;