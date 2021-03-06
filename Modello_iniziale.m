clc 
close all
clear all

%% LETTURA DATI
tab = readtable('caricoITAday.xlsx', 'Range', 'A2:C732');
giorni_settimana= tab.giorno_settimana;
dati = tab.dati;
giorni_anno = tab.giorno_anno;

g = [1:730]';

%Metodo per risolvere NaN 
dati = interp1(g(~isnan(dati)), dati(~isnan(dati)), g, 'linear');

%PLOT DI TUTTI I DATI
figure(1)
plot(dati)
title("DATI")
xlabel("Giorno anno");
ylabel("Consumo energetico [GW]");
grid on

%PLOT TREND
figure(2)
plot(dati)
title("TREND")
xlabel("Giorno anno");
ylabel("Consumo energetico [GW]");
hold on

%% DETRENDIZZAZIONE DATI
%Togliamo il trend per "limare" gli errori e rendere migliore l' andamento
uni = ones(730,1);
n = length(uni);

giorni = [1:730]';

Phi_trend = [uni giorni];

ThetaLS_trend = Phi_trend\dati;

y_trend = Phi_trend * ThetaLS_trend;

dati = dati - y_trend;

plot(y_trend)
grid on

%DATI PER MODELLO(PRIMO ANNO)
giorni_anno_modello = giorni_anno(1:365);
giorni_settimana_modello = giorni_settimana(1:365);
dati_modello = dati(1:365);

%DATI PER VALIDAZIONE(SECONDO ANNO)
giorni_anno_validazione = giorni_anno(366:730);
giorni_settimana_validazione = giorni_settimana(366:730);
dati_validazione = dati(366:730);

%% MODELLI 
%MODELLO PERIODICIT� SETTIMANALE
% Nelle serie di fourier abbiamo sin(n*w*x) e cos(n*w*x) dove w=2pi/Periodo
% ed n � il grado

%Il periodo � di 7 giorni
w_settimanale = 2*pi/7;

%Avendo detrendizzato, non serve pi� fare la prima colonna di uni
Phi_settimanale = [cos(w_settimanale*giorni_settimana_modello) sin(w_settimanale*giorni_settimana_modello) ...
    cos(2*w_settimanale*giorni_settimana_modello) sin(2*w_settimanale*giorni_settimana_modello) ...
    cos(3*w_settimanale*giorni_settimana_modello) sin(3*w_settimanale*giorni_settimana_modello)];

ThetaLS_settimanale = Phi_settimanale\dati_modello;

y_settimanale= Phi_settimanale * ThetaLS_settimanale;

epsilon_settimanale = dati_modello - y_settimanale;

%MODELLO PERIODICIT� ANNUALE
w_annuale = 2*pi/365;

Phi_annuale1 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello)];

Phi_annuale2 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello)];

Phi_annuale3 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello)];

Phi_annuale4 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello)];

Phi_annuale5 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello)];

Phi_annuale6 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello)];

Phi_annuale7 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello)];

Phi_annuale8 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello) ...
    cos(8*w_annuale*giorni_anno_modello) sin(8*w_annuale*giorni_anno_modello)];

Phi_annuale9 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello) ...
    cos(8*w_annuale*giorni_anno_modello) sin(8*w_annuale*giorni_anno_modello) ... 
    cos(9*w_annuale*giorni_anno_modello) sin(9*w_annuale*giorni_anno_modello)];

Phi_annuale10 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello) ...
    cos(8*w_annuale*giorni_anno_modello) sin(8*w_annuale*giorni_anno_modello) ... 
    cos(9*w_annuale*giorni_anno_modello) sin(9*w_annuale*giorni_anno_modello) ...
    cos(10*w_annuale*giorni_anno_modello) sin(10*w_annuale*giorni_anno_modello)];

Phi_annuale11 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello) ...
    cos(8*w_annuale*giorni_anno_modello) sin(8*w_annuale*giorni_anno_modello) ... 
    cos(9*w_annuale*giorni_anno_modello) sin(9*w_annuale*giorni_anno_modello) ...
    cos(10*w_annuale*giorni_anno_modello) sin(10*w_annuale*giorni_anno_modello) ...
    cos(11*w_annuale*giorni_anno_modello) sin(11*w_annuale*giorni_anno_modello)];

