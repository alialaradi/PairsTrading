function [] = plotMultipleCases(tradeOutputs,figNum)
    % loop through given outputs    
    n = length(tradeOutputs);        
    
    colorFrac_RB = linspace(0.2,1,n);
    colorFrac_Bk = linspace(0,1,n);
    colorFrac_GP = linspace(0.2,0.8,n);    
    
    for i = 1:n
        
        time = tradeOutputs{i}.time;
        alpha = mean(tradeOutputs{i}.alpha,2);
        beta = mean(tradeOutputs{i}.beta,2);        
        cash = mean(tradeOutputs{i}.cash,2);
        bookValue = mean(tradeOutputs{i}.bookValue,2);
        PnL = tradeOutputs{i}.PnL;
        
        red   = colorFrac_RB(i) * [1 0 0];
        blue  = colorFrac_RB(i) * [0 0 1];
        black = colorFrac_Bk(i) * [0.85 0.85 0.85];
        green  = colorFrac_GP(i) * [0 1 0];        
        purple = colorFrac_GP(i) * [1 0 1];
        
        % plot holdings
        subplot('position',[0.1300    0.6038    0.3147    0.3212])
        hold on
        alpha_mean = plot(time(2:end),alpha(2:end,:),'Color',red,'LineWidth',1.5);
        beta_mean = plot(time(2:end),beta(2:end,:),'Color',blue,'LineWidth',1.5);
        
        % pnl histogram and kernel-smoothed density
        subplot('position',[0.5903    0.6038    0.3147    0.3212])
        hold on
%         hist(PnL,50)
        [hts,ctrs] = hist(PnL,50);
%         bar(ctrs,hts/trapz(ctrs,hts))
        h = findobj(gca,'Type','patch');
        set(h,'EdgeColor','k','FaceColor',black,'facea',0.05,'edgealpha',0.1)        
        pd1 = fitdist(PnL','kernel','kernel','normal','support','unbounded');
        kernelPDF = pdf(pd1,linspace(ctrs(1),ctrs(end),100));
        plot(linspace(ctrs(1),ctrs(end),100),kernelPDF,'Color',black,'LineWidth',1.5)
%         patchline(linspace(ctrs(1),ctrs(end),100),kernelPDF,'edgecolor',black,'LineWidth',1.5,'edgealpha',1,'LineSmoothing','on')        
        
        % plot cash
        subplot('position',[0.1300    0.1300    0.3147    0.3212])
        hold on
        cash_mean = plot(time(2:end),cash(2:end,:),'Color',green,'LineWidth',1.5);
        
        subplot('position',[0.5903    0.1300    0.3147    0.3212])
        hold on
        bookValue_mean = plot(time(2:end),bookValue(2:end,:),'Color',purple,'LineWidth',1.5);
        
    end
    
    % latexify axes
    subplot('position',[0.1300    0.6038    0.3147    0.3212])
    axis tight
    latexAxes('Time','Holdings',9,9,...     labelFonts
                    0.16,-0.2,0.1,0.1,...   labelFracs; tickFracs
                    8,8);                 % tickfonts
	hleglines = [alpha_mean(1) beta_mean(1)];
    h = legend(hleglines,'Asset 1','Asset 2');
    set(h,'Interpreter','Latex','fontsize',8,'position',[0.1378, 0.9187, 0.1714, 0.0714])

    subplot('position',[0.5903    0.6038    0.3147    0.3212])
    axis tight
    latexAxes('PnL','Frequency',9,9,0.16,-0.2,0.1,0.1,8,8); 
    vline(0)

    subplot('position',[0.1300    0.1300    0.3147    0.3212])
	axis tight
    latexAxes('Time','Cash',9,9,0.16,-0.2,0.1,0.1,8,8);                 

    subplot('position',[0.5903    0.1300    0.3147    0.3212])
    axis tight
    latexAxes('Time','Book Value',9,9,0.16,-0.2,0.1,0.1,8,8); 
     
end