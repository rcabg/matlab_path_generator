%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Parámetros %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%Escenario%%%%%%
%(todo en metros)

%Escenario general
anchura_escenario=9;
altura_escenario=7;

%Escenario zona cámara
anchura_camara=anchura_escenario;
dif_altura_camara=1.5;

%Margen en la representación
margen_repr_esc=0.5;

%Margen de entrada y salida
margen_inout=0.5;

%%%%%%Tiempo%%%%%%

%Paso de tiempo
tp=0.01; %segundos

%Tiempo final en segundos
tf=60*60;

%Tiempo de lectura de sensores discreto
t_lect_sensores=0.5;

%%%%%%Trayectorias%%%%%%

%(todas las probabilidades en tanto por uno)

%Numero de personas (matrix) máximo
mat_per_max=50;

%Factor de conversión km/h a m/s
fconv_veloc=1000/3600;

%Probabilidad de inclinacion
prob_inc=0.1;

%Margen de salida
margen_out=0.75;

%Max número de muestras
Nmax=23;

%Min número de muestras
Nmin=17;

%Probabilidad de persona corriendo
prob_corr=0.02;

%Velocidad max persona corriendo
Vmax_corr=8.5*fconv_veloc;

%Velocidad min persona corriendo
Vmin_corr=5*fconv_veloc;

%Velocidad max persona andando
Vmax_and=3.5*fconv_veloc;

%Velocidad min persona andando
Vmin_and=2.8*fconv_veloc;

%Ruido máximo cámara
n_c_max=0.12;

%Ruido mínimo cámara
n_c_min=0.08;

%Ruido máximo rango
n_r_max=0.4;

%Ruido mínimo rango
n_r_min=0.3;

%%%%%%Creación de personas%%%%%%

%Probabilidad de intruso
prob_intruso=0.1;

%Probabilidad de que entre
prob_in=0.50;

%Momento de primer intento de creación
t_prox=0.5;

%Tiempo de espera máximo si se ha creado persona
t_esp_in_max=5;

%Tiempo de espera si NO se ha creado persona
t_esp_no_max=4;
