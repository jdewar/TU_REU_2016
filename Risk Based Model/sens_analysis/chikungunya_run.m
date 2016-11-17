function chikungunya_run

close all; clear all;
restoredefaultpath      % Purge accumulated knowledge of fns in other folders, for jeremy's sanity
addpath(genpath('lib')) % Add local libraries

clear('pbase','prange')
c1=clock;

% For right now, data from runs will be saved everytime.
% Manually delete the data files to create new data.
dirname = 'data_chik/';
if ~exist(dirname, 'dir')
    mkdir(dirname);
end
blackboxHandle = @bbb;

pbase.beta_h = 0.24;
pbase.beta_v  = 0.24;
pbase.gamma_h  = 1/6;
pbase.mu_h  = 1/(70*365);
pbase.nu_h  = 1/3;
pbase.psi_v  = 0.3;
pbase.mu_v  = 1/14;
pbase.nu_v  = 1/11;
pbase.sigma_h1  = 3;
pbase.sigma_h2  = 10;
pbase.sigma_v  = 0.5;
pbase.H0  = 1000000;
pbase.theta1  = 0.7;
pbase.theta2  = 0.1;
pbase.init_cumulative_infected  = 10;
pbase.K_v  = 1000000 *2;
pbase.pi1  = 1;
pbase.pi2  = 1;

npts = 40;

prange.sigma_h1 = linspace( .1,  1, npts);
prange.theta1  = linspace(  0,  1, npts);

% These next two functions are works in progress.
% generate_plots looks for data files and if not found, it calculates the data.
generate_plots(pbase, prange,{'test1','test2'},'x', dirname, blackboxHandle);
%(pbase, prange, ptitles, xlbl, dirname, blackboxHandle)
disp('Made plots')
% generate_table recreates the data, and does not look for data files.
generate_table(pbase, dirname, blackboxHandle);
disp('Made table')
c2 = clock;
disp(['Time elapsed: ' datestr(etime(c2, c1)/(60*60*24), 'HH:MM:SS.FFF')])
