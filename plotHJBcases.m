function [] = plotHJBcases(time,y1,y2,y3,name)
    
    hold on
    plot(time,y1,'r','LineWidth',1.5)
    
    
    if ~isempty(y2)
        plot(time,y2,'b','LineWidth',1.5)                
    end
    
    if ~isempty(y2)
        plot(time,y3,'k','LineWidth',1.5)        
    end
    
    % adjust axes
    xlim([0 max(time)+eps])    
    y = ylabel(name,'Interpreter','Latex','FontSize',9);   
    set(y, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.15, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);
    
    dy = 0.075*(Yt(end) - Yt(1));
    dx = 0.1*(Xt(end) - Xt(1));
    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')

end