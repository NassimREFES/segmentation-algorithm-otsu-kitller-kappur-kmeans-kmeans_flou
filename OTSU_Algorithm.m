function MX = OTSU_Algorithm( img )
    I = unique(img);
    N = frequence(img, I);

    seuil = 0;
    intra_classe = Inf;

    for i = 2 : size(I, 1)
        %classe 1
        u1 = moyenne(I, N, 1, i-1);
        v1 = variance(I, N, 1, i-1, u1);
        p1 = prob(img, I, 1, i-1);

        %classe 2
        u2 = moyenne(I, N, i, size(I, 1));
        v2 = variance(I, N, i, size(I, 1), u2);
        p2 = prob(img, I, i, size(I, 1));

        % intra classe
        ic = p1*v1 + p2*v2;
        if ic < intra_classe
            intra_classe = ic;
            seuil = I(i);
        end
    end

    intra_classe
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

