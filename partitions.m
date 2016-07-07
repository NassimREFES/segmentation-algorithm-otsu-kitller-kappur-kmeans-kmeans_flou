function Tx = partitions( sz, k )
    PT = k; % assuré pr chaque classe au moin 1 element

    C = [];
    Ci = 1;
    C(Ci) = 1;
    Ci = Ci + 1;

    min = 1;
    max = sz;

    for i=1:k-1
        r = randi([min max-PT], 1, 1)
        C(Ci) = r+C(Ci-1);
        Ci = Ci + 1;
        max = max - r;
        PT = PT - 1;
    end

    C(Ci) = sz;
    Ci = Ci + 1;
    Tx = C
end

