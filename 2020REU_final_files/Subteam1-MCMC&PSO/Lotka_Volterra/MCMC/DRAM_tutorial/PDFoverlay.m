% PDF overlay plots the parameter density functions from the Metropolis and
% DRAM parmeterizations of the Lotka-Volterra system
clear all
addpath('figures&results');

% MH DRAM
load('final_mh.mat')
chain_mh = chain;


% DRAM
load('final_dram.mat')
chain_dram = chain;

par{1} = '\alpha';
par{2} = '\beta';
par{3} = '\gamma';
par{4} = '\delta';

figure(1)
for i = 1:4
    
    subplot(2,2,i)
    
    % MH
    [y,x] = density(chain_mh(:,i),[],2);
    plot(x,y,'-k', 'color', 'b','LineWidth', 2)
    hold on
    
    % MH
    [y,x] = density(chain_dram(:,i),[],2);
    plot(x,y,'-k', 'color', 'r','LineWidth', 2)
    
    set(gca, 'FontSize', 15);
    title(par{i});
end
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel('parameter value')
set(gca, 'FontSize', 20)
hold off
    
    
    
    
    
    