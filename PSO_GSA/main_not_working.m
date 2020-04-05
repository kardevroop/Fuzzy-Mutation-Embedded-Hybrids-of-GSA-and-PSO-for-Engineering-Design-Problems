function []=main_not_working()
    tic
    clc
    rng('shuffle');
    ub=50;
    lb=-50;
    dimension=30;
    n=50;   %number of points being considered
    iter=2000;
    functionNum=13;
    
    label=zeros(1,iter);
    valuesBest=zeros(1,iter);
    valuesAvg=zeros(1,iter);
    %{
    population=vpa(datacreate(n,dimension,lb,ub));
    rank=vpa(zeros(1,n));
    velocities=vpa(zeros(n,dimension));
    %}
    population=(datacreate(n,dimension,lb,ub));
    rank=(zeros(1,n));
    velocities=(zeros(n,dimension));
    
    [population,rank,velocities]=chromosomeRank(population,rank,velocities,functionNum,1,0);
    gbest=rank(1);
    gbestPoint=zeros(1,dimension);
    
    change=0;
    changeG=0;
    for count=1:iter
        fprintf('Iteration - %d with gbest as - %f and current best %f change  - %f\n',count,double(gbest),double(rank(1)),change);
        
        valuesBest(1,count)=rank(1);
        valuesAvg(1,count)=sum(rank)/n;
        label(1,count)=count;
        
        mass=massCalculation(rank);
        
        %{
        %pc=.5+.5*(tanh((change/3)-5));
        temp=(rand(1,n)./2)+.5;
        if (count <=200 && change>5 && changeG==1)
            mass=(mass.*temp).*3;
            fprintf('Uniform increase\n');
        elseif (count >200 && count <=500 && change>5 && changeG==1)
            mass=(mass.*temp).*2;
            fprintf('Uniform increase\n');
        elseif (count > 500 && change>3 && changeG==1)
            mass=(mass.*temp).*1.5;
            fprintf('Uniform increase\n');
        end
            %%{
        else  %if ( (rand < pc))
            mass=mass+sum(mass)/n;
            %fprintf('Mass increase\n');
        end
        %}
        [velocities]=updateVelocities(mass,velocities,population,gbestPoint,count,iter);
        [populationTemp]=updatePosition(population,velocities);
                
        populationTemp=min(populationTemp,ub);
        populationTemp=max(populationTemp,lb);
        
        for i=1:n
            temp=fitness(populationTemp(i,:),functionNum);
            %if (temp < rank(i) || (abs(temp - rank(i))< (gbest*.1)))
                population(i,:)=populationTemp(i,:);
                rank(i)=temp;
            %end
        end
        
        [population,rank,velocities]=chromosomeRank(population,rank,velocities,functionNum,0,0);
        
        if ((gbest-rank(1))>(.05*gbest) )
            change=-.5;
        elseif ((gbest-rank(1))>(.03*gbest) && count>500)
            change=-.5;
        else
            change=change+.5;
        end
        
        if (gbest>rank(1))
            gbest=rank(1);
            gbestPoint=population(1,:);
            changeG=1;
        else
            changeG=0;
        end
        
        
        %%{
        rankBestTemp=rank(1);
        [temp]=mutation(population,rank,count,iter,change,(ub-lb));
        for i=1:n
            rankTemp=fitness(temp(i,:),functionNum);
            if ((abs(rankTemp - rank(i))< (gbest*.1)) || (rankTemp<rank(i)))
                population(i,:)=temp(i,:);
                rank(i)=rankTemp;
            end
        end
        [population,rank,velocities]=chromosomeRank(population,rank,velocities,functionNum,1,0);
        
        if ( ((gbest-rank(1))>(.05*gbest)) || ((rank(1)-rankBestTemp)>(.1*gbest)))
            change=0;
        elseif ((gbest-rank(1))>(.03*gbest) && count>500)
            change=0;
        else
            change=change+.5;
        end
        
        change=mod(change,30);
        
        if (gbest>rank(1))
            gbest=rank(1);
            gbestPoint=population(1,:);
            changeG=1;
        end
        
        %}
        %population
    end
    fprintf('The gbest is - %f and best accuracy is %f\n',double(gbest),double(rank(1,1)));
    %disp(gbest-(418.9829*dimension));
    disp(gbest);
    figure;
    title('Full')
    plot(label,valuesBest,label,valuesAvg);
    figure;
    title('last 400')
    plot(label(1,600:end),valuesBest(1,600:end),label(1,600:end),valuesAvg(1,600:end));
    toc
end
function [dist]=distance(vec1,vec2)
    dist=0;
    for i=1:size(vec1,2)
        dist=dist+((vec1(i)-vec2(i))^2);
    end
    dist=sqrt(dist);
end
function [mass]=massCalculation(rank)
    rank=100./((rank)+1);
    worst=min(rank);
    best=max(rank);
    mass=rank;
    mass=mass-worst;
    mass=mass/((best-worst)+.00005);
    total=sum(mass(1,:));
    mass=mass/(total+.00005);
end
function [velocities]=updateVelocities(mass,velocities,population,gbestPoint,count,iter)
    rng('shuffle');
    [r,c]=size(velocities);
    force=zeros(r,c);
    k=int16(r+((1-r)*(count-1))/(iter-1));  %linear relation
    g=exp(-20*(count/iter));    %20 should change - decrease over time
    for i=1:r
        for l=1:c
            for j=1:k
                if i~=j
                    temp=g*((mass(i)*mass(j))/(distance(population(i,:),population(j,:))+.00005))*(population(j,l)-population(i,l));
                    force(i,l)=force(i,l)+(rand*temp);
                end
            end
        end
    end
    for i=1:r
        force(i,:)=force(i,:)/(mass(i)+.00005);
    end
    c1=(-2*(count^3/iter^3))+2;
    c2=(2*(count^3/iter^3));
    for i=1:r
        for j=1:c
            velocities(i,j)=(rand*velocities(i,j))+c1*force(i,j)+c2*(gbestPoint(1,j)-population(i,j)); % gsa+pso
            %velocities(i,j)=(rand*velocities(i,j))+force(i,j); %gsa
        end
    end
end
function [population]=updatePosition(population,velocities)
    [r,c]=size(population);
    for i=1:r
        for j=1:c
            population(i,j)=population(i,j)+velocities(i,j);
        end
    end
end
function [population]=mutation(population,rank,count,iter,change,range)
    mass=massCalculation(rank);
    mass=mass+.00005;
    
    centroid=zeros(1,size(population,2));
    for i=1:size(population,2)
        centroid(1,i)=(mass*population(:,i))/sum(mass);
    end
    
    distanceC=zeros(1,size(population,1));
    for i=1:size(population,1)
        distanceC(1,i)=distance(centroid,population(i,:));
    end
    avg=mean(distanceC);
    pm=1/(avg+1);
    count1=0;
    for i=1:size(population,1)
        particleM=tanh(distanceC/avg);
        pc=.5+.5*(tanh((change/3)-5));
        particleM=min(pc,particleM);
        particleM=min(particleM,pm);
        for j=1:size(population,2)
            if ((rand < particleM))% || (pc > .98))
                %fprintf('l');
                count1=count1+1;
                delta=min(.5*range*((1-(count/iter))^2),abs(population(i,j))/2);
                
                %delta=max(delta,population(i,j)/10); %bad results
                %delta=.5*range*((1-(count/iter))^2);
                if rand <.5
                    population(i,j)=population(i,j)-rand*delta;
                else
                    population(i,j)=population(i,j)+rand*delta;
                end
            end
        end
    end
    fprintf('%d ',count1);
end