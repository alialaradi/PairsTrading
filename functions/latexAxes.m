function [] = latexAxes(xLabel,yLabel,xLabelFont,yLabelFont,...
                        xLabel_dy,yLabel_dx,xtickdy_frac,ytickdx_frac,...
                        xTickFont,yTickFont)

    % adjust axes     
    y = ylabel(yLabel,'Interpreter','Latex','FontSize',yLabelFont);   
    set(y, 'Units', 'Normalized', 'Position', [yLabel_dx, 0.5, 0]);
    x = xlabel(xLabel,'Interpreter','Latex','FontSize',xLabelFont);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -xLabel_dy, 0]);

    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);

    dy = xtickdy_frac*(Yt(end) - Yt(1));
    dx = ytickdx_frac*(Xt(end) - Xt(1));

    t = text(Xt, Yl(1)*ones(1,size(Xlab,1))-dy, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',xTickFont)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,size(Ylab,1))-dx, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',yTickFont)
    set(gca,'YTickLabel','')

end