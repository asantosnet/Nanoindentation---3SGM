function [curve,curvinit,curvdroite]=creerplot(A,T,Effective,titre,Smat,t)

%  Cette fonction va tracer, Smat en fonction de a, la droit avec pente
%  Effective et la courbe de la raideur où la correction a éte déja
%  appliqué en focntion du rayon de contact.

% On defini ici t poour qu'on puisse reduire la epaisseur de la droite
% initiale seulment aprés qu'on a pu appliquer la correction Smachine. Pour
% que l'utilisateur puisse bien differentier les deux droites

[tailleA,~]=size(A);

% retrouver le premier valeur non null pour alleger les calcules
pospremierval = find(A,1,'first');

if all(Smat == 0)
    Smateriale = T;
    d=4;
else
    Smateriale = Smat;
    d=1;
end

% pour tracer la droite avec pente Effective
S=2*Effective*A(pospremierval:tailleA,1);

%On va tracer les deux curbes

hold on
% la courbe corrigé
curve=plot(A(pospremierval:(tailleA-1),1),Smateriale(pospremierval:(tailleA-1),d),'-r','LineWidth', 2);
% la courbe non corrigé
curvinit=plot(A(pospremierval:(tailleA-1),1),T(pospremierval:(tailleA-1),4),'-b','LineWidth', t);
xlabel(titre{8});
ylabel(titre{7});
title(titre{10});
% la droite
curvdroite = plot(A(pospremierval:tailleA,1),S,'-g','LineWidth', 2);
hold off

end
