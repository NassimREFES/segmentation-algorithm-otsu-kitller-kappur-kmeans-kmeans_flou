function dist = distance_hamming( a, b )
    dist = 0;
    for i=1:size(a, 2)
        dist = dist + abs(a(1, i)-b(1, i));
    end
end

