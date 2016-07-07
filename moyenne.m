function S = moyenne( I, N, begin_, end_ )
    S = sum(I(begin_:end_, 1).*N(begin_:end_, 1)) / sum(N(begin_:end_, 1));
end

