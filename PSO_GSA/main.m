function []=main()
num=1;%number of runs for algorithm
for j=1:23 %function number
%     fprintf('Function %d\n',j);
    values=zeros(1,num);
    timeexc=zeros(1,num);
    posBest=cell(1,num);
    for i=1:num
        %[timeexc(1,i),values(1,i),posBest{i}]=main_final_working(j);
        [timeexc(1,i),values(1,i)]=pso_gsa(j); %call psogsa
        %disp(values(1,i));
    end
    
%     [values,index]=sort(values);
%     disp(values);
%     posBest=posBest(index);
%     for i=1:num
%         fprintf('%f\t',values(1,i));
%     end
%     fprintf('\n');
%     values=values(1:num);
%     fprintf('Mean \t standard deviation \t Max \t Min \t time\n');
%     disp(mean(values));
%     disp(std(values));
%     disp(max(values(:)));
%     disp(min(values(:)));
    fprintf('%f\n',(sum(timeexc)/num));%avg time for execution
    %celldisp(posBest);
end
end