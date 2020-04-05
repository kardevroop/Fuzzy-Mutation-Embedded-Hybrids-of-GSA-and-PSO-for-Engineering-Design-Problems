%creates a feature list & value of acuuracy of list out of 1(0-1)
function [data] = datacreate(n,dimension,lb,ub)
    %n is the number of chromosomes we are working on
   
    rng('shuffle');
    data=zeros(n,dimension);
    for i=1:n
        temp=rand(1,dimension);
        temp=temp*(ub-lb)+lb;
        data(i,:)=temp;
    end
    clear max min count;
end