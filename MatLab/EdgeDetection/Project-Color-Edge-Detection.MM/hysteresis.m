function connect = hysteresis(strong,weak)
% function connect = hysteresis(strong,weak)

%[m,n] = size(strong);
%connect = strong;

%-----------------------------
%-- Complete below
%-----------------------------

%% itterate through the (weak) pixels- 
% for each individual one, look at the 8 surrounding it
%if any of the 8 are strong, make the weak pixel strong.

%for pixel in weak, 
%   if pixel(all 8 surrounding) = in(strong)
%       add that pixel to the strong array
%       remove that pixel from the weak array

%potential problems-- one weak one next to a streong then another next to
%that weak one- snowballs

%itterate through the strong and make any connecting weaks strong instead?
%wait same problem
%ass attached weaks to a different array then add to strong at the end?

s2 = strong;
[m,n] = size(weak);

count = 0;

for i= 1:m
    for j = 1:n
        if weak(i,j) == 1
            w = strong(i-1:i+1:j-1:j+1);
            if sum(w(:)) >= 1
                s2(i,j) = 1;
                count = count + 1;
            end
        end
    end
end

connect = s2;