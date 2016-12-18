function chikungunya_run

close all; clear all;
restoredefaultpath      % Purge accumulated knowledge of fns in other folders, for jeremy's sanity
addpath(genpath('lib')) % Add local libraries
addpath(genpath('../Two Groups Behavior Change')) % Add local libraries

clear('pbase','prange')
c1=clock;

% For right now, data from runs will be saved everytime.
% Manually delete the data files to create new data.
dirname = 'data/';
if ~exist(dirname, 'dir')
    mkdir(dirname);
end
blackboxHandle = @bbb;

% pbase.beta_h = 0.24;
% pbase.beta_v  = 0.24;
% pbase.gamma_h  = 1/6;
% pbase.mu_h  = 1/(70*365);
% pbase.nu_h  = 1/3;
% pbase.psi_v  = 0.3;
% pbase.mu_v  = 1/14;
% pbase.nu_v  = 1/11;
% pbase.sigma_h1  = 3;
% pbase.sigma_h2  = 10;
%pbase.sigma_v  = 0.5;
%pbase.H0  = 1000000;
pbase.theta1  = 0.266;
pbase.theta2  = 0.787;
%pbase.init_cumulative_infected  = 10;
pbase.K_v  = 1000000 *2;
pbase.pi1  = .1146;
pbase.pi2  = .4712;

npts = 40;

% prange.beta_h = linspace( .24,  .24, 1);
% prange.beta_v  = linspace(.24,  .24, 1);
% prange.gamma_h  = linspace(1/6,  1/6, 1);
% prange.mu_h  = linspace(1/(70*365),  1/(70*365), 1);
% prange.nu_h  = linspace(1/3,  1/3, 1);
% prange.psi_v  = linspace(.3,  .3, 1);
% prange.mu_v  = linspace(1/14,  1/14, 1);
% prange.nu_v  = linspace(1/11,  1/11, 1);
% prange.sigma_h1  = linspace(0.1,  5, npts);
% prange.sigma_h2  = linspace(5,  50, npts);
%prange.sigma_v  = linspace(0.5,  5, 1);
%prange.H0  = linspace(pbase.H0,  pbase.H0, 1);
prange.theta1  = linspace(0.01,  .8, npts);
prange.theta2  = linspace(0.01,  .8, npts);
%prange.init_cumulative_infected  = linspace(pbase.init_cumulative_infected * 0.1, pbase.init_cumulative_infected * 10, npts);
prange.K_v = linspace( 1000000, 1000000*10,npts);
prange.pi1  = linspace(0.001,  1, npts);
prange.pi2  = linspace(0.001,  1, npts);

% These next two functions are works in progress.
% generate_plots looks for data files and if not found, it calculates the data.

generate_plots(pbase, prange,{'theta1','theta2','K_v','pi1','pi2'},'x', dirname, blackboxHandle);
%'beta_h','beta_v','gamma_h','mu_h','nu_h','psi_v','mu_v','nu_v','sigma_h1','sigma_h2','sigma_v','H0','theta1','theta2','init_cumulative_infected','K_v','pi1','pi2'
%(pbase, prange, ptitles, xlbl, dirname, blackboxHandle)
disp('Made plots')
% generate_table recreates the data, and does not look for data files.
generate_table(pbase, dirname, blackboxHandle);
disp('Made table')
c2 = clock;
disp(['Time elapsed: ' datestr(etime(c2, c1)/(60*60*24), 'HH:MM:SS.FFF')])
