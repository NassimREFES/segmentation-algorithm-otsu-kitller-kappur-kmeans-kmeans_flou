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
I = unique(img);
I(:, 2) = frequence(img, I);

K = 2;

C = partitions(size(I, 1), K)
% C = [ 1 6 12 ]
L = zeros(K,2);

for i=2:K+1
    x = C(1,i-1);
    y = C(1, i);
    if 2 < i  x = x + 1;  end
    x
    y
    L(i-1, 1) = sum(I(x:y, 1))/(y-x+1);
    L(i-1, 2) = sum(I(x:y, 2))/(y-x+1);
end

L
LL = L;

more = 1;

while more
    L = LL;
    % calculer les distances
    D = zeros(size(I, 1), size(LL, 1));
    for i=1:size(I, 1)
        for j=1:size(LL, 1)
            D(i, j) = distance_hamming(LL(j, :), I(i, :));
        end
    end

    D
    % choisir les min s 
    FF = zeros(size(D, 1), size(D, 2));
    for i=1:size(D, 1)
        min_ = min(D(i, :));
        for j=1:size(D, 2)
            if D(i, j) == min_
                FF(i, j) = i;
            end
        end
    end
    
    %FF
    FFx = FF;
    TT = zeros(1, K);
    % recalculer le nouveau L
    for i=1:size(LL, 1)
        LL(i, 1) = 0;
        LL(i, 2) = 0;
            for k=1:size(FF, 1)
                if FF(k, i) ~= 0
                    LL(i, 1) = LL(i, 1) + I(FF(k, i), 1);
                    LL(i, 2) = LL(i, 2) + I(FF(k, i), 2);
                    FF(k, i) = 1; % nombre d'element
                end
            end

        LL(i, 1) = LL(i, 1)/sum(FF(:, i));
        LL(i, 2) = LL(i, 2)/sum(FF(:, i));
    end
    
    LL
    
    i = 1;
    j = 1;
    while i < size(LL, 1)
        j = 1;
        while j < size(LL, 2)
            if LL(i, j) ~= L(i, j)
                break;
            end
            j = j + 1;
        end
        if j ~= size(LL, 2)
            break;
        end
        i = i + 1;
    end
    
    % si le precedent L == le nouveau L alor on arrete
    
    if i == size(LL, 1) && j == size(LL, 2)
        more = false;
    end
end

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

% figure : imshow(img)
img