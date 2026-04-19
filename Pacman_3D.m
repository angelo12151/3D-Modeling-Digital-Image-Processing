clear;
close all;
clc;

figure(1);
hold on;
axis equal;
title('Pac-Man 3D'); 
view(3);

a = 2; % Raggio lungo l'asse X
b = 2; % Raggio lungo l'asse Y
c = 2; % Raggio lungo l'asse Z 

% --- Bocca ---

gradi_apertura_bocca = 70; 
radianti_apertura_bocca = deg2rad(gradi_apertura_bocca); 

num_punti_u = 100;
num_punti_v = 50;
u = linspace(radianti_apertura_bocca / 2, 2*pi - radianti_apertura_bocca / 2, num_punti_u);
v = linspace(0, pi, num_punti_v);

[U, V] = meshgrid(u, v);
X_corpo = a * cos(U) .* sin(V);
Y_corpo = b * sin(U) .* sin(V);
Z_corpo = c * cos(V);

% --- Corpo ---
corpo = surf(X_corpo, Y_corpo, Z_corpo);
set(corpo, 'FaceColor', 'yellow', 'EdgeColor', 'none');
alpha(corpo, 1.0); 

% --- Superfici per chiusura bocca --- 

num_punti_radiali = 2; 
punti_radiali = linspace(0, a, num_punti_radiali); 

% Superficie 1 (lato superiore dello spicchio):

angolo_sup1 = radianti_apertura_bocca / 2;
[R_mesh, V_mesh] = meshgrid(punti_radiali, v);
U = angolo_sup1 * ones(size(R_mesh));

X_sup1 = R_mesh .* cos(U) .* sin(V_mesh);
Y_sup1 = R_mesh .* sin(U) .* sin(V_mesh);
Z_sup1 = R_mesh .* cos(V_mesh);

sup1 = surf(X_sup1, Y_sup1, Z_sup1);
set(sup1, 'FaceColor', 'black', 'EdgeColor', 'none');
alpha(sup1, 1.0); 

% Superficie 2 (lato inferiore dello spicchio):

angolo_sup2 = 2*pi - radianti_apertura_bocca / 2;
U_face2_mesh = angolo_sup2 * ones(size(R_mesh));

X_face2 = R_mesh .* cos(U_face2_mesh) .* sin(V_mesh);
Y_face2 = R_mesh .* sin(U_face2_mesh) .* sin(V_mesh);
Z_face2 = R_mesh .* cos(V_mesh);

h_face2 = surf(X_face2, Y_face2, Z_face2);
set(h_face2, 'FaceColor', 'black', 'EdgeColor', 'none');
alpha(h_face2, 1.0); 

% --- Occhi ---

raggio_occhi = 0.3;
num_punti_occhi_u = 30;
num_punti_occhi_v = 30;
u_occhi = linspace(0, 2*pi, num_punti_occhi_u);
v_occhi = linspace(0, pi, num_punti_occhi_v);
[U_occhi, V_occhi] = meshgrid(u_occhi, v_occhi);
X_occhio_base = raggio_occhi * cos(U_occhi) .* sin(V_occhi);
Y_occhio_base = raggio_occhi * sin(U_occhi) .* sin(V_occhi);
Z_occhio_base = raggio_occhi * cos(V_occhi);

% Primo occhio

occhio1_x = 0.377298;
occhio1_y = 1.24034;
occhio1_z = 1.52289;
X_occhio1 = X_occhio_base + occhio1_x;
Y_occhio1 = Y_occhio_base + occhio1_y;
Z_occhio1 = Z_occhio_base + occhio1_z;
occhio1 = surf(X_occhio1, Y_occhio1, Z_occhio1);
set(occhio1, 'FaceColor', 'black', 'EdgeColor', 'none');
alpha(occhio1, 1.0);

% Secondo occhio 

occhio2_x = occhio1_x;
occhio2_y = occhio1_y;
occhio2_z = -occhio1_z; 
X_occhio2 = X_occhio_base + occhio2_x;
Y_occhio2 = Y_occhio_base + occhio2_y;
Z_occhio2 = Z_occhio_base + occhio2_z;
occhio2 = surf(X_occhio2, Y_occhio2, Z_occhio2);
set(occhio2, 'FaceColor', 'black', 'EdgeColor', 'none');
alpha(occhio2, 1.0); 

% light;
% lighting gouraud; 
axis tight; 
hold off;