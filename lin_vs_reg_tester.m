function [nums lin_times reg_times] = lin_vs_reg_tester

nums = round(logspace(1,5,20));
lin_times = zeros(1,length(nums));
reg_times = lin_times;


for i=1:length(nums)
    fprintf('%u Pieces\n',nums(i));
    
    tic;
    lin_simple_rod(nums(i),100,10);
    lin_times(i) = toc;
    fprintf('Lin time # %u for %u pieces : %u seconds\n',i,nums(i),lin_times(i));
    
    tic;
    simple_rod(nums(i),100,10);
    reg_times(i) = toc;
    fprintf('Reg time # %u for %u pieces : %u seconds\n',i,nums(i),reg_times(i));
end