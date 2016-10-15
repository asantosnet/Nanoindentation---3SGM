function[Smat]=rechargerplot(valeur,titre,tailleA,B,pospremierval)

% cette fonction va recharger le plot en prennent en compte le SMachine
    valSmachinepossible = str2double(valeur);
    
% on va ici appliquer la correction du Smachine et modifier la
% curve
titre;%#ok<VUNUS> % il sert a rien, mais comme cette fonction est appele plusieurs fois et, alors pour éviter qu'il aie de bug je la laisse comme ça.
    
Smat=zeros(tailleA,1); % pour qu'il aie la même taille que A, pour être sure qu'il sera compatible avec la matrice A et B
for k =(pospremierval-3):tailleA

    Smat(k,1)=(B(k,4).*valSmachinepossible)./(valSmachinepossible-B(k,4));

    if k==(pospremierval-3)
        h = waitbar(k/(tailleA-(pospremierval-3)),'Loading / Attendez s''il vous plait'); 
    else
        waitbar(k/(tailleA-(pospremierval-3)));
    end
end
close(h);

     
end
