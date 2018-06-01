function simulatedPaths = simulateProcesses(params)
% simulate two processes (l,e) for the pairs trading exercise according to:
%       de(t) = -kappa * e(t) dt + sigma * dW1(t)
%       dl(t) =                     eta  * dW2(t)

    %% EXTRACT PARAMETERS
    S1_0 = params.S1_0;
    S2_0 = params.S2_0;
    kappa = params.kappa;
    sigma = params.sigma;
    eta = params.eta;
    rho = params.rho;
    T = params.T;
    nSteps = params.nSteps;
    nSim = params.nSim;
    
    dt = T/nSteps;
    time = 0:dt:T;
    e0 = 0.5*(S1_0 - S2_0);
    l0 = 0.5*(S1_0 + S2_0);
    
    %% SIMULATE PROCESSES    
    % simulate Wiener process increments
    dZ1 = normrnd(0,1,nSteps,nSim);
    dZ2 = normrnd(0,1,nSteps,nSim);
    
    % add correlation to Wiener processes
    dW1 = dZ1;
    dW2 = rho*dZ1 + sqrt(1-rho^2)*dZ2;
    
    % simulate l process
    dl = eta*dW2;
    l  = [l0*ones(1,nSim); l0 + cumsum(dl)];
    
    % simulate e process
    e = zeros(nSteps+1,nSim);
    e(1,:) = e0 * ones(1,nSim);    
        
    for t = 2:nSteps+1
        de = -kappa*e(t-1,:)*dt + sigma*dW1(t-1,:);
        e(t,:) = e(t-1,:) + de;
    end        
    
    % stock price process
    S1  = l + e;
    S2  = l - e;
    
    % vol/covariance
    V1  = sqrt(sigma^2 + eta^2 + 2*rho*sigma*eta);
    V2  = sqrt(sigma^2 + eta^2 - 2*rho*sigma*eta);
    C12 = eta^2 - sigma^2;
   
    %% ORGANIZE OUTPUT
    simulatedPaths.e = e;
    simulatedPaths.l = l;
    simulatedPaths.S1 = S1;
    simulatedPaths.S2 = S2;
    simulatedPaths.V1 = V1;
    simulatedPaths.V2 = V2;
    simulatedPaths.C12 = C12;    
    simulatedPaths.time = time;

end