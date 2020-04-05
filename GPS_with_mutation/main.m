function []=main()
num = 50;  %number of runs of algorithm
rho = 4;
phi = 5;
fileID = fopen('results.txt','a+');
fmt = '%5.9f,%5.9f,%5.30f, %5.9f\r\n';
functionCount = 23;

for functionNum = 1:functionCount
    values=zeros(1,num);
    bestPoints=cell(1,num);
    timeexc=zeros(1,num);
    %for j=15:15  %function number
    for i=1:num
        fprintf('Generation %d\n',i);
        [timeexc(1,i),values(1,i),bestPoints{i}]=gps(functionNum,rho,phi);%call gps
        %fprintf('%f\n',values(1,i));
    end
    fprintf('%f\n',(sum(timeexc)/num));%avg time of exec calculation
    %end
    
    %clc;
    disp(values);
    % bestPoints=bestPoints(index);
    %bestPoints=bestPoints{1:2};
    %  for i=1:30
    %      fprintf('%f\t',values1(1,i));
    %  end
    fprintf('\nMean -');
    disp(mean(values));
    fprintf('standard deviation - ');
    disp(std(values));
    fprintf('Max & min - ');
    disp(max(values(:)));
    disp(min(values(:)));
    % celldisp(bestPoints);
    
    fprintf(fileID,fmt,[max(values(:)), min(values(:)), mean(values), std(values)]);
end
fclose(fileID);
end