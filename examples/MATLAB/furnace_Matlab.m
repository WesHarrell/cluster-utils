furnace0 = importdata('furnace.txt','\t',1)

CHArea =  furnace0.data(:,2);
CHHght =  furnace0.data(:,4);
Age =  furnace0.data(:,7);
BTUIn =  furnace0.data(:,8);
BTUOut =  furnace0.data(:,9);
Damper =  furnace0.data(:,10);

furnace = [CHArea, CHHght, Age, BTUIn, BTUOut, Damper];

furnace(1:25,:)

% Means, standard deviations & percentiles

nanmean([CHArea, CHHght, Age, BTUIn, BTUOut])
nanstd([CHArea, CHHght, Age, BTUIn, BTUOut])
prctile([CHArea, CHHght, Age, BTUIn, BTUOut],[25 50 75],1)

summary(nominal(Damper))  % 'summary' works only on categorical variables
                          % which is why 'nominal' function call is needed

% BTU scatterplot, stratified by damper type

figure
plot(BTUIn(Damper==1),BTUOut(Damper==1),'co',BTUIn(Damper==2),BTUOut(Damper==2),'rx')
legend('EVD','TVD')
xlabel BTUIn
ylabel BTUOut
title 'BTUIn vs BTUOut for Stratified Furnace Data'
print -dpdf FM1.pdf

% BTUIn histogram & 90% parameter confidence intervals

figure
hist(BTUIn,3:2:19)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','w','EdgeColor','g')
hold on
plot(2:0.01:20, 180*normpdf(2:0.01:20,mean(BTUIn),std(BTUIn))','b')
hold off
xlabel BTUIn
ylabel Frequency
title 'BTUIn Histogram & Normal Fit'
print -dpdf FM2.pdf

[xbar, sbar, cimu, cisigma] = normfit(BTUIn,0.10);
fprintf(1,'90 pct CI about BTUIn mean: %6.2f %6.2f %6.2f\n',...
    [cimu(1); xbar; cimu(2)])
fprintf(1,'90 pct CI about BTUIn stdv: %6.2f %6.2f %6.2f\n',...
    [cisigma(1); sbar; cisigma(2)])

% Simple linear regression

mdl = fitlm(BTUIn,BTUOut)

figure 
plot(mdl)
xlabel BTUIn
ylabel BTUOut
title 'BTUIn vs BTUOut and Least Squares Regression Line'
print -dpdf FM3.pdf

figure
subplot(2,2,1); 
plotResiduals(mdl,'fitted','Color','m')
title 'Residuals vs Fitted'

subplot(2,2,2);
qqplot(mdl.Residuals.Raw)
xlabel 'Theoretical Quantiles'
ylabel 'Standardized residuals'
title 'Normal Q-Q'

subplot(2,2,3);
plotDiagnostics(mdl,'cookd')
xlabel 'Obs. number'
title 'Cook''s distance'    % two single quotes needed to produce one
[~,larg] = max(mdl.Diagnostics.CooksDistance);
larg

subplot(2,2,4);
plotDiagnostics(mdl,'contour','Color','g')
print -dpdf FM4.pdf