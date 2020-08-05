% 'linear' | 'gaussian' | 'rbf' | 'polynomial'
tTree = templateTree('surrogate','on');
tEnsemble = templateEnsemble('GentleBoost',100,tTree);

options = statset('UseParallel',true);
Mdl = fitcecoc(X,Y,'Coding','onevsall','Learners',tEnsemble,...
                'Prior','uniform','NumBins',50,'Options',options);

CVMdl = crossval(Mdl,'Options',options);

oofLabel = kfoldPredict(CVMdl,'Options',options);
ConfMat = confusionchart(Y,oofLabel,'RowSummary','total-normalized');
ConfMat.InnerPosition = [0.10 0.12 0.85 0.85];