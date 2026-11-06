function E6 = edgetrim(E5)
%trims excess edges

final = null;
[m,n] = size(E5);

count = 0;

for i= 1:m
    for j = 1:n
        if strong(i,j) == 1
            w = strong(i-1:i+1:j-1:j+1);
            if sum(w(:)) >= 2
                final(i,j) = 1;
                count = count + 1;
            end
        end
    end
end

E6 = final;
end

