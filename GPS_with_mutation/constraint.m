function [rank] = constraint(pop,rank,fnum,lb,ub)
[n,~]=size(pop);
switch (fnum)
    case 1
        fit = 0;
        for i=1:n
            temp = pop(i,:);
        g1 = 1 - ((temp(2)^2)*temp(3))/(717854*(temp(1)^4));
        g2 = (4*temp(2)^2-temp(1)*temp(2))/(12566*(temp(2)*temp(1)^3)-temp(1)^4) + 1/(5108*temp(1)^2);
        g3 = 1- (140.45*temp(1))/(temp(2)^2*temp(3));
        g4 = (temp(1)+temp(2))/1.5 -1;
        if(g1 > 0)
            fit = fit+1000;
        end
        if(g2 > 0)
            fit = fit+1000;
        end
        if(g3 > 0)
            fit = fit + 1000;
        end
        if(g4 > 0)
            fit = fit + 1000;
        end
        rank(i) = fit;fit = 0;
        end
    case 2
%         temp=rand(1,dimension);
%             for j=1:dimension
%                 temp(1,j)=temp(1,j)*(ub(1,j)-lb(1,j))+lb(1,j);
%             end
    case 3
        fit = 0;
        for i = 1:n
            temp = pop(i,:);
            [g] = param(temp,fnum);
        if(g(1) > 0)
            fit = fit+500;
        end
        if(g(2) > 0)
            fit = fit+500;
        end
        if(g(3) > 0)
            fit = fit + 500;
        end
        if(g(4) > 0)
            fit = fit + 500;
        end
        if(g(5) > 0)
            fit = fit + 500;
        end
        if(g(6) > 0)
            fit = fit + 500;
        end
        if(g(7) > 0)
            fit = fit + 500;
        end
        rank(i) = fit;
        fit = 0;
        end
        
    case 4
        fit = 0;flag = 0;
        for i=1:n
        temp = pop(i,:);
        g1 = -temp(1)+0.0193*temp(3);
        g2 = -temp(2)+0.00954*temp(3);
        g3 = -pi*temp(3)^2*temp(4)-(4/3)*pi*temp(3)^3+1296000;
        g4 = temp(4) - 240;
        if(g1 > 0)
            fit = fit+1000;
            flag = 1;
        end
        if(g2 > 0)
            fit = fit+1000;
            flag = 1;
        end
        if(g3 > 0)
            fit = fit + 1000;
            flag = 1;
        end
        if(g4 > 0)
            fit = fit + 1000;
            flag = 1;
        end
        if(flag==1)
            rank(i) = fit;
        end
        fit = 0;flag = 0;
        end
    case 5
        fit = 0;
        for i=1:n
        temp = pop(i,:);
        %g = [];
        [g] = param(temp,fnum);
        if(g(1) < 0)
            fit = fit+1000;
        end
        if(g(2) < 0)
            fit = fit+1000;
        end
        if(g(3) < 0)
            fit = fit + 1000;
        end
        if(g(4) < 0)
            fit = fit + 1000;
        end
        if(g(5) < 0)
            fit = fit + 1000;
        end
        if(g(6) < 0)
            fit = fit + 1000;
        end
        if(g(7) < 0)
            fit = fit + 1000;
        end
        if(g(8) > 0)
            fit = fit + 1000;
        end
        rank(i) = fit;
        fit = 0;
        end
end
end