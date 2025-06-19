
clear all
close all
raw = readtable ('C:\Users\mbahranifard3\Documents\Master_2019\Matlab\Stats Analysis\Delivery method optimization\Delivery.csv');

%
    Gsum = groupsummary(raw,["group","eye"])
    %change the reference to 100 for visualizaiton
%     raw.Var2 = raw.Var2-100;
    
    figure('Units','pixels','WindowStyle','normal','Position',[50,50,700,700]);
    
    raw = rmmissing(raw, 1);
    
    [secondarygrp,gpnum] = findgroups (raw.group, raw.eye);
%         splitknot =splitapply(@mean,raw.Dist,secondarygrp);
%         amatknot =splitapply(@std,raw.Dist,secondarygrp);
    [primarygrp,prgpnum] = findgroups (raw.group);

        splitknot =splitapply(@mean,raw.Dist,primarygrp);
        func = @(x) std(x)/sqrt(length(x));
        amatknot =splitapply(@std,raw.Dist,primarygrp);
     grps=unique(secondarygrp);
    
     
%     for k = 1:size(grps)
    trashvar = primarygrp;
    trashvar (primarygrp == 1) =2;
    trashvar (primarygrp == 2) =1;
    primarygrp = trashvar;
    

    mainx=dummyvar(categorical(prgpnum));
    bp=bar([2 1 3], splitknot,'FaceColor','none','EdgeColor',[0 0 0],'LineWidth',2);
    colorvec = lines(numel(gpnum));
    hold all
    errorbar([2 1 3],splitknot,amatknot,'linestyle','none','color','k','linewidth',1.2)
%     end
%     secx=dummyvar(categorical(pri));
%     secx = secx *[1:11]';
    for i = 1:numel(gpnum)
    selection = find(secondarygrp == i);    
    scatter(primarygrp(selection),raw.Dist(selection),70,'jitter','on','jitterAmount',0.25,'markerfacecolor',colorvec(i,:),'markeredgecolor','none')
    end    
ylim ([0 .7])
ax = gca;
ax.FontSize = 18;
set(gca, 'xtick',[1 2 3],'xticklabel',{'No Magnet' 'Ring' 'Point'})
ylabel(['Off-target Index'],'fontsize', 20)
ax.XAxis.FontSize =25;
ax.YAxis.FontSize =25;


