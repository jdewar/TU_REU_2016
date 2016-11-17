close all; clear all;
restoredefaultpath      % Purge accumulated knowledge of fns in other folders, for jeremy's sanity
addpath(genpath('lib')) % Add local libraries

clear('pbase','prange')
c1=clock;

% For right now, data from runs will be saved everytime.
% Manually delete the data files to create new data.
dirname = 'data/';
if ~exist(dirname, 'dir')
    mkdir(dirname);
end
blackboxHandle = @bbb;

pbase.alpha = .2;
pbase.beta  = .7;

npts = 40;

prange.alpha = linspace( .1,  1, npts);
prange.beta  = linspace(  0,  1, npts);

% These next two functions are works in progress.
% generate_plots looks for data files and if not found, it calculates the data.
generate_plots(pbase, prange, dirname, blackboxHandle);
disp('Made plots')
% generate_table recreates the data, and does not look for data files.
generate_table(pbase, dirname, blackboxHandle);
disp('Made table')
c2 = clock;
disp(['Time elapsed: ' datestr(etime(c2, c1)/(60*60*24), 'HH:MM:SS.FFF')])

