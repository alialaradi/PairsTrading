%% SET PARAMETERS 
% strategy parameters
paramSet.T   = 0.25;              % terminal time
paramSet.a   = 0.5;           % temporary impact for asset 1
paramSet.b   = 0.2;           % temporary impact for asset 2
paramSet.c   = 0.8;            % liquidation cost
paramSet.phi = 10;          % absolute investory 1
paramSet.psi = 10;            % relative inventory aversion parameter 2

paramSet.alpha_0 = 0;         % starting position in asset 1 
paramSet.beta_0  = 0;         % starting position in asset 2

% simulation
paramSet.nSim = 100;         % number of simulations
paramSet.nSteps = 1e3;       % time step size

% process dynamics
paramSet.kappa = 5;       % mean reversion parameter
paramSet.sigma = 0.08;       % cointengrating factor volatility
paramSet.eta   = 0.11;          % factor 2 volatility
paramSet.rho   = -0.3;            % instantaneous correlation
paramSet.S1_0  = 20;          % starting value (asset 1)
paramSet.S2_0  = 15;          % starting value (asset 2)

%% compute HJB functions for case 1-3
HJBout   = solveHJBequation(paramSet);

paramSet2 = paramSet;
paramSet2.psi = 0;
HJBout2 = solveHJBequation(paramSet2);

paramSet3 = paramSet;
paramSet3.psi = 0;
paramSet3.phi = 0;
HJBout3 = solveHJBequation(paramSet3);

%% plot
f1 = figure('Position',[400 500 750 450]);

subplot('position', [0.1000, 0.5838, 0.2134, 0.3412])
plotHJBcases(HJBout.time,HJBout.f2,HJBout2.f2,HJBout3.f2,'$f_2$')

subplot('position', [0.4089, 0.5838, 0.2134, 0.3412])
plotHJBcases(HJBout.time,HJBout.g2,HJBout2.g2,HJBout3.g2,'$g_2$')

subplot('position', [0.7178, 0.5838, 0.2134, 0.3412])
plotHJBcases(HJBout.time,HJBout.u,[],[],'$u$')

subplot(2,3,4.4)
plotHJBcases(HJBout.time,HJBout.f11,HJBout2.f11,HJBout3.f11,'$f_{11}$')

subplot(2,3,5.6)
plotHJBcases(HJBout.time,HJBout.g11,HJBout2.g11,HJBout3.g11,'$g_{11}$')

h = legend('$\phi = 10, ~ \psi = 10$','$\phi = 10, ~ \psi = 0$', ...
           '$\phi = 0, ~~ \psi = 0$','Location','Northeast');
set(h,'interpreter','latex','Fontsize',7)
legPos = get(h,'position');
set(h,'position',[1.05*legPos(1) 1.03*legPos(2) legPos(3) legPos(4)])

% save2pdf([figPath 'HJBsoln'],f1,600)