Phi_annuale12 = [cos(w_annuale*giorni_anno_modello) sin(w_annuale*giorni_anno_modello) ... 
    cos(2*w_annuale*giorni_anno_modello) sin(2*w_annuale*giorni_anno_modello) ... 
    cos(3*w_annuale*giorni_anno_modello) sin(3*w_annuale*giorni_anno_modello) ...
    cos(4*w_annuale*giorni_anno_modello) sin(4*w_annuale*giorni_anno_modello) ...
    cos(5*w_annuale*giorni_anno_modello) sin(5*w_annuale*giorni_anno_modello) ...
    cos(6*w_annuale*giorni_anno_modello) sin(6*w_annuale*giorni_anno_modello) ...
    cos(7*w_annuale*giorni_anno_modello) sin(7*w_annuale*giorni_anno_modello) ...
    cos(8*w_annuale*giorni_anno_modello) sin(8*w_annuale*giorni_anno_modello) ... 
    cos(9*w_annuale*giorni_anno_modello) sin(9*w_annuale*giorni_anno_modello) ...
    cos(10*w_annuale*giorni_anno_modello) sin(10*w_annuale*giorni_anno_modello) ...
    cos(11*w_annuale*giorni_anno_modello) sin(11*w_annuale*giorni_anno_modello) ...
    cos(12*w_annuale*giorni_anno_modello) sin(12*w_annuale*giorni_anno_modello)];

%Y=Phi * Theta ---> Essendo matrici: Theta = Phi inversa * Y
ThetaLS_annuale1 = Phi_annuale1\epsilon_settimanale;
ThetaLS_annuale2 = Phi_annuale2\epsilon_settimanale;
ThetaLS_annuale3 = Phi_annuale3\epsilon_settimanale;
ThetaLS_annuale4 = Phi_annuale4\epsilon_settimanale;
ThetaLS_annuale5 = Phi_annuale5\epsilon_settimanale;
ThetaLS_annuale6 = Phi_annuale6\epsilon_settimanale;
ThetaLS_annuale7 = Phi_annuale7\epsilon_settimanale;
ThetaLS_annuale8 = Phi_annuale8\epsilon_settimanale;
ThetaLS_annuale9 = Phi_annuale9\epsilon_settimanale;
ThetaLS_annuale10 = Phi_annuale10\epsilon_settimanale;
ThetaLS_annuale11 = Phi_annuale11\epsilon_settimanale;
ThetaLS_annuale12 = Phi_annuale12\epsilon_settimanale;
%ThetaLS modellizza i coefficienti a0, an, bn con n che va da 1 al grado
%scelto per la serie(ovvero il numero di armoniche)

y_annuale1= Phi_annuale1 * ThetaLS_annuale1;
y_annuale2= Phi_annuale2 * ThetaLS_annuale2;
y_annuale3= Phi_annuale3 * ThetaLS_annuale3;
y_annuale4= Phi_annuale4 * ThetaLS_annuale4;
y_annuale5= Phi_annuale5 * ThetaLS_annuale5;
y_annuale6= Phi_annuale6 * ThetaLS_annuale6;
y_annuale7= Phi_annuale7 * ThetaLS_annuale7;
y_annuale8= Phi_annuale8 * ThetaLS_annuale8;
y_annuale9= Phi_annuale9* ThetaLS_annuale9;
y_annuale10= Phi_annuale10* ThetaLS_annuale10;
y_annuale11= Phi_annuale11* ThetaLS_annuale11;
y_annuale12= Phi_annuale12* ThetaLS_annuale12;

epsilon_annuale1 = dati_modello - y_annuale1;
epsilon_annuale2 = dati_modello - y_annuale2;
epsilon_annuale3 = dati_modello - y_annuale3;
epsilon_annuale4 = dati_modello - y_annuale4;
epsilon_annuale5 = dati_modello - y_annuale5;
epsilon_annuale6 = dati_modello - y_annuale6;
epsilon_annuale7 = dati_modello - y_annuale7;
epsilon_annuale8 = dati_modello - y_annuale8;
epsilon_annuale9 = dati_modello - y_annuale9;
epsilon_annuale10 = dati_modello - y_annuale10;
epsilon_annuale11 = dati_modello - y_annuale11;
epsilon_annuale12 = dati_modello - y_annuale12;

