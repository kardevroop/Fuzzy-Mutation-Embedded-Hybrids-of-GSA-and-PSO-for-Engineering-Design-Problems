function [population,rank,velocities_gsa,velocities_pso,pbest,pbest_particle]=chromosomeRank(population,rank,velocities_gsa,velocities_pso,pbest,pbest_particle,functionNum,flag,dflag)
%1st flag if 1 then chromosomes are to be ranked
%2nd dflag if 1 then display the population
    rng('shuffle');
    [r,~]=size(population);
    if flag==1
        for i=1:r
            [rank(i)]=fitness(population(i,:),functionNum);
            %[rank(i)]=fitness_engg(population(i,:),functionNum);
            %fprintf('%f\n',rank(i));
            %rank(i)=rand(1);
        end
    end
    [~,temp]=sort(rank,'ascend');
    population=population(temp,:);
    rank=rank(temp);
    pbest=pbest(temp);
    velocities_pso=velocities_pso(temp,:);
    velocities_gsa=velocities_gsa(temp,:);
    pbest_particle=pbest_particle(temp,:);
    if (dflag==1)
        fprintf('\nPopulation now - \n');
        for i=1:r
            fprintf('R - %f\n',rank(i));
        end
        fprintf('\n');
    end
end
            