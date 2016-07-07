function P = prob( img, I, begin_, end_ )
    P = sum(I(begin_:end_)) / (size(img, 1)*size(img, 2));
end

