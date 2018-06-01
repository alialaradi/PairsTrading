function [] = plotTradePaths(tradingOutput,figNum,color1,color2,plotSims,nSimsToPlot,plotCash)
    %% EXTRACT PARAMETERS
    time  = tradingOutput.time;
    alpha  = tradingOutput.alpha;
    beta  = tradingOutput.beta;
    cash  = tradingOutput.cash;
    nu = tradingOutput.nu;
    mu = tradingOutput.mu;
	n = size(nu,2);
            
    % if no figure number is given open a new figure
    if isempty(figNum)
        figure()
    else
        figure(figNum)
    end
    
    %% PLOT HOLDINGS
    subplot('position',[0.115    0.210    0.3347    0.85*0.8150])
    hold on
    alpha_mean = plot(time(2:end),mean(alpha(2:end,:),2),'Color',color1,'LineWidth',2);
    beta_mean  = plot(time(2:end),mean(beta(2:end,:),2),'Color',color2,'LineWidth',2);
    if plotCash
        cash_mean  = plot(time(2:end),mean(cash(2:end,:),2),'Color','k','LineWidth',2);
    end
    
    % plot all simulations if plotSims is true, otherwise plot only mean    
    if plotSims
        for i = 1:nSimsToPlot
            patchline(time(2:end),alpha(2:end,i),'edgecolor','r','linewidth',0.25,'edgealpha',0.25);
            patchline(time(2:end),beta(2:end,i),'edgecolor','b','linewidth',0.25,'edgealpha',0.25);
            if plotCash
                patchline(time(2:end),cash(2:end,i),'edgecolor','k','linewidth',0.25,'edgealpha',0.25);
            end
        end
    end
    
    % legend and axes    
    if plotCash
        hleglines = [alpha_mean(1) beta_mean(1) cash_mean(1)];
        h = legend(hleglines,'Asset 1','Asset 2','Cash','Location','northwest');
    else
        hleglines = [alpha_mean(1) beta_mean(1)];
        h = legend(hleglines,'Asset 1','Asset 2','Location','northwest');
    end
    
    legPos = get(h,'position');
    set(h,'Interpreter','Latex','position',[legPos(1) legPos(2) 1.15*legPos(3) 1.1*legPos(4)],'fontsize',8)
   
    % adjust axes        
    y = ylabel('Holdings','Interpreter','Latex','FontSize',9);   
    set(y, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.16, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);
    
    dy = 0.067*(Yt(end) - Yt(1));
    dx = 0.1*(Xt(end) - Xt(1));
    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')
    
    
     %% PLOT TRADING RATE
    subplot('position',[0.585    0.210    0.3347    0.85*0.8150])
    hold on
    nu_mean = plot(time(2:end),mean(nu(2:end,:),2),'r','LineWidth',2);
    mu_mean  = plot(time(2:end),mean(mu(2:end,:),2),'b','LineWidth',2);
    
    % plot all simulations if plotSims is true, otherwise plot only mean    
    if plotSims
        for i = 1:nSimsToPlot
            patchline(time(2:end),nu(2:end,i),'edgecolor','r','linewidth',0.25,'edgealpha',0.25);
            patchline(time(2:end),mu(2:end,i),'edgecolor','b','linewidth',0.25,'edgealpha',0.25);
        end
    end
    
    % legend and axes
    axis tight
    hleglines = [nu_mean(1) mu_mean(1)];
    h = legend(hleglines,'Asset 1','Asset 2','Location','northeast');
    legPos = get(h,'position');
    set(h,'Interpreter','Latex')    
    set(h,'Interpreter','Latex','position',[1.05*legPos(1) legPos(2) 1.15*legPos(3) 1.1*legPos(4)],'fontsize',8)
    
    % adjust axes
    xlim([0 max(time)+eps])    
    y = ylabel('Trading Rate','Interpreter','Latex','FontSize',9);   
    set(y, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.16, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);
    
    dy = 0.09*(Yt(end) - Yt(1));
    dx = 0.1*(Xt(end) - Xt(1));
    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')
    
    
end