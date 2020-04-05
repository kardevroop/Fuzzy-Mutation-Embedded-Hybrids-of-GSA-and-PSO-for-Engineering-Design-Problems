function [pop]=min_engg(pop,fnum)
[n,d] = size(pop);
%temp = rand(n,1);
switch(fnum)
    case 1
        lb = [0.05, 0.25, 2.00];
        ub = [2.00, 1.30, 15.00];
        for i=1:d
            for j=1:n
                if(pop(j,i) > ub(i))
                    pop(j,i) = ub(i);
                end
            end
        end
    case 2
         lb = 12;
         ub = 60;
         for i=1:d
            for j=1:n
                if(pop(j,i) > ub)
                    pop(j,i) = ub;
                end
            end
        end
    case 3
        lb = [0.1, 0.1, 0.1, 0.1];
        ub = [2.00, 10.00, 10.00, 2.00];
        for i=1:d
            for j=1:n
                if(pop(j,i) > ub(i))
                    pop(j,i) = ub(i);
                end
            end
        end
    case 4
        lb = [0.00, 0.00, 10.00, 10.00];
        ub = [100.00, 100.00, 200.00, 200.00];
        for i=1:d
            for j=1:n
                if(pop(j,i) > ub(i))
                    pop(j,i) = ub(i);
                end
            end
        end
    case 5
        lb = [0.508, 1.270, 15.00];
        ub = [1.016, 7.620, 25.00];
        for i=1:d
            for j=1:n
                if(pop(j,i) > ub(i))
                    pop(j,i) = ub(i);
                end
            end
        end
end
end