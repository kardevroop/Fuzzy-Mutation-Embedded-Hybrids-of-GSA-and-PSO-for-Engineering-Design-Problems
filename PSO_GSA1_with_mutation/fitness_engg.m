function [per] = fitness_engg(x,ch)
per = 0;
    if(ch==1)
        per=(x(3)+2)*x(2)*x(1)^2;
        %fprintf('%f\n',per);
    elseif(ch==2)
        per=(0.144279324-((x(3)*x(2))/(x(4)*x(1))))^2;
    elseif(ch==3)
        per = 1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14.0+x(2));
    elseif(ch==4)
        per = 0.6224*x(1)*x(3)*x(4)+1.7781*x(2)*x(3)^2+3.1661*x(1)^2*x(4)+19.84*x(1)^2*x(3);
    elseif(ch==5)
        per = (pi^2/4)*(x(3)+2)*x(2)*x(1)^2;
    end
end