SSR_annuale1 = epsilon_annuale1'*epsilon_annuale1;
SSR_annuale2 = epsilon_annuale2'*epsilon_annuale2;
SSR_annuale3 = epsilon_annuale3'*epsilon_annuale3;
SSR_annuale4 = epsilon_annuale4'*epsilon_annuale4;
SSR_annuale5 = epsilon_annuale5'*epsilon_annuale5;
SSR_annuale6 = epsilon_annuale6'*epsilon_annuale6;
SSR_annuale7 = epsilon_annuale7'*epsilon_annuale7;
SSR_annuale8 = epsilon_annuale8'*epsilon_annuale8;
SSR_annuale9 = epsilon_annuale9'*epsilon_annuale9;
SSR_annuale10 = epsilon_annuale10'*epsilon_annuale10;
SSR_annuale11 = epsilon_annuale11'*epsilon_annuale11;
SSR_annuale12 = epsilon_annuale12'*epsilon_annuale12;

%% VALIDAZIONE
%PHI VALIDAZIONE
Phi_validazione = [cos(w_settimanale*giorni_settimana_validazione) sin(w_settimanale*giorni_settimana_validazione) ...
    cos(2*w_settimanale*giorni_settimana_validazione) sin(2*w_settimanale*giorni_settimana_validazione) ...
    cos(3*w_settimanale*giorni_settimana_validazione) sin(3*w_settimanale*giorni_settimana_validazione)];

y_validazione = Phi_validazione * ThetaLS_settimanale;

%Usiamo y_annuale perch� non avrebbe senso fare una y_validazione_annuale
%dato che sarebbe identica dato che sarebbe da una phi in cui utlizzeremmo
%giorni_anno_validazione dentro a sin e cos che sono uguali a giorni_anno_modello
y_fin1 = y_annuale1 + y_validazione;
y_fin2 = y_annuale2 + y_validazione;
y_fin3 = y_annuale3 + y_validazione;
y_fin4 = y_annuale4 + y_validazione;
y_fin5 = y_annuale5 + y_validazione;
y_fin6 = y_annuale6 + y_validazione;
y_fin7 = y_annuale7 + y_validazione;
y_fin8 = y_annuale8 + y_validazione;
y_fin9 = y_annuale9 + y_validazione;
y_fin10 = y_annuale10 + y_validazione;
y_fin11 = y_annuale11 + y_validazione;
y_fin12 = y_annuale12 + y_validazione;

%TEST AIC
q1 = length(ThetaLS_annuale1);
aic1 = 2*q1/n + log(SSR_annuale1);

q2 = length(ThetaLS_annuale2);
aic2 = 2*q2/n + log(SSR_annuale2);

q3 = length(ThetaLS_annuale3);
aic3 = 2*q3/n + log(SSR_annuale3);

q4 = length(ThetaLS_annuale4);
aic4 = 2*q4/n + log(SSR_annuale4);

q5 = length(ThetaLS_annuale5);
aic5 = 2*q5/n + log(SSR_annuale5);

q6 = length(ThetaLS_annuale6);
aic6 = 2*q6/n + log(SSR_annuale6);

q7 = length(ThetaLS_annuale7);
aic7 = 2*q7/n + log(SSR_annuale7);

q8 = length(ThetaLS_annuale8);
aic8 = 2*q8/n + log(SSR_annuale8);

q9 = length(ThetaLS_annuale9);
aic9 = 2*q9/n + log(SSR_annuale9);

q10 = length(ThetaLS_annuale10);
aic10 = 2*q10/n + log(SSR_annuale10);

q11 = length(ThetaLS_annuale11);
aic11 = 2*q11/n + log(SSR_annuale11);

q12 = length(ThetaLS_annuale12);
aic12 = 2*q12/n + log(SSR_annuale12);

%CROSSVALIDAZIONE
epsilon_validazione1 = dati_validazione - y_fin1;
SSR_validazione1 = epsilon_validazione1'*epsilon_validazione1;

epsilon_validazione2 = dati_validazione - y_fin2;
SSR_validazione2 = epsilon_validazione2'*epsilon_validazione2;

epsilon_validazione3 = dati_validazione - y_fin3;
SSR_validazione3 = epsilon_validazione3'*epsilon_validazione3;

epsilon_validazione4 = dati_validazione - y_fin4;
SSR_validazione4 = epsilon_validazione4'*epsilon_validazione4;

epsilon_validazione5 = dati_validazione - y_fin5;
SSR_validazione5 = epsilon_validazione5'*epsilon_validazione5;

