function [pbest,gbest]=mutation_gsa_pso(fhd,dimension,n,iter,lb,ub,functionNum)
    %rng('shuffle');
    rng(sum(100*clock),'twister')
    %{
    ub=65.53;
    lb=-65.53;
    dimension=2;
    n=50;   %number of points being considered
    iter=500;
    functionNum=14;
    %}
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
    
    [population,rank,velocities]=chromosomeRank(fhd,population,rank,velocities,functionNum,1,0);
    gbest=rank(1);
    pbest=population(1,:);
    change=0;
    for count=1:iter
        fprintf('Iteration - %d with gbest as - %f and current best %f change  - %f\n',count,double(gbest),double(rank(1)),change);
        
        valuesBest(1,count)=rank(1);
        valuesAvg(1,count)=sum(rank)/n;
        label(1,count)=count;
        
        mass=massCalculation(rank);
        
        
        [velocities]=updateVelocities(mass,velocities,population,count,iter);
        [population]=updatePosition(population,velocities);
                
        population=min(population,ub);
        population=max(population,lb);
        
        
        [population,rank,velocities]=chromosomeRank(fhd,population,rank,velocities,functionNum,1,0);
        
        
        if (gbest>rank(1))
            gbest=rank(1);
            pbest=population(1,:);
        end
        
        %if (abs(gbest-rank(1))<.01*gbest)
        if (abs(gbest-rank(1))<.01*gbest || abs(gbest-rank(1))>gbest)
            change=change+1;
        else
            change=0;
        end
        
        %%{
        %[population]=mutation(population,rank,count,iter,change,(ub-lb));
        [population,rank,velocities]=chromosomeRank(fhd,population,rank,velocities,functionNum,1,0);
        if (gbest>rank(1))
            gbest=rank(1);
            pbest=population(1,:);
        end
        
        %}
        %population
    end
    fprintf('The gbest is - %f and best accuracy is %f\n',double(gbest),double(rank(1,1)));
    %disp(gbest-(418.9829*dimension));
    disp(gbest);
    disp(pbest);
    disp(population(1,:));
    figure;
    plot(label,valuesBest,label,valuesAvg);
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
function [velocities]=updateVelocities(mass,velocities,population,count,iter)
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
            velocities(i,j)=(rand*velocities(i,j))+c1*force(i,j);%+c2*(population(1,j)-population(i,j));
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
    
    for i=1:size(population,1)
        dist=distance(centroid,population(i,:));
        pm=1/(dist+1);
        pc=.5+.5*(tanh((change/4)-5));
        pm=min(pc,pm);
        for j=1:size(population,2)
            if ((rand < pm))% || (pc > .98))
                %fprintf('l');
                if abs(population(i,j)) <= 0.00001
                    delta=.5*range*((1-(count/iter))^2);
                else
                    delta=min(.5*range*((1-(count/iter))^2),abs(population(i,j)));
                end
                
                %delta=max(delta,population(i,j)/10); %bad results
                %delta=.5*range*((1-(count/iter))^2);
                if rand <.5
                    population(i,j)=population(i,j)-delta;
                else
                    population(i,j)=population(i,j)+delta;
                end
            end
        end
    end
end