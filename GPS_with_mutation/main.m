 function []=main()
num=1;  %number of runs of algorithm
%rho = 1.0;
%phi = 0.0;
fileID = fopen('alpha_beta_20_f15.txt','a+');
fmt = '%5.9f,%5.9f,%5.30f\r\n';

% while phi <= 1
 for a = 1:7
 for b = 2:8
 fprintf('a:%f  b:%f\n',a,b);
values=zeros(1,num);
bestPoints=cell(1,num);
timeexc=zeros(1,num);
%for j=15:15  %function number 
    for i=1:num
        fprintf('Generation %d\n',i);
        [timeexc(1,i),values(1,i),bestPoints{i}]=gps(15,a,b);%call gps
        %fprintf('%f\n',values(1,i));
    end
    fprintf('%f\n',(sum(timeexc)/num));%avg time of exec calculation
%end

%clc;
% disp(values);
 [values,index] = sort(values);
 values1 = values(1:num);
% bestPoints=bestPoints(index);
%bestPoints=bestPoints{1:2};
%  for i=1:30
%      fprintf('%f\t',values1(1,i));
%  end
 fprintf('\nMean -');
 disp(mean(values1));
 fprintf('standard deviation - ');
 disp(std(values1));
 fprintf('Max & min - ');
 disp(max(values1(:)));
 disp(min(values1(:)));
% celldisp(bestPoints);

  fprintf(fileID,fmt,[a, b, mean(values1)]);
%rho = rho - 0.05;
%phi = phi + 0.05;
 %end
 end
 end
  fclose(fileID);
end