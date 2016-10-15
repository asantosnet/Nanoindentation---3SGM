function [ Apetit] = RetrouverRayonpetit( polynome, pas,B,posdernierrayonpetite )

% en utilisant les polyonmes retrouv�es avant on va ici retrouver les
% Rpetit pour la �chantillon
% B ici est la matrice du echantillon, donc , du Biolox par example.

% combien de fonctions on a
[ndroits,~]=size(polynome);
minval = 0;
maxval = pas;

for k=1:ndroits
    
    % la position du premier val apr�s le minval pour le Biolox et on si'nterrese de
    % l'invervale 1:(posdernierrayonpetite-1)
    posmin = find(B(1:(posdernierrayonpetite-1),1)>minval,'first');
    
    % la position du premier val apr�s le maxval pour le Biolox
    posmax = find(B(1:(posdernierrayonpetite-1),1)<maxval,'first');
    
    % Sinon on a un probl�me ou le valeur sera 0
    if posmin<posmax
        
        % On fait , le point x qui appartient � la droit qu'on veut - le x
        % initiale de cette droite, donc polynome(k,3), tout �a multipli�
        % par la pente, polynome(k,1) et  + la constante, donc polynome(k,2)
        Apetit(posmin:posmax,1) = polynome(k,1).*(B(posmin:posmax,1)- polynome(k,3)) + polynome(k,2);
    
    end
    
    % on passe o prochaine max et minval
    minval = maxval;
    maxval = maxval + pas;

end

end

