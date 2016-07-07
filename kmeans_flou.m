clear all;
close all;
clc;

img = [13    13    12    12    12    11    11    11;
    13    12    12    12    11    11    11    10;
    12    12     8     7     6     5    10    10;
    12    12     7     6     5     4    10    10;
    12    11     6     5     4     3    10     9;
    11    11     5     4     3     2     9     9;
    11    11    10    10    10     9     9     9;
    11    10    10    10     9     9     9     8]

%img = imread('/home/n3/matlab/toolbox/images/imdemos/cameraman.tif');
%figure : imshow(img)
%img = double(img);
I = unique(img);
I(:, 2) = frequence(img, I);

% I = [ 1 7; 2 5; 3 8; 4 5 ];

K = 2;

C = partitions(size(I, 1), K)
% C = [ 1 6 12 ]
L = zeros(K,2);

for i=2:K+1
    x = C(1,i-1);
    y = C(1, i);
    if 2 < i  x = x + 1;  end
    L(i-1, 1) = sum(I(x:y, 1))/(y-x+1);
    L(i-1, 2) = sum(I(x:y, 2))/(y-x+1);
end

L
LL = L;

more = 1;

count = 1;

EPSILON = 0.01;

% calculer les distances
    D = zeros(size(I, 1), size(LL, 1));
    for i=1:size(I, 1)
        for j=1:size(LL, 1)
            D(i, j) = distance_hamming(LL(j, :), I(i, :));
        end
    end

    D

% calcule de Uik ( degrée d'appartenance )
    Uik = [];
    for i=1:size(D, 2)
        for j=1:size(D, 1)
            sum_ = 0;
            for v=1:size(D, 2)
                if D(j, v) ~= 0
                    sum_ = sum_ + (D(j, i)/D(j, v))^(2/(K-1));
                end
            end
            if sum_ ~= 0
                sum_ = 1/sum_;
            end
            Uik(j,i) = sum_;
        end
    end
    
    Uik

while more  
    % mise a jour des centres
    for i=1:K
        LL(i, 1) = sum((Uik(:, i).^K).*I(:, 1))/sum((Uik(:, i).^K));
        LL(i, 2) = sum((Uik(:, i).^K).*I(:, 2))/sum((Uik(:, i).^K));
    end
    
    LL
    
    % recalculer les distances
    DD = zeros(size(I, 1), size(LL, 1));
    for i=1:size(I, 1)
        for j=1:size(LL, 1)
            DD(i, j) = distance_hamming(LL(j, :), I(i, :));
        end
    end

    DD
    
    % calcule de Uik1 ( degrée d'appartenance )
    Uik1 = [];
    for i=1:size(DD, 2)
        for j=1:size(DD, 1)
            sum_ = 0;
            for v=1:size(DD, 2)
                sum_ = sum_ + (DD(j, i)/DD(j, v))^(2/(K-1));
            end
            sum_ = 1/sum_;
            Uik1(j,i) = sum_;
        end
    end
    
    % calculer la diff entres les degrée d'appartenance
    Uik
    Uik1
    diff_Uik = abs(Uik1 - Uik)
    
    condition = find(diff_Uik>EPSILON);
    
    if size(condition, 1) == 0 || size(condition, 2) == 0
        more = false;
    end
    
    Uik = Uik1;
    
    count = count + 1
end

% choix des min
FF = zeros(size(D, 1), size(D, 2));
for i=1:size(Uik, 1)
   min_ = min(Uik(i, :));
    for j=1:size(Uik, 2)
        if Uik(i, j) == min_
            FF(i, j) = i;
        end
    end
end

FFx = FF;

FFx
seuil = 0;
add_seuil = floor(255/K)

img

for i=1:size(FFx, 2)
    for ii=1:size(img, 1)
        for jj=1:size(img, 2)
            for k=1:size(FFx, 1)
                if FFx(k, i) ~= 0
                    if img(ii, jj) - I(FFx(k, i), 1) == 0
                        img(ii, jj) = seuil;
                    end
                end
            end
        end
    end
    seuil = seuil + add_seuil;
end

%figure : imshow(img)
img