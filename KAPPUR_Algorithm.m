function MX = KAPPUR_Algorithm( img , img2 )
    I = unique(img);
    N = frequence(img, I);
    P = N(:, :).*(1/size(img, 1)*size(img, 2));

    seuil = 0;
    T = -Inf;

    for i = 2 : size(I, 1)
        %classe 1
        p1 = sum(P(1:i-1, 1));
        h1 = 0;
        for j = 1 : i-1
            h1 = h1 + (P(j)/p1) * log2(P(j)/p1);
        end
        h1 = h1 * -1;
        
        %classe 2
        p2 = sum(P(i:size(I, 1), 1));
        h2 = 0;
        for j = i : size(I, 1)
            h2 = h2 + (P(j)/p2) * log2(P(j)/p2);
        end
        h2 = h2 * -1;

        % T
        t = h1 + h2;
        if T < t
            T = t;
            seuil = i;
        end
        
    end
    
    T
    seuil
  
    for i=1:size(img2, 1)
        for j=1:size(img2, 2)
            if img2(i, j) < seuil
                img2(i, j) = 0;
            else
                img2(i, j) = 255;
            end
        end
    end
    
    MX = img2;
end

