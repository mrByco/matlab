a = [5,6,3,9; 6,3,5,8; 4,2,1,7];
rows = size(A,1)
a = [a eye(rows)]

for c = 1:rows
    for r = (c+1):rows
        m = a(r,c) / a(c,c)
        a(r,:) = a(r,:) - a(c,:)*m
    end
end

for c = rows:-1:1
    for r = (c-1):-1:1
        m = a(r,c) / a(c,c)
        a(r,:) = a(r,:) - a(c,:)*m
    end
end

for r=1:rows
    a(r,:) = a(r,:)/a(r,r)
end
