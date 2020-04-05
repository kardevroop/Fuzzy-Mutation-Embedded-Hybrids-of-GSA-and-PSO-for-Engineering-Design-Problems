% clear all
% mex cec17_func.cpp -DWINDOWS
func_num=1;
D=10;
Xmin=-100;
Xmax=100;
pop_size=100;
iter_max=5000;
runs=2;
fhd=str2func('cec17_func');
f_mean=zeros(1,30);
fbest=zeros(30,runs);
for i=3:3
    if i~=2
        func_num=i;
        for j=1:runs
            [gbest,gbestval]= mutation_gsa_pso(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num);
            xbest(j,:)=gbest;
            fbest(i,j)=gbestval;
        end
        f_mean(i)=mean(fbest(i,:));
        fprintf('Mean for funcion %d is %f\n',i,f_mean(i));
    end
end



% for i=1:29
% eval(['load input_data/shift_data_' num2str(i) '.txt']);
% eval(['O=shift_data_' num2str(i) '(1:10);']);
% f(i)=cec14_func(O',i);i,f(i)
% end