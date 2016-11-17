function chikungunya_run

addpath(genpath('lib')) % Add local libraries
addpath(genpath('../bbox_ebola/ebola_model')) % Add remote libraries

% For this run:
blackboxHandle = @qp_wrapper; % Function this run

clear('params','var')
clear('base','var')
clear('range','var')

% how many plot points to calculate within the range
npts = 12;

% Get baseline parameters
data = load('../bbox_ebola/filename.mat');
bb=data.baseline;

% dirname = 'data/ebola/c';
% base.c_S = bb.c.S;
% range.c_S = linspace(base.c_S/2, base.c_S*2, npts);
% base.c_E = bb.c.E;
% range.c_E = linspace(base.c_E/2, base.c_E*2, npts);
% base.c_I = bb.c.I;
% range.c_I = linspace(base.c_I/2, base.c_I+1, npts);
% base.c_M = bb.c.M;
% range.c_M = linspace(base.c_M/2, base.c_M*2, npts);
% base.c_F = bb.c.F;
% range.c_F = linspace(base.c_F/2, base.c_F*2, npts);
% base.c_R = bb.c.R;
% range.c_R = linspace(base.c_R/2, base.c_R*2, npts);

% dirname = 'data/ebola/b';
% ptitles = {'Bypass Traditional Funeral','Medical Availability','Dying with Medical Care','Dying without Medical Care'};
% xlbl = 'Day Change Occurred';
% base.b_DF = bb.b.DF; range.b_DF = linspace(.01, .99, npts);
% base.b_IM = bb.b.IM; range.b_IM = linspace(.01, .99, npts);
% base.b_MD = bb.b.MD; range.b_MD = linspace(.01, .99, npts);
% base.b_ID = bb.b.ID; range.b_ID = linspace(.01, .99, npts);

% dirname = 'data/ebola/remodel_str';
% ptitles = {'Traditional Funeral','Change Infected Contacts','Medical Availability'};
% xlbl = {'$p_{df}^+$','$\frac{c_i^+}{c_i^-}$','$p_{im}^+$'};
% base.remodel_funeralstr = bb.remodel.funeralstr;   range.remodel_funeralstr = linspace(.001, .99, npts);
% base.remodel_behaviorstr = bb.remodel.behaviorstr; range.remodel_behaviorstr = linspace(.01, .65, npts);
% base.remodel_medicalstr = bb.remodel.medicalstr;   range.remodel_medicalstr = linspace(.10, .99, npts);

% dirname = 'data/ebola/remodel_when';
% ptitles = {'Traditional Funeral','Change Infected Contacts','Medical Availability'};
% xlbl = {'Day Change Occurred','Day Change Occurred','Day Change Occurred'};
% base.remodel_funeralwhen = bb.remodel.funeralwhen;
% range.remodel_funeralwhen = linspace(base.remodel_funeralwhen-14,base.remodel_funeralwhen+14, npts);
% base.remodel_behaviorwhen = bb.remodel.behaviorwhen;
% range.remodel_behaviorwhen = linspace(base.remodel_behaviorwhen-14, base.remodel_behaviorwhen+14, npts);
% base.remodel_medicalwhen = bb.remodel.medicalwhen;
% range.remodel_medicalwhen = linspace(base.remodel_medicalwhen-14, base.remodel_medicalwhen+14, npts);

% dirname = 'data/ebola/tau'; % Make directory for this run
% tau.become_infectious = 7; % avg days E->I
% tau.no_med_death = 15; % avg days for the disease to kill you w/o medical care
% tau.no_med_recover = 20; % avg days for you to stop being infectious w/o medical
% tau.funeral = 1; % avg days for the funeral
% tau.med_dead = 7; % avg time spent in the hospital of those that die there
% tau.medical_response = 7; % avg days to a hospital, due to availability/behavior; not fixed???

% params.base = base;
% params.range = range;

%data.pnames = fn;% {'beta_I','beta_M','beta_F','b_EM','b_IF','b_IM'};
%data.qnames = {'Cumu Exposed','Cumu Medical','Cumu Funerals','Cumu Deaths'};
%data = get_range_data(data, params, true, blackboxHandle)

% disp('gen plots')
% generate_plots_2(params.base, params.range, ptitles, xlbl, dirname, blackboxHandle);

% disp('gen table')
% generate_table(params.base, dirname, blackboxHandle);

    function Q = qp_wrapper(P)
        % QP_WRAPPER  calculates specific output quantities based on a set of parameters
        
        soln = solve_balanced_wrapped(P, bb);

        Q.total_exposed = soln.y(8,end); % last cumulative reading
%         Q.frac_medical = soln.y(10,end) / Q.total_exposed;
%         Q.frac_funerals = soln.y(11,end) / Q.total_exposed;
        Q.total_dead = soln.y(7,end);
%         Q.frac_dead = soln.y(7,end) / Q.total_exposed;
%         ppp = wrap_params(P,bb);
%         Q.Rnaught = get_R0(ppp);
    end


end
