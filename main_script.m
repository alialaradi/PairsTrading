clear
clc
close all
addpath('functions')

% fix seed for random number generator
rng(0)

%% SET PARAMETERS FOR BASE CASE
% strategy parameters
params.T   = 0.25;         % terminal time
params.a   = 0.1;          % temporary impact for asset 1
params.b   = 0.1;          % temporary impact for asset 2
params.c   = 0.1;          % liquidation cost
params.phi = 0;            % absolute investory 1
params.psi = 0;            % relative inventory aversion parameter 2

params.alpha_0 = 0;        % starting position in asset 1
params.beta_0  = 0;        % starting position in asset 2

% simulation
params.nSim = 1000;        % number of simulations
params.nSteps = 1e3;       % time step size

% process dynamics
params.kappa = 5;          % mean reversion parameter
params.sigma = 0.16;       % cointengrating factor volatility
params.eta   = 0.22;       % factor 2 volatility
params.rho   = -0.3;       % instantaneous correlation
params.S1_0  = 25;         % starting value (asset 1)
params.S2_0  = 20;         % starting value (asset 2)

% to draw plots
plots = true;  

%% SOLVE BASE CASE
simOut   = simulateProcesses(params);
HJBout   = solveHJBequation(params);
tradeOut = computeTradingPath(params,simOut,HJBout);

%% PLOTS
if plots
    
    close all
    
    % plot base case HJB solution functions for different values of phi/psi
    run plotHJBfigure
    
    % plot simulated paths
    f2 = figure('Position',[100 100 500 400]);
    plotSimulatedPaths(simOut,f2,true,100)
    
    % plot trading paths (asset holdings and trading rates)
    f3 = figure('Position',[900 500 700 400]);
    plotTradePaths(tradeOut,f3,[1 0 0],[0 0 1],true,100,false)
    
    % plot histogram of PnL distribution
    run plotPnLfigure

    %% effect of increasing transaction cost, a
    
    % increasing value of a under different phi/psi cases
    aCases = [0.1 0.5 1 2.5];
    phiPsiCases = [0 0; 10 0; 10 10];
    
    % for each a value and phi/psi case compute solution and plot
    for j = 1:size(phiPsiCases,1)
        currParams = params;
        currParams.phi = phiPsiCases(j,1);
        currParams.psi = phiPsiCases(j,2);

        for i = 1:length(aCases)
            currParams.a = aCases(i);
            currHJB = solveHJBequation(currParams);
            tradeOutputs{i} = computeTradingPath(currParams,simOut,currHJB);
        end

        currF = figure('position',[34   539   0.9*580   0.9*418]);
        plotMultipleCases(tradeOutputs,currF)
        caseName = ['aCases_phi' num2str(phiPsiCases(j,1)) '_psi' num2str(phiPsiCases(j,2))];
    end

    %% effect of increasing liquidation cost, c
    
    % increasing value of c under different phi/psi cases
    cCases = [0.1 0.5 1.01 2.5];
    phiPsiCases = [0 0; 10 0; 10 10];
    
    % for each c value and phi/psi case compute solution and plot
    for j = 1:size(phiPsiCases,1)
        currParams = params;
        currParams.phi = phiPsiCases(j,1);
        currParams.psi = phiPsiCases(j,2);

        for i = 1:length(cCases)
            currParams.c = cCases(i);
            currHJB = solveHJBequation(currParams);
            tradeOutputs{i} = computeTradingPath(currParams,simOut,currHJB);
            c_meanPnL(j,i) = mean(tradeOutputs{i}.PnL);
            c_stdPnL(j,i) = std(tradeOutputs{i}.PnL);
            c_skewPnL(j,i) = skewness(tradeOutputs{i}.PnL);
            c_kurtPnL(j,i) = kurtosis(tradeOutputs{i}.PnL);
            c_VaR95PnL(j,i) = prctile(tradeOutputs{i}.PnL,5);
        end
        
        currF = figure('position',[34   539   0.9*580   0.9*418]);
        plotMultipleCases(tradeOutputs,currF)
        caseName = ['cCases_phi' num2str(phiPsiCases(j,1)) '_psi' num2str(phiPsiCases(j,2))];
    end
    
    %% effect of increasing aversion paramerters phi/psi
    newParams = params;
    newParams.b = 0.25; % break symmtery between two assets
    
    % consider increasing phi when psi is zero vs. non-zero, and vice versa
    phiPsiCases = [0 0;  2 0;  10 0;  50 0;
                   0 5; 2 5; 10 5; 50 5;
                   0 0;  0 2;  0 10;  0  50;
                   5 0; 5 2; 5 10; 5 50];    % every four rows is one block
    
	% for each phi/psi block compute solutions and plot
    k = 1;
    k2 = 1;
    for j = 1:4:size(phiPsiCases,1)
        for i = 1:4
            currParams = newParams;
            currParams.phi = phiPsiCases(j+i-1,1);
            currParams.psi = phiPsiCases(j+i-1,2);
            currHJB = solveHJBequation(currParams);
            tradeOutputs{i} = computeTradingPath(currParams,simOut,currHJB);
            phiPsi_meanPnL(k2,i) = mean(tradeOutputs{i}.PnL);
            phiPsi_stdPnL(k2,i) = std(tradeOutputs{i}.PnL);
            phiPsi_skewPnL(k2,i) = skewness(tradeOutputs{i}.PnL);
            phiPsi_kurtPnL(k2,i) = kurtosis(tradeOutputs{i}.PnL);
            phiPsi_VaR95PnL(k2,i) = prctile(tradeOutputs{i}.PnL,5);
            k = k+1;
        end
        
        currF = figure('position',[34   539   0.9*580   0.9*418]);
        plotMultipleCases(tradeOutputs,currF)
        caseName = ['phiPsiCases' num2str(k2)];
        k2 = k2+1;
    end
    
    %% effect of increasing mean reversion rate, kappa
    clear tradeOutputs
    
    % increasing value of kappa under different phi/psi cases
    kappaCases = [0.7 1.4 2.8 8.3];
    phiPsiCases = [0 0; 10 0; 10 10];
    
    % for each kappa value and phi/psi case compute solution and plot
    for j = 1:size(phiPsiCases,1)
        currParams = params;
        currParams.b = 0.25; 
        currParams.phi = phiPsiCases(j,1);
        currParams.psi = phiPsiCases(j,2);

        for i = 1:length(kappaCases)
            currParams.kappa = kappaCases(i);
            currHJB = solveHJBequation(currParams);
            tradeOutputs{i} = computeTradingPath(currParams,simOut,currHJB);
            kappa_meanPnL(j,i) = mean(tradeOutputs{i}.PnL);
            kappa_stdPnL(j,i) = std(tradeOutputs{i}.PnL);
            kappa_skewPnL(j,i) = skewness(tradeOutputs{i}.PnL);
            kappa_kurtPnL(j,i) = kurtosis(tradeOutputs{i}.PnL);
            kappa_VaR95PnL(j,i) = prctile(tradeOutputs{i}.PnL,5);
        end
        
        currF = figure('position',[34   539   0.9*580   0.9*418]);
        plotMultipleCases(tradeOutputs,currF)
        caseName = ['kappaCases_phi' num2str(phiPsiCases(j,1)) '_psi' num2str(phiPsiCases(j,2))];
    end

end