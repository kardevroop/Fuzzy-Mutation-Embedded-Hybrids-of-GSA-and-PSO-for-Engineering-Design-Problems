%0 if equal, -1 if second is better than first, +1 if first is better
function [val]=chromosomecomparator(ch1,r1,ch2,r2)
    [~,c]=size(ch1);
    %fprintf('val - %d\n',c);
    count1=(sum(ch1(1:c)==0));
    count2=(sum(ch2(1:c)==0));
    %fprintf(' No. of 0s For 1 - %d : for 2 - %d\n',count1,count2);
    %fprintf(' Accuracy sent For 1 - %f : for 2 - %f\n',r1,r2);
    if count1==c%zero selected features are not allowed
            val=-1;
    elseif count2==c
            val=1;
    elseif ((abs(r1-r2) > .005) || (count1==count2))  % Tolerance for accuracy eradation
        if r1>r2
            val=1;
        else
            val=-1;
        end
    elseif ((r1>=r2) && (count1>=count2))
        val=1;
    elseif ((r1<=r2) && (count1<=count2))
        val=-1;
    else
        w1=1;w2=4;%weigths we assign to 1-number of features,2-accuracy
        count1=count1/c;%ratio of features not used
        count2=count2/c;
        val=((w1*count1)+(w2*r1))-((w1*count2)+(w2*r2));
        if val>0
            val=1;
        elseif val<0
            val=-1;
        end
    end
end