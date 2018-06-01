function output = solveHJBequation(params)
% solve HJB equation depending on case

    %% EXTRACT PARAMETERS
    kappa = params.kappa;
    phi = params.phi;
    psi = params.psi;
    a   = params.a;
    b   = params.b;
    c   = params.c;
    T   = params.T;
    nSteps = params.nSteps;
    
    dt = T/nSteps;
    time = (0:dt:T)';
    tau  = (T:-dt:0)';
    
    %% SOLVE HJB EQUATION BY CASE
    % case 3: phi = 0, psi = 0 
    if phi == 0 && psi == 0
        
        f2 = -(1/c + 1/a*tau).^(-1);
        g2 = -(1/c + 1/b*tau).^(-1);
        u = zeros(nSteps+1,1);
        
        f11 = -f2 .* (exp(-kappa*tau)*(1/c - 1/(a*kappa)) + 1./f2 + 1/(a*kappa));
        g11 =  g2 .* (exp(-kappa*tau)*(1/c - 1/(b*kappa)) + 1./g2 + 1/(b*kappa));
    
    % case 2: phi > 0, psi = 0 
    elseif phi > 0 && psi == 0
        
        gamma1 = sqrt(phi/a);
        gamma2 = sqrt(phi/b);
        zeta1 = (c + sqrt(a*phi)) / (c - sqrt(a*phi));
        zeta2 = (c + sqrt(b*phi)) / (c - sqrt(b*phi));
        
        f2 = sqrt(a*phi) * (1 + zeta1*exp(2*gamma1*tau))./(1 - zeta1*exp(2*gamma1*tau));
        g2 = sqrt(b*phi) * (1 + zeta2*exp(2*gamma2*tau))./(1 - zeta2*exp(2*gamma2*tau));
        u = zeros(nSteps+1,1);
        
        f11 = -kappa ./ (zeta1*exp(gamma1*tau) - exp(-gamma1*tau))  .* ...
            ( zeta1 .* exp(gamma1*tau) .* (1-exp(-(kappa+gamma1)*tau))/(kappa+gamma1) ...
                - exp(-gamma1*tau) .* (1-exp(-(kappa-gamma1)*tau))/(kappa-gamma1)  );
        g11 =  kappa ./ (zeta2*exp(gamma2*tau) - exp(-gamma2*tau))  .* ...
            ( zeta2 .* exp(gamma2*tau) .* (1-exp(-(kappa+gamma2)*tau))/(kappa+gamma2) ...
                - exp(-gamma2*tau) .* (1-exp(-(kappa-gamma2)*tau))/(kappa-gamma2)  ); 
    
    % case 1: phi > 0, psi > 0
    elseif psi > 0
                        
        options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-5]);
        [~, Y] = ode45(@(t,y)ODEsystem(t,y,a,b,phi,psi), ...
                                        [T:-dt:0],[-c -c 0],options);
        Y = Y(end:-1:1,:);
        
        f2 = Y(:,1);
        g2 = Y(:,2);
        u  = Y(:,3);
        
        options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
        [~, Y] = ode45(@(t,y)ODEsystem2(t,y,a,b,kappa,time,f2,g2,u), ...
                         [T:-dt:0],[0 0],options);
        Y = Y(end:-1:1,:);

        f11 = Y(:,1);
        g11 = Y(:,2);
        
    end
    
    %% ORGANIZE OUTPUT
    output.tau = tau;
    output.time = time;
    output.f2 = f2;
    output.g2 = g2;
    output.u = u;
    output.f11 = f11;
    output.g11 = g11;

end