function V = variance( I, N, begin_, end_, moy)
    V = 0;
    for i = begin_ : end_
        V = V + ((I(i, 1)-moy)^2)*N(i, 1);
    end
    V = V / sum(N(begin_:end_, 1));
end

