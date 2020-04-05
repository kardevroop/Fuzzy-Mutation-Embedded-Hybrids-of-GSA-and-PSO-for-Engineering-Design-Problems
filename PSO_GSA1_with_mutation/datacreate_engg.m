%creates a feature list & value of acuuracy of list out of 1(0-1)
function [data,ub,lb,dimension] = datacreate_engg(fnum,n,dimension)
    %n is the number of chromosomes we are working on
   
    rng('shuffle');
    data=zeros(n,dimension);
    switch (fnum)
        case 1
            dimension = 3;
            data=zeros(n,dimension);
            lb = [0.05, 0.25, 2.00];
            ub = [2.00, 1.30, 15.00];
            for i=1:n
                %%{
                temp=rand(1,dimension);
                for j=1:dimension
                    temp(1,j)=temp(1,j)*(ub(1,j)-lb(1,j))+lb(1,j);
                end
                data(i,:)=temp;
                %}
                %data(i,:)=constraint(fnum,dimension,lb,ub);
            end
            %disp(data);
            %clear max min count;
        case 2
            dimension = 4;
            %data = zeros(n,dimension);
            lb = [12 12 12 12];
            ub = [60 60 60 60];
            for i=1:n
                temp=rand(1,dimension);
                temp=temp*(ub(1)-lb(1))+lb(1);
                for j=1:dimension
                data(i,j)=temp(1,j);
                end
            end
        case 3
            dimension = 4;
            %data=zeros(n,dimension);
            lb = [0.1, 0.1, 0.1, 0.1];
            ub = [2.00, 10.00, 10.00, 2.00];
            for i=1:n
                %%{
                temp=rand(1,dimension);
                for j=1:dimension
                    temp(1,j)=temp(1,j)*(ub(1,j)-lb(1,j))+lb(1,j);
                end
                %}
                %data(i,:)=constraint(fnum,dimension,lb,ub);
            end
        case 4
            dimension = 4;
            %data=zeros(n,dimension);
            lb = [0.00, 0.0, 10.00, 10.00];
            ub = [100.00, 100.00, 200.00, 200.00];
            for i=1:n
                %%{
                temp=rand(1,dimension);
                for j=1:dimension
                    temp(1,j)=temp(1,j)*(ub(1,j)-lb(1,j))+lb(1,j);
                    data(i,j) = temp(1,j);
                end
                %}
                %data(i,:)=constraint(fnum,dimension,lb,ub);
            end
        case 5
            dimension = 3;
            %data=zeros(n,dimension);
            lb = [0.508, 1.270, 15.00];
            ub = [1.016, 7.620, 25.00];
            for i=1:n
                %%{
                temp=rand(1,dimension);
                for j=1:dimension
                    temp(1,j)=temp(1,j)*(ub(1,j)-lb(1,j))+lb(1,j);
                end
                %}
                %data(i,:)=constraint(fnum,dimension,lb,ub);
            end
    end
end