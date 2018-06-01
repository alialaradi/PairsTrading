function [] = plotSimulatedPaths(simOutput,figNum,plotSims,nSimsToPlot)
    %% EXTRACT PARAMETERS
    time  = simOutput.time;
    S1  = simOutput.S1;
    S2  = simOutput.S2;
    e = simOutput.e;
    l = simOutput.l;
    
    % if no figure number is given open a new figure
    if isempty(figNum)
        figure()
    else
        figure(figNum)
    end
        
    %% PLOT ASSET PATHS
    subplot('position',[0.1300    0.6638    0.7750    0.95*0.3412])
    hold on
    S1mean = plot(time,mean(S1,2),'r','LineWidth',2);
    S2mean = plot(time,mean(S2,2),'b','LineWidth',2);
    
    % plot all simulations if plotSims is true, otherwise plot only mean    
    if plotSims
        for i = 1:nSimsToPlot
            patchline(time,S1(:,i),'edgecolor','r','linewidth',0.25,'edgealpha',0.25);
            patchline(time,S2(:,i),'edgecolor','b','linewidth',0.25,'edgealpha',0.25);
        end
    end
    
    % legend and axes
    axis tight
    hleglines = [S1mean(1) S2mean(1)];
    h = legend(hleglines,'Asset 1','Asset 2','Location','Best');
    set(h,'Interpreter','latex','FontSize',8)
    legPos = get(h,'position');
    set(h,'position',[0.1448 0.90 1.2*legPos(3) 1.15*legPos(4)])
    y = ylabel('Asset Price','Interpreter','Latex','FontSize',8);   
    set(y, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.2, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-5.3, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-0.012, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')
    
    p  = get(y,'position');
    set(y,'position',[p(1)-0.01 p(2)]);
    p  = get(x,'position');
    set(x,'position',[p(1) p(2)-0.04]);
    
%     grid on    
    
    %% PLOT TWO FACTORS
    subplot('position',[0.1300    0.120    0.7750    0.3412])
    hold on
    e_mean = plot(time,mean(e,2),'Color',[0 0.5 0] ,'LineWidth',2);
    l_mean = plot(time,mean(l,2),'Color','k' ,'LineWidth',2);
    
    % plot all simulations if plotSims is true, otherwise plot only mean    
    if plotSims
        for i = 1:nSimsToPlot
            patchline(time,e(:,i),'edgecolor',[0 0.5 0],'linewidth',0.25,'edgealpha',0.25);
            patchline(time,l(:,i),'edgecolor','k','linewidth',0.25,'edgealpha',0.25);
        end
    end
    
    % legend and axes    
    hleglines = [e_mean(1) l_mean(1)];
    h = legend(hleglines,'Cointegration Factor','Martingale Component');
    set(h,'Interpreter','latex','FontSize',7,'Location','Southwest')
    legPos = get(h,'position');
    set(h,'position',[0.1448 0.3921 1.2*legPos(3) 1.15*legPos(4)])
    y = ylabel('Level','Interpreter','Latex','FontSize',8);   
    set(y, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.2, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-10, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-0.012, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')
        
    p  = get(y,'position');
    set(y,'position',[p(1)-0.01 p(2)]);
    p  = get(x,'position');
    set(x,'position',[p(1) p(2)-0.04]);
    
%     grid on    
    
end