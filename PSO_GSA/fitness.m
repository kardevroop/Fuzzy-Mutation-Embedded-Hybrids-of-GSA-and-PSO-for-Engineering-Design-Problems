function [per]=fitness(chromosome,ch)
    if (ch==1)
        per=sum(chromosome.^2);
    elseif (ch==2)
        chromosome=abs(chromosome);
        temp=1;
        for i=1:size(chromosome,2)
            temp=temp*chromosome(1,i);
        end
        per=sum(chromosome.^2)+temp;
    elseif (ch==3)
        per=0;
        for i=1:size(chromosome,2)
            temp=0;
            for j=1:i
                temp=temp+chromosome(1,j);
            end
            per=per+temp^2;
        end
    elseif (ch==4)
        per=max(abs(chromosome));
    elseif (ch==5)
        temp=0;
        for i=1:(size(chromosome,2)-1)
            temp=temp+(100*(((chromosome(i+1)-chromosome(i)^2)^2))+((chromosome(i)-1)^2));
        end
        per=temp;
    elseif (ch==6)
        chromosome=chromosome+.5;
        per=sum(chromosome.^2);
    elseif (ch==7)
        temp=0;
        for i=1:size(chromosome,2)
            temp=temp+(i*(chromosome(i)^4));
        end
        per=temp+rand;
    elseif (ch==8)
        temp=sin(sqrt(abs(chromosome)));
        per=sum((-1*chromosome).*temp)+(418.9829*size(chromosome,2));
    elseif (ch==9)
        per=sum(chromosome.^2)+10*size(chromosome,2);
        per=per-10*sum(cos(2*pi*chromosome));
    elseif (ch==10)
        temp=(-0.2*sqrt(sum(chromosome.^2)/size(chromosome,2)));
        temp2=sum(cos(2*pi*chromosome))/size(chromosome,2);
        per=-20*exp(temp)-exp(temp2)+20+exp(1);
    elseif (ch==11)
        temp=1;
        for i=1:size(chromosome,2)
            temp=temp*(cos(chromosome(i)/sqrt(i)));
        end
        per=(sum(chromosome.^2)/4000)-temp+1;
    elseif (ch==12)
        %{
        n=size(chromosome,2);
        temp=0;
        for i=1:n
            temp=temp+u(chromosome(1,i),10,100,4);
        end
        chromosome=((chromosome+1)./4)+1;
        temp2=0;
        for i=1:n-1
            temp2=temp2+(((chromosome(1,i)-1)^2)*(1+(10*(sin(pi*chromosome(1,i+1))^2))));
        end
        temp3=10*(sin(pi*chromosome(1)))+(chromosome(1,n)-1)^2;
        per=temp2+temp3;
        per=((per*pi)/n)+temp;
        %}
        dim = 30;
        L = chromosome;
         per=(pi/dim)*(10*((sin(pi*(1+(L(1)+1)/4)))^2)+sum((((L(1:dim-1)+1)./4).^2).*...
        (1+10.*((sin(pi.*(1+(L(2:dim)+1)./4)))).^2))+((L(dim)+1)/4)^2)+sum(Ufun(L,10,100,4));
    elseif (ch==13)
        n=size(chromosome,2);
        temp=0;
        for i=1:n
            temp=temp+u(chromosome(1,i),5,100,4);
        end
        temp2=sin(3*pi*chromosome(1,1))^2+((sin(2*pi*chromosome(1,n))^2+1)*((chromosome(1,n)-1)^2));
        for i=2:n
            temp2=temp2+((chromosome(1,i)-1)^2)*(1+sin(3*pi*chromosome(1,i))^2);
        end
        per=0.1*temp2+temp;
    elseif (ch==14)%wrong
        a=[-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32;
            -32,-32,-32,-32,-32,-16,-16,-16,-16,-16,0,0,0,0,0,16,16,16,16,16,32,32,32,32,32];
        val=0;
        for j=1:25
            temp=(chromosome(1,1)-a(1,j))^6+(chromosome(1,2)-a(2,j))^6;
            val=val+(1/(j+temp));
        end
        val=val+(1/500);
        per=1/val;
        per=per;
    elseif (ch==15)
        a=[ 0.1957 0.1947 0.1735 0.1600 0.0844 0.0627 0.0456 0.0342 0.0342 0.0235 0.0246];
        b=[0.25,0.5,1,2,4,6,8,10,12,14,16];
        b=1./b;
        per=0;
        for i=1:11
            temp=chromosome(1)*(b(i)^2+b(i)*chromosome(2))/(b(i)^2+b(i)*chromosome(3)+chromosome(4));
            temp=a(i)-temp;
            temp=temp^2;
            per=per+temp;
        end
        %per=per-.0003;
    elseif (ch==16)
        x1=chromosome(1,1);
        x2=chromosome(1,2);
        per=4*(x1^2)-2.1*(x1^4)+(x1^6)/3+(x1*x2)-(4*(x2^2))+(4*(x2^4));
        per=per+1.0316;
    elseif (ch==17)
        %dimension control needed
        x1=chromosome(1,1);
        x2=chromosome(1,2);
        per=(x2-(x1^2)*5.1/(4*(pi^2))+5/pi*x1-6)^2+10*(1-1/(8*pi))*cos(x1)+10;
    elseif (ch==18)
        x1=chromosome(1,1);
        x2=chromosome(1,2);
        per=(1+(x1+x2+1)^2*(19-14*x1+3*x1^2-14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2*(18-32*x1+12*x1^2+48*x2-36*x1*x2+27*x2^2));
        per=per-3;
    elseif (ch==19)
        per=0;
        a=[ 3 10 30 ;0.1 10 35 ; 3 10 30 ; 0.1 10 30];
        c=[1 1.2 3 3.2];
        p=[ 0.3689 0.1170 0.2673 ; 0.4699 0.4387 0.7470 ; 0.1091 0.8732 0.5547 ; 0.03815 0.5743 0.8828];
        for i=1:4
            temp=0;
            for j=1:3
                temp=temp+a(i,j)*((chromosome(j)-p(i,j))^2);
            end
            per=per+c(i)*exp(-temp);
        end
        per=per*-1;
        per=per+3.8774;
    elseif (ch==20)
        per=0;
        a=[ 10 3 17 3.5 1.7 8 ;0.05 10 17 0.1 8 14 ;3 3.5 1.7 10 17 8; 17 8 0.05 10 0.1 14];
        c=[1 1.2 3 3.2];
        p=[0.131 0.169 0.556 0.012 0.828 0.588; 0.232 0.413 0.830 0.373 0.100 0.999; 0.234 0.141 0.352 0.288 0.304 0.665; 0.404 0.882 0.873 0.574 0.109 0.038];
        for i=1:4
            temp=0;
            for j=1:6
                temp=temp+a(i,j)*((chromosome(j)-p(i,j))^2);
            end
            per=per+c(i)*exp(-temp);
        end
        per=per*-1;
        per=per+3.3224;
    elseif (ch==21)
        per=0;
        a=[4 4 4 4 ; 1 1 1 1 ; 8 8 8 8 ; 6 6 6 6 ; 3 7 3 7 ; 2 9 2 9 ; 5 5 3 3 ; 8 1 8 1 ; 6 2 6 2 ; 7 3.6 7 3.6 ];
        c=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
        for i=1:5
            temp=(chromosome-a(i,:))*(chromosome-a(i,:))'+c(i);
            per=per+1/temp;
        end
        per=per*-1;
        per=per+11;
	elseif (ch==22)
        per=0;
        a=[4 4 4 4 ; 1 1 1 1 ; 8 8 8 8 ; 6 6 6 6 ; 3 7 3 7 ; 2 9 2 9 ; 5 5 3 3 ; 8 1 8 1 ; 6 2 6 2 ; 7 3.6 7 3.6 ];
        c=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
        for i=1:7
            temp=(chromosome-a(i,:))*(chromosome-a(i,:))'+c(i);
            per=per+1/temp;
        end
        per=per*-1;
        per=per+11;
	elseif (ch==23)
        per=0;
        a=[4 4 4 4 ; 1 1 1 1 ; 8 8 8 8 ; 6 6 6 6 ; 3 7 3 7 ; 2 9 2 9 ; 5 5 3 3 ; 8 1 8 1 ; 6 2 6 2 ; 7 3.6 7 3.6 ];
        c=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
        for i=1:10
            temp=(chromosome-a(i,:))*(chromosome-a(i,:))'+c(i);
            per=per+1/temp;
        end
        per=per*-1;
        per=per+11;
    elseif(ch==24)
        per=0;
        per=(0.144279324-((chromosome(3)*chromosome(2))/(chromosome(4)*chromosome(1))))^2;
    end
end
function [val]=u(x,a,k,m)
    if (x>a)
        val=k*((x-a)^m);
    elseif (x<-a)
        val=k*((-x-a)^m);
    else
        val=0;
    end
end
function y=Ufun(x,a,k,m)
y=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
return
end