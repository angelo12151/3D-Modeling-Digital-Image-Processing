clear 
clc

img_originale = imread('paesaggio.jpg');
img_double = im2double(img_originale);
figure;
imshow(img_originale);
title('Immagine Originale');

%% Applicazione del Filtro Negativo 
img_negativo = 255 - img_originale;
figure;
subplot(1, 2, 1);
imshow(img_originale);
title('Prima (Originale)');
subplot(1, 2, 2);
imshow(img_negativo);
title('Dopo: Filtro Negativo (y = 255 - x)');
imwrite(img_negativo, 'paesaggio_negativo.jpg');

%% Applicazione del Filtro Esponenziale 
k = log(256) / 255; 
img_esponenziale = (exp(img_double * k * 255) - 1) / 255;
figure;
subplot(1, 2, 1);
imshow(img_originale);
title('Prima (Originale)');
subplot(1, 2, 2);
imshow(img_esponenziale);
title('Dopo: Filtro Esponenziale');
imwrite(img_esponenziale, 'paesaggio_esponenziale.jpg');

%% 4. Applicazione del Filtro per la Riduzione del Numero di Colori
k_colori = 8;
img_riduzione_colori = floor(img_double * (k_colori - 1)) / (k_colori - 1);
figure;
subplot(1, 2, 1);
imshow(img_originale);
title('Prima (Originale)');
subplot(1, 2, 2);
imshow(img_riduzione_colori);
title(sprintf('Dopo: Riduzione Colori (k = %d)', k_colori));
imwrite(img_riduzione_colori, sprintf('paesaggio_riduzione_colori_k%d.jpg', k_colori));

%% 5. Applicazione del Filtro "Contrasto Semplice" 
% Filtro per aumentare il contrasto:
% y = m * (x - 0.5) + 0.5, dove m > 1 aumenta il contrasto.
% La sottrazione in parentesi sposta il range di valori da -0.5 a 0.5
% la moltiplicazione per m = 1.5 applica il contrasto
% la somma finale riporta l'intervallo dei valori da 0 a 1
img_contrasto_semplice = 1.5 * (img_double - 0.5) + 0.5;
figure;
subplot(1, 2, 1);
imshow(img_originale);
title('Prima (Originale)');
subplot(1, 2, 2);
imshow(img_contrasto_semplice);
title('Dopo: Filtro Contrasto Semplice');
imwrite(img_contrasto_semplice, 'paesaggio_contrasto_semplice.jpg');