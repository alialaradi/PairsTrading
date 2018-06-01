%% plot pnl histogram
meanPnL = mean(tradeOut.PnL);
sharpeRatio = mean(tradeOut.PnL)/std(tradeOut.PnL);
VaR95 = -prctile(tradeOut.PnL,5);

f4 = figure('Position',[100   580   850   350]);
subplot('position',[0.530    0.200    0.4250    0.7550])
hist(tradeOut.PnL,45)
ylim([0 125])
vline(0)
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 0 0])

xlabel('PnL')
ylabel('Frequency')
text(-32,105,['Mean PnL = ' num2str(meanPnL,3)],'Interpreter','latex','fontsize',9)
text(-32,93,['Sharpe Ratio = ' num2str(sharpeRatio,2)],'Interpreter','latex','fontsize',9)
text(-32,81,['95\% VaR = ' num2str(VaR95,3)],'Interpreter','latex','fontsize',9)

% adjust axes     
y = ylabel('Frequency','Interpreter','Latex','FontSize',9);   
set(y, 'Units', 'Normalized', 'Position', [-0.13, 0.5, 0]);
x = xlabel('PnL','Interpreter','Latex','FontSize',9);   
set(x, 'Units', 'Normalized', 'Position', [0.5, -0.14, 0]);

Xlab = get(gca, 'XTickLabel');
Ylab = get(gca, 'YTickLabel');
Xt = get(gca, 'XTick');
Yt = get(gca, 'YTick');
ax = axis;    % Current axis limits
axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4); % Y-axis limits
Xl = ax(1:2);

dy = 0.06*(Yt(end) - Yt(1));
dx = 0.06*(Xt(end) - Xt(1));

t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'XTickLabel','')
t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'YTickLabel','')

%% plot cash
subplot('position',[0.0800    0.6438    0.3347    0.312])
hold on    
cash = tradeOut.cash;
time = HJBout.time;

cash_mean  = plot(time(2:end),mean(cash(2:end,:),2),'Color',[0 0.5 0],'LineWidth',2);    

for i = 1:100
	patchline(time(2:end),cash(2:end,i),'edgecolor',[0 0.5 0],'linewidth',0.25,'edgealpha',0.25);
end   
    
% adjust axes        
y = ylabel('Cash Holdings','Interpreter','Latex','FontSize',9);   
set(y, 'Units', 'Normalized', 'Position', [-0.15, 0.5, 0]);
x = xlabel('Time','Interpreter','Latex','FontSize',8);   
set(x, 'Units', 'Normalized', 'Position', [0.5, -0.28, 0]);

Xlab = get(gca, 'XTickLabel');
Ylab = get(gca, 'YTickLabel');
Xt = get(gca, 'XTick');
Yt = get(gca, 'YTick');
ax = axis;    % Current axis limits
axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4); % Y-axis limits
Xl = ax(1:2);

dy = 0.13*(Yt(end) - Yt(1));
dx = 0.06*(Xt(end) - Xt(1));

t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'XTickLabel','')
t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'YTickLabel','')

%% plot book value
subplot('position',[0.0800    0.1900    0.3347    0.312])

hold on    
bookValue = tradeOut.bookValue;

bookValue_mean  = plot(time(2:end),mean(bookValue(2:end,:),2),'Color',[0.5 0 0.5],'LineWidth',2);    

for i = 1:100
	patchline(time(2:end),bookValue(2:end,i),'edgecolor',[0.5 0 0.5],'linewidth',0.25,'edgealpha',0.25);
end   
    
% adjust axes        
y = ylabel('Book Value','Interpreter','Latex','FontSize',9);   
set(y, 'Units', 'Normalized', 'Position', [-0.15, 0.5, 0]);
x = xlabel('Time','Interpreter','Latex','FontSize',8);   
set(x, 'Units', 'Normalized', 'Position', [0.5, -0.28, 0]);

Xlab = get(gca, 'XTickLabel');
Ylab = get(gca, 'YTickLabel');
Xt = get(gca, 'XTick');
Yt = get(gca, 'YTick');
ax = axis;    % Current axis limits
axis(axis);   % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4); % Y-axis limits
Xl = ax(1:2);

dy = 0.13*(Yt(end) - Yt(1));
dx = 0.07*(Xt(end) - Xt(1));

t = text(Xt, Yl(1)*ones(1,length(Xlab))-dy, Xlab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'XTickLabel','')
t = text(Xl(1)*ones(1,length(Ylab))-dx, Yt, Ylab);
set(t, 'HorizontalAlignment','center','VerticalAlignment','middle','Interpreter','latex','fontsize',8)
set(gca,'YTickLabel','')

% save2pdf([figPath 'PnL'],f4,600)