epsilon_validazione6 = dati_validazione - y_fin6;
SSR_validazione6 = epsilon_validazione6'*epsilon_validazione6;

epsilon_validazione7 = dati_validazione - y_fin7;
SSR_validazione7 = epsilon_validazione7'*epsilon_validazione7;

epsilon_validazione8 = dati_validazione - y_fin8;
SSR_validazione8 = epsilon_validazione8'*epsilon_validazione8;

epsilon_validazione9 = dati_validazione - y_fin9;
SSR_validazione9 = epsilon_validazione9'*epsilon_validazione9;

epsilon_validazione10 = dati_validazione - y_fin10;
SSR_validazione10 = epsilon_validazione10'*epsilon_validazione10;

epsilon_validazione11 = dati_validazione - y_fin11;
SSR_validazione11 = epsilon_validazione11'*epsilon_validazione11;

epsilon_validazione12 = dati_validazione - y_fin12;
SSR_validazione12 = epsilon_validazione12'*epsilon_validazione12;

%MODELLO 10 � IL MIGLIORE PER LA CROSSVALIDAZIONE

%% MODELLO TOTALE
Phi_totale = [Phi_settimanale Phi_annuale10];

ThetaLS_totale = Phi_totale\dati_modello;

y_totale = Phi_totale * ThetaLS_totale;

Phi_tot_val = [Phi_validazione Phi_annuale10];

y_tot_fin = Phi_tot_val * ThetaLS_totale;

figure(3);
title('VALIDAZIONE MODELLO (SU DATI SECONDO ANNO)')
xlabel("Giorno anno");
ylabel("Consumo energetico [GW]");
hold on
grid on
plot(giorni_anno_validazione, dati_validazione)
plot(y_tot_fin);

epsilon_tot_val = dati_validazione - y_tot_fin;
SSR_tot_val = (epsilon_tot_val') * epsilon_tot_val;

MSE = immse(dati_validazione, y_tot_fin);
RMSE = sqrt(MSE);

%% PLOT 3D
g = [1:7]';
[GA,GS] = meshgrid(giorni_anno_modello, g);

Phi_ext = [cos(w_settimanale*GS(:)) sin(w_settimanale*GS(:)) ...
    cos(2*w_settimanale*GS(:)) sin(2*w_settimanale*GS(:)) ...
    cos(3*w_settimanale*GS(:)) sin(3*w_settimanale*GS(:)) ...
    cos(w_annuale*GA(:)) sin(w_annuale*GA(:)) ... 
    cos(2*w_annuale*GA(:)) sin(2*w_annuale*GA(:)) ... 
    cos(3*w_annuale*GA(:)) sin(3*w_annuale*GA(:)) ...
    cos(4*w_annuale*GA(:)) sin(4*w_annuale*GA(:)) ...
    cos(5*w_annuale*GA(:)) sin(5*w_annuale*GA(:)) ...
    cos(6*w_annuale*GA(:)) sin(6*w_annuale*GA(:)) ...
    cos(7*w_annuale*GA(:)) sin(7*w_annuale*GA(:)) ...
    cos(8*w_annuale*GA(:)) sin(8*w_annuale*GA(:)) ... 
    cos(9*w_annuale*GA(:)) sin(9*w_annuale*GA(:)) ...
    cos(10*w_annuale*GA(:)) sin(10*w_annuale*GA(:))];

y_ext = Phi_ext * ThetaLS_totale;

y_ext_matrice = reshape(y_ext, size(GA));

figure(4)
plot3(giorni_anno_validazione, giorni_settimana_validazione,dati_validazione,'o')
title("MODELLO 3D")
xlabel('Giorno dell''anno')
ylabel('Giorno della settimana')
zlabel('Consumo energetico [GW]')
grid on
hold on
mesh (GA, GS, y_ext_matrice);

% PLOT EPSILON_TOT_VALIDAZIONE
figure(5)
plot(epsilon_tot_val)
title("EPSILON DI VALIDAZIONE")
xlabel("Giorno dell'anno")
ylabel("Entit� errore")
grid on

% ISTOGRAMMA EPSILON_TOT_VALIDAZIONE
figure(6);
histogram(epsilon_tot_val,20)
title("EPSILON DI VALIDAZIONE")
xlabel("Entit� errore")
ylabel("Frequenza errore")
grid on