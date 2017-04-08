close all; clear all;
restoredefaultpath      % Purge accumulated knowledge of fns in other folders, for jeremy's sanity
addpath(genpath('lib')) % Add local libraries

clear('pbase','prange')
c1=clock;

% For right now, data from runs will be saved everytime.
% Manually delete the data files to create new data.
% dirname = 'data/';
% if ~exist(dirname, 'dir')
%     mkdir(dirname);
% end
blackboxHandle = @bbbArea;
param_struct = ...
    {'length', 0.24;
     'width', 0.24;
     }';
pbase = struct(param_struct{:});
array_names = param_struct(1,:);

pbase.width = 2;
pbase.length  = 3;

npts = 10;

prange.width = linspace( 1,  10, npts);
prange.length  = linspace(  1,  10, npts);

% These next two functions are works in progress.
% generate_plots looks for data files and if not found, it calculates the data.
generate_plots(pbase, prange,'',blackboxHandle);
disp('Made plots')
% generate_table recreates the data, and does not look for data files.
generate_table(pbase, '', blackboxHandle);
disp('Made table')
c2 = clock;
disp(['Time elapsed: ' datestr(etime(c2, c1)/(60*60*24), 'HH:MM:SS.FFF')])

