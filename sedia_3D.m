clear
clc   
close all 

%% Funzione per creare un cilindro
% 'crea_cilindro' è una funzione che genera le coordinate per un cilindro
% Input:
%   - 'centro': vettore [x, y, z] che rappresenta il centro della base inferiore del cilindro.
%   - 'raggio': il raggio del cilindro.
%   - 'altezza': l'altezza del cilindro.
% Output:
%   - 'Xc', 'Yc', 'Zc': matrici di coordinate 

crea_cilindro = @(centro, raggio, altezza) deal( ...
    centro(1) + raggio * cos(linspace(0, 2*pi, 20))' * ones(1, 2), ...
    centro(2) + raggio * sin(linspace(0, 2*pi, 20))' * ones(1, 2), ...
    centro(3) + ones(20, 1) * [0, altezza]);

%% Parametri sedia

colore_legno = [0.76 0.60 0.42]; 
colore_metallo = [0.3 0.3 0.3]; 

% --- Seduta ---

origine_seduta = [0, 0, 0.3];
dimensioni_seduta = [0.4, 0.4, 0.05];

x_seduta = [0 1 1 0 0 1 1 0] * dimensioni_seduta(1) + origine_seduta(1);
y_seduta = [0 0 1 1 0 0 1 1] * dimensioni_seduta(2) + origine_seduta(2);
z_seduta = [0 0 0 0 1 1 1 1] * dimensioni_seduta(3) + origine_seduta(3);
vertici_seduta = [x_seduta' y_seduta' z_seduta'];
facce_seduta = [1 2 3 4;   % Faccia inferiore
                5 6 7 8;   % Faccia superiore
                1 2 6 5;   % Faccia frontale
                2 3 7 6;   % Faccia destra
                3 4 8 7;   % Faccia posteriore
                4 1 5 8];  % Faccia sinistra

% --- Schienale ---

origine_schienale = [0, dimensioni_seduta(2) - 0.05, origine_seduta(3) + dimensioni_seduta(3)];
dimensioni_schienale = [0.4, 0.05, 0.45];

x_schienale = [0 1 1 0 0 1 1 0] * dimensioni_schienale(1) + origine_schienale(1);
y_schienale = [0 0 1 1 0 0 1 1] * dimensioni_schienale(2) + origine_schienale(2);
z_schienale = [0 0 0 0 1 1 1 1] * dimensioni_schienale(3) + origine_schienale(3);
vertici_schienale = [x_schienale' y_schienale' z_schienale'];
facce_schienale = [1 2 3 4;
                   5 6 7 8;
                   1 2 6 5;
                   2 3 7 6;
                   3 4 8 7;
                   4 1 5 8];

% --- Braccioli ---

altezza_bracciolo = 0.05;
profondita_bracciolo = 0.05;
lunghezza_bracciolo = dimensioni_schienale(2);

% Bracciolo sinistro

origine_bracciolo_sinistro = [-0.05, 0.1, 0.45];
dimensioni_bracciolo_sinistro = [0.05, 0.3, 0.05];

x_bracciolo_sinistro = [0 1 1 0 0 1 1 0] * dimensioni_bracciolo_sinistro(1) + origine_bracciolo_sinistro(1);
y_bracciolo_sinistro = [0 0 1 1 0 0 1 1] * dimensioni_bracciolo_sinistro(2) + origine_bracciolo_sinistro(2);
z_bracciolo_sinistro = [0 0 0 0 1 1 1 1] * dimensioni_bracciolo_sinistro(3) + origine_bracciolo_sinistro(3);
vertici_bracciolo_sinistro = [x_bracciolo_sinistro' y_bracciolo_sinistro' z_bracciolo_sinistro'];
facce_bracciolo_sinistro = [1 2 3 4;
                      5 6 7 8;
                      1 2 6 5;
                      2 3 7 6;
                      3 4 8 7;
                      4 1 5 8];

% Bracciolo destro (simmetrico rispetto al sinistro)

x_sinistro = origine_bracciolo_sinistro(1);
larghezza = dimensioni_bracciolo_sinistro(1);
x_destro = 0.4 - (x_sinistro + larghezza); 

origine_bracciolo_destro = [x_destro, 0.1, 0.45];
dimensioni_bracciolo_destro = dimensioni_bracciolo_sinistro;

x_bracciolo_destro = [0 1 1 0 0 1 1 0] * dimensioni_bracciolo_destro(1) + origine_bracciolo_destro(1);
y_bracciolo_destro = [0 0 1 1 0 0 1 1] * dimensioni_bracciolo_destro(2) + origine_bracciolo_destro(2);
z_bracciolo_destro = [0 0 0 0 1 1 1 1] * dimensioni_bracciolo_destro(3) + origine_bracciolo_destro(3);
vertici_bracciolo_destro = [x_bracciolo_destro' y_bracciolo_destro' z_bracciolo_destro'];
facce_bracciolo_destro = [1 2 3 4;
                       5 6 7 8;
                       1 2 6 5;
                       2 3 7 6;
                       3 4 8 7;
                       4 1 5 8];

% --- Gambe (cilindri) ---

raggio_gamba = 0.015;
altezza_gamba = 0.3;
dist_gamba = 0.025;
centri_gambe = [
    origine_seduta(1) + dist_gamba,             origine_seduta(2) + dist_gamba,              0;
    origine_seduta(1) + dimensioni_seduta(1) - dist_gamba, origine_seduta(2) + dist_gamba,         0;
    origine_seduta(1) + dist_gamba,             origine_seduta(2) + dimensioni_seduta(2) - dist_gamba, 0;
    origine_seduta(1) + dimensioni_seduta(1) - dist_gamba, origine_seduta(2) + dimensioni_seduta(2) - dist_gamba, 0
];

%% Visualizzazione

figure; 
hold on; 
axis equal;
grid on; 
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Sedia 3D'); 

% Seduta

patch('Vertices', vertici_seduta, 'Faces', facce_seduta, ...
      'FaceColor', colore_legno, 'EdgeColor', 'none');

% Schienale

patch('Vertices', vertici_schienale, 'Faces', facce_schienale, ...
      'FaceColor', colore_legno * 0.9, 'EdgeColor', 'none');

% Braccioli

patch('Vertices', vertici_bracciolo_sinistro, 'Faces', facce_bracciolo_sinistro, ...
      'FaceColor', colore_legno * 0.95, 'EdgeColor', 'none');
patch('Vertices', vertici_bracciolo_destro, 'Faces', facce_bracciolo_destro, ...
      'FaceColor', colore_legno * 0.95, 'EdgeColor', 'none');

% Gambe 

for i = 1:4

    [Xc, Yc, Zc] = crea_cilindro(centri_gambe(i,:), raggio_gamba, altezza_gamba);
    surf(Xc, Yc, Zc, 'FaceColor', colore_metallo, 'EdgeColor', 'none');

end

view(3); 
camlight; 
lighting gouraud; 