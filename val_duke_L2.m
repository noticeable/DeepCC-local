clear
clc

%% Options
opts = get_opts();
opts.experiment_name = '1fps_full';
opts.feature_dir = 'det_features_ide_basis_train_1fps_val';
% basis setting for DeepCC
opts.tracklets.window_width = 40;
opts.trajectories.window_width = 150;
opts.identities.window_width = 6000;
% correlation threshold setting according to `view_distance_distribution(opts)`
opts.tracklets.threshold    = 18.45;
opts.trajectories.threshold = 0;%0.468; 
opts.identities.threshold   = 0;%0.468;

opts.tracklets.diff_p    = 11;
opts.trajectories.diff_p = 0.1;
opts.identities.diff_p   = 0.1;
opts.tracklets.diff_n    = 11;
opts.trajectories.diff_n = 0.1;
opts.identities.diff_n   = 0.1;

% alpha
opts.tracklets.alpha    = 0;
opts.trajectories.alpha = 1;
opts.identities.alpha   = 0;

create_experiment_dir(opts);

%% Setup Gurobi
if ~exist('setup_done','var')
    setup;
    setup_done = true;
end

%% Run Tracker

% opts.visualize = true;
opts.sequence = 8; % val

opts.appear_model_name = '1fps_train_IDE_40/GT/model_param_L2_600.mat';
% Tracklets
opts.tracklets.spatial_groups = 0;
opts.optimization = 'KL';

% Single-camera trajectories
%opts.trajectories.use_indiff = false;
opts.trajectories.og_appear_score = false;
opts.trajectories.appearance_groups = 1;


opts.soft = 0.1;

% Multi-camera identities
%opts.optimization = 'BIPCC';
opts.identities.optimal_filter = false;
opts.identities.og_appear_score = false;
opts.identities.consecutive_icam_matrix = ones(8);
opts.identities.reintro_time_matrix = ones(1,8)*inf;

opts.identities.appearance_groups = 0;


DukeSCTs = [];
DukeMCTs = [];
for i = 1:10
    [DukeSCTs(i,:), DukeMCTs(i,:)] = test_tracker(opts,0,1,1);
end
DukeSCT = mean(DukeSCTs,1)
DukeMCT = mean(DukeMCTs,1)
