function output = computeTradingPath(params,simPathOutput,HJBoutput)    
    %% EXTRACT PARAMETERS
    time = simPathOutput.time;
    T = params.T;
    a = params.a;
    b = params.b;
    c = params.c;
    phi = params.phi;
    psi = params.psi;    
    alpha_0 = params.alpha_0;
    beta_0 = params.beta_0;
    nSteps = params.nSteps;
    nSim = params.nSim;
    S1 = simPathOutput.S1;
    S2 = simPathOutput.S2;
    e = simPathOutput.e;
    f2 = HJBoutput.f2;
    g2 = HJBoutput.g2;
    u = HJBoutput.u;
    f11 = HJBoutput.f11;
    g11 = HJBoutput.g11;
    
    %% COMPUTE OPTIMAL TRADE PATH
    dt = T/nSteps;
    nu = zeros(nSteps+1,nSim);
    mu = zeros(nSteps+1,nSim);
    alpha = zeros(nSteps+1,nSim);
    beta  = zeros(nSteps+1,nSim);
    cash  = zeros(nSteps+1,nSim);
    
    alpha(1,:) = alpha_0 * ones(1,nSim);
    beta(1,:)  = beta_0 * ones(1,nSim);
    
    f1 = repmat(f11,1,nSim) .* e;
    g1 = repmat(g11,1,nSim) .* e;
   
    for t = 2:nSteps+1
       nu(t,:) = 1/(2*a) * (2*f2(t-1)*alpha(t-1,:) + f1(t-1,:) + u(t-1)*beta(t-1,:));
       mu(t,:) = 1/(2*b) * (2*g2(t-1)*beta(t-1,:)  + g1(t-1,:) + u(t-1)*alpha(t-1,:));
       alpha(t,:) = alpha(t-1,:) + nu(t-1,:) * dt;
       beta(t,:)  = beta(t-1,:)  + mu(t-1,:) * dt;
       cash(t,:)  = cash(t-1,:) - (S1(t-1,:) + a*nu(t-1,:)).*nu(t-1,:) * dt ...
                                - (S2(t-1,:) + b*mu(t-1,:)).*mu(t-1,:) * dt;
    end
    
    bookValue = alpha.*S1 + beta.*S2;
    inverntoryAversion1 = phi * sum((alpha.^2 + beta.^2)*dt);
    inverntoryAversion2 = psi * sum(((alpha + beta).^2)*dt);
    liquidation =  (S1(end,:) - c*alpha(end,:)).*alpha(end,:) ...
                 + (S2(end,:) - c*beta(end,:) ).*beta(end,:);
    PnL = liquidation + cash(end,:);
	performanceCriteria = PnL - inverntoryAversion1 - inverntoryAversion2;
    
    %% ORGANIZE OUTPUT
    output.alpha = alpha;
    output.beta = beta;
    output.nu = nu;
    output.mu = mu;    
    output.cash = cash;
    output.PnL = PnL;
    output.time = time;
    output.inverntoryAversion1 = inverntoryAversion1;
    output.inverntoryAversion2 = inverntoryAversion2;
    output.liquidation = liquidation;
    output.performanceCriteria = performanceCriteria;
    output.bookValue = bookValue;
    
end