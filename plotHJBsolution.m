function [] = plotHJBsolution(HJBoutput,figNum,colors)
    %% EXTRACT PARAMETERS 
    time  = HJBoutput.time;
    f2  = HJBoutput.f2;
    g2  = HJBoutput.g2;
    u   = HJBoutput.u;
    f11 = HJBoutput.f11;
    g11 = HJBoutput.g11;
    n = length(time);        
    
    % markers every 8 data points
    ymarkersIdx = (1:8:n);
    xmarkers = time(ymarkersIdx);    
    
    % if one color is input, plot all lines in that color
    if size(colors,1) == 1
        colors = repmat(colors,5,1);
        oneColor = true;
    else
        oneColor = false;
    end
    
    % if no figure number is given open a new figure
    if isempty(figNum)
        figure()
    else
        figure(figNum)
    end
        
    %% PLOT f2, g2, u
    subplot(1,2,1)               
    hold on
    f2Plot = plot(time,f2,'Color',colors(1,:),'LineWidth',1.5);
    g2Plot = plot(time,g2,'Color',colors(2,:),'LineWidth',1.5);
    
    % don't plot u function if it is zero
    if ~isempty(find(u,1))
        uPlot = plot(time,u,'Color',colors(3,:),'LineWidth',1.5);
        uMarkers = plot(xmarkers,u(ymarkersIdx),'^', ...                
                'MarkerEdgeColor',colors(3,:), ...
                'MarkerFaceColor',colors(3,:), ...
                'MarkerSize',0.1);
    end
    
    % place markers
    f2Markers = plot(xmarkers,f2(ymarkersIdx),'x', ...
                'Color',colors(1,:), ...
                'MarkerEdgeColor',colors(1,:),...
                'MarkerFaceColor',colors(1,:), ...
                'MarkerSize',0.1);
    g2Markers = plot(xmarkers,g2(ymarkersIdx),'o', ...
                'Color',colors(2,:), ...
                'MarkerEdgeColor',colors(2,:), ...
                'MarkerFaceColor',colors(2,:), ...
                'MarkerSize',0.1);
    
    % use markers or lines in legend depending on color input
    if oneColor
        if isempty(find(u,1))
            hleglines = [f2Markers g2Markers];
            h = legend(hleglines,'$f_2$','$g_2$','Location','Best');
        else
            hleglines = [f2Markers g2Markers uMarkers];
            h = legend(hleglines,'$f_2$','$g_2$','$u$','Location','Best');
        end
    else    
        if isempty(find(u,1))
            hleglines = [f2Plot g2Plot];
            h = legend(hleglines,'$f_2$','$g_2$','Location','Best');
        else
            hleglines = [f2Plot g2Plot uPlot];
            h = legend(hleglines,'$f_2$','$g_2$','$u$','Location','Best');
        end
    end
    
    % adjust axes
    xlim([0 max(time)+eps])
    set(h,'interpreter','latex','Fontsize',7)
    y = ylabel('Function Value','Interpreter','Latex','FontSize',8);   
    set(y, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.08, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-0.0075, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-0.018, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')
    
    %% PLOT f11, g11                        
    subplot(1,2,2)
    hold on        
    f11Plot = plot(time,f11,'Color',colors(4,:),'LineWidth',1.5);
    g11Plot = plot(time,g11,'Color',colors(5,:),'LineWidth',1.5);
    
    % place markers
    f11Markers = plot(xmarkers,f11(ymarkersIdx),'x', ...                
                'MarkerEdgeColor',colors(4,:),...
                'MarkerFaceColor',colors(4,:), ...
                'MarkerSize',1);
    g11Markers = plot(xmarkers,g11(ymarkersIdx),'o', 'Color',colors(5,:), ...
                'MarkerEdgeColor',colors(5,:), ...
                'MarkerFaceColor',colors(5,:), ...
                'MarkerSize',1);  
    
    % use markers or lines in legend depending on color input
    if oneColor
        hleglines = [f11Markers(1) g11Markers(1)];
    else
        hleglines = [f11Plot(1) g11Plot(1)];
    end
    
    % adjust axes
    xlim([0 max(time)+eps])
    h = legend(hleglines,'$f_{11}$','$g_{11}$','Location','Best');
    set(h,'interpreter','latex','Fontsize',7)    
    y = ylabel('Function Value','Interpreter','Latex','FontSize',8);   
    set(y, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
    x = xlabel('Time','Interpreter','Latex','FontSize',8);   
    set(x, 'Units', 'Normalized', 'Position', [0.5, -0.08, 0]);
    
    Xlab = get(gca, 'XTickLabel');
    Ylab = get(gca, 'YTickLabel');
    Xt = get(gca, 'XTick');
    Yt = get(gca, 'YTick');
    ax = axis;    % Current axis limits
    axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
    Yl = ax(3:4); % Y-axis limits
    Xl = ax(1:2);    
    t = text(Xt, Yl(1)*ones(1,length(Xlab))-0.08, Xlab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'XTickLabel','')
    t = text(Xl(1)*ones(1,length(Ylab))-0.018, Yt, Ylab);
    set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
    set(gca,'YTickLabel','')        

end