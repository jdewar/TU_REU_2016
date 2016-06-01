function speed_test(directory)

pattern = fullfile(directory, '*.m');
list    = dir(pattern);
nFile   = length(list);
success = false(1, nFile);

addpath(directory)
for k = 1:nFile
  file = list(k).name;
  func = file(1:end-2);
  try
    tic; feval(func); elapsed = toc;
    fprintf('%s: %g seconds\n', func, elapsed);
    success(k) = true;
  catch
    fprintf('%s: FAILED\n', func);
  end
end


end