clear; 
clc;   
close all; 

figure(1); 
axis equal; 
axis([0 5 0 5]);
grid on; 
hold on; 

[punti_G, ~] = inserisci_punti(10); 
nodi_G = scelta_knots_bspline(3, size(punti_G, 1)); 
valori_t_G = linspace(nodi_G(3 + 1), nodi_G(size(punti_G, 1) + 1), 500); 
curva_G = de_boor(punti_G, nodi_G, valori_t_G); 

figure(1); 
clf; 
plot(curva_G(:,1), curva_G(:,2), 'k-', 'LineWidth', 2); 
hold on; 
axis equal; 
axis([0 5 0 5]); 
grid on; 
drawnow; 

[punti_controllo_L, ~] = inserisci_punti(7); 
nodi_L = scelta_knots_bspline(3, size(punti_controllo_L, 1)); 
valori_t_L = linspace(nodi_L(3 + 1), nodi_L(size(punti_controllo_L, 1) + 1), 500); 
curva_L = de_boor(punti_controllo_L, nodi_L, valori_t_L); 

figure(1); 
clf; 
plot(curva_G(:,1), curva_G(:,2), 'k-', 'LineWidth', 2); 
hold on; 
plot(curva_L(:,1), curva_L(:,2), 'k-', 'LineWidth', 2); 
axis equal; 
axis([0 5 0 5]);
grid on; 
drawnow; 

%% Funzione per inserire i punti

function [punti_inseriti, handle_plot] = inserisci_punti( numero_punti )
    figure(gcf) 
    axis equal 
    axis([0 5 0 5]) 
    hold on 

    punti_inseriti = zeros(numero_punti, 2);
    punti_inseriti(1,:) = ginput(1); 
    handle_plot = plot(punti_inseriti(1,1), punti_inseriti(1,2),'.b','Markersize',12); 

    for i = 2:numero_punti 
        punti_inseriti(i,:) = ginput(1);
        set(handle_plot,'Visible','off'); 
        handle_plot = plot(punti_inseriti(1:i,1), punti_inseriti(1:i,2),'.:b','Markersize',12,'LineWidth',1); 
    end
end

%% Funzione per la scelta dei nodi B-spline

function knots = scelta_knots_bspline(grado, n_punti)

if grado >= n_punti
    error('Il grado deve essere minore del numero di punti di controllo.');
end

n_knots = n_punti + grado + 1;
knots = zeros(1, n_knots);

for i = 1:n_knots
    if i <= grado + 1
        knots(i) = 0;
    elseif i >= n_knots - grado
        knots(i) = n_punti - grado;
    else
        knots(i) = i - grado - 1;
    end
end
end

%% Funzione di De Boor per calcolare la curva

function C = de_boor( P, ti, t )

[n,d] = size(P);
m = length(ti);   
k = m-n-1;
if nargin==2
    t = linspace(ti(k+1),ti(n+1),501)';
else
    t = t(:);
    if t(1)<ti(k+1) || t(end)>ti(n+1)
        error('ho scelto valori fuori dell''intervallo di definizione')
    end
end
m = length(t);

C = zeros(m,d);
for i = 1:m
    j = find(t(i)>=ti(1:end-1) & t(i)<ti(2:end));
    if t(i)==ti(n+1)
        j = find(t(i)>=ti(1:end-1) & t(i)<=ti(2:end),1,'first');
    end
    P1 = P(j-k:j,:);
    for s = 0:k-1 
        a = (t(i)-ti(j-k+s+1:j))./(ti(j+1:j+k-s)-ti(j-k+s+1:j));
        P1 = diag(1-a)*P1(1:end-1,:)+diag(a)*P1(2:end,:);
    end
    C(i,:) = P1;
end
end