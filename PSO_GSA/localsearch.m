function [population,rank]=localsearch(x,t,x2,t2,population,rank,ftrank,classifierArray)
    [r,c]=size(population);
    maxkd=int16(c*5/100);%5% of the number of features
    if maxkd == 0
        maxkd=int16(ceil(c/2));
    end
    temp=zeros(1,c);
    for i=1:r
        k=randi(maxkd,1);d=randi(maxkd,1);j=1;
        temp(1:c)=population(i,1:c);
        while ((k>0) && (j<=c)) %k additions
            %ftrank(j)
            if temp(ftrank(j))==0
                temp(ftrank(j))=1;
                k=k-1;
            end
            j=j+1;
        end
        j=c;
        while ((d>0) && (j>0)) %d deletions
            if temp(ftrank(j))==1
                temp(ftrank(j))=0;
                d=d-1;
            end
            j=j-1;
        end
        [tempr,model]=classify(x,t,x2,t2,temp);
        val=chromosomecomparator(temp,tempr,population(i,1:c),rank(i));
        fprintf('Local search on %d th position & val is %f\n',i,val);
        if (val>0)
            fprintf('Replaced chromosome at %d in local search\n',i);
            population(i,1:c)=temp(1,1:c);
            rank(i)=tempr;
            classifierArray{i}=model;
        end
    end
end