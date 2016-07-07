function MX = KITLLER_Algorithm( img )
    I = unique(img);
    N = frequence(img, I);

    seuil = 0;
    erreur = Inf;

    for i = 2 : size(I, 1)
        %classe 1
        u1 = moyenne(I, N, 1, i-1);
        v1 = variance(I, N, 1, i-1, u1);
        p1 = prob(img, I, 1, i-1);

        %classe 2
        u2 = moyenne(I, N, i, size(I, 1));
        v2 = variance(I, N, i, size(I, 1), u2);
        p2 = prob(img, I, i, size(I, 1));

        % l'erreur
            gt = 1 + 2*(p1*log2(v1)+p2*log2(v2))-2*(p1*log2(p1)+p2*log2(p2))
            if gt < erreur && gt ~= -Inf
                erreur = gt;
                seuil = I(i);
            end
    end
    
    erreur
    seuil
  
    for i=1:size(img, 1)
        for j=1:size(img, 2)
            if img(i, j) < seuil
                img(i, j) = 0;
            else
                img(i, j) = 255;
            end
        end
    end
    
    MX = img;
end

