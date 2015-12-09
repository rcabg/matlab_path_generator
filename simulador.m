%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Simulador %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clf
close all
clc

tic

%Cargamos todos los parámetros
parametros

%Inicializamos matrices y variables
ini_variables

%Creamos un txt para la simulación
nametxt=input('Introduce el nombre del txt:','s');
fileid=fopen(strcat('C:\Users\RAFA\Documents\MATLAB\proyecto\colaboracion\',strcat(nametxt,'.txt')),'w');

%Empieza funcionar el tiempo
for t=0:tp:tf
    %Creamos o no una persona
    if(t>=t_prox)
        if(rand<=prob_in)
            trayectoria
            jj=jj+1;
            %Comprobación de seguridad (desbordamiento de matriz)
            if(jj>mat_per_max+1)
                fprintf('\nAVISO: matrices de trackeo desbordas en número de personas (filas)');
                fprintf('\n %d\n',t);
                return;
            end
            t_esp_in=t_esp_in_max*rand;
            t_prox=t+t_esp_in;
        else
            t_esp_no=t_esp_no_max*rand;
            t_prox=t+t_esp_no;
        end
    end
    
    %Reinicio en caso de desbordamiento
    if(jj==mat_per_max+1)
        jj=1;
    end
    
    %Marcamos el tiempo de muestreo de los sensores
    if(mod(t,t_lect_sensores)==0)
        
        
        
        %Buscar coincidencias en las matrices de tiempo para escribirlas en
        %el txt
        
        
        clear contf contc tam_cont_c
        [contf,contc]=find(abs(10000000000*(t_c_end-t))<1);
        tam_cont_c=size(contf);
        if(tam_cont_c(1)>=1)
            %Vamos a recorrer las coincidencias por las matrices
            for jjm=1:1:tam_cont_c(1)
                buscafila=contf(jjm);
                
                %                 %Escribimos el tiempo
                %                 fprintf(fileid,'\n%1.2f\n',t);
                
                %CÁMARA
                fprintf(fileid,'CAMARA\n');
                %Imprimimos la ID
                fprintf(fileid,'%i\n',id_c(buscafila));
                %Imprimimos tiempo de entrada
                fprintf(fileid,'%1.2f\n',t_c_ini(buscafila,1));
                %Imprimimos tiempo de salida
                fprintf(fileid,'%1.2f\n\n',t_c_end(buscafila,1));
                %Limpiamos cuando haya acabado
                xt_c(buscafila,:)=-1;
                yt_c(buscafila,:)=-1;
                t_c(buscafila,:)=-1;
                t_c_ini(buscafila)=-1;
                t_c_end(buscafila)=-1;
                id_c(buscafila)=-1;
            end
        end
        
        
        clear contf contc tam_cont_r
        [contf,contc]=find(abs(10000000000*(t_r_end-t))<1);
        tam_cont_r=size(contf);
        if(tam_cont_r(1)>=1)
            %Vamos a recorrer las coincidencias por las matrices
            for jjm=1:1:tam_cont_r(1)
                buscafila=contf(jjm);
                %                 buscacolumna=contc(jjm);
                %RANGO
                fprintf(fileid,'RANGO\n');
                %Imprimimos la ID
                fprintf(fileid,'%i\n',id_r(buscafila));
                %Imprimimos tiempo de entrada
                fprintf(fileid,'%1.2f\n',t_r_ini(buscafila,1));
                %Imprimimos tiempo de salida
                fprintf(fileid,'%1.2f\n\n',t_r_end(buscafila,1));
                %Limpiamos cuando haya acabado
                xt_r(buscafila,:)=-1;
                yt_r(buscafila,:)=-1;
                t_r(buscafila,:)=-1;
                t_r_ini(buscafila)=-1;
                t_r_end(buscafila)=-1;
                id_r(buscafila)=-1;
            end
        end
    end
end

%Cerrando el txt
fclose(fileid);

time_finish=toc;
if(time_finish>60)
    minuto_finish=0;
    while(time_finish>=60)
        time_finish=time_finish-60;
        minuto_finish=minuto_finish+1;
    end
    fprintf('\nTiempo empleado en la simulación: %i minutos y %i segundos',minuto_finish,round(time_finish));
else
    fprintf('\nTiempo empleado en la simulación: %i segundos',round(time_finish));
end

if(tf>60)
    minuto_simu=0;
    hora_simu=0;
    while(tf>=60)
        tf=tf-60;
        minuto_simu=minuto_simu+1;
    end
    if(minuto_simu>60)
        while(minuto_simu>=60)
            minuto_simu=minuto_simu-60;
            hora_simu=hora_simu+1;
        end
    end
    fprintf('\nTiempo virtual simulado: %i horas %i minutos y %i segundos\n',hora_simu,minuto_simu,tf);
else
    fprintf('\nTiempo virtual simulado: %i segundos\n',tf);
end


