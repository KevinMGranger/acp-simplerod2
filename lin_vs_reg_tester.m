function [nums lin_times reg_times] = lin_vs_reg_tester

nums = round(logspace(1,5,10));
lin_times = zeros(1,length(nums));
reg_times = lin_times;


parfor i=1:length(nums)
    fprintf('Starting lin # %u for %u pieces',i,nums(i));
    tic;
    lin_simple_rod(nums(i),100,10);
    lin_times(i) = toc;
    fprintf('Lin time # %u for %u pieces : %u seconds\n',i,nums(i),lin_times(i));
end

parfor i=1:length(nums)
    fprintf('Starting reg # %u for %u pieces',i,nums(i));
    tic;
    simple_rod(nums(i),100,10);
    reg_times(i) = toc;
    fprintf('Reg time # %u for %u pieces : %u seconds\n',i,nums(i),reg_times(i));
end