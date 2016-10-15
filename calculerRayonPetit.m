function [ Apetit] = calculerRayonPetit( polynome, pas,B,posdernierrayonpetite )

% en utilisant les polyonmes retrouvées avant on va ici retrouver les
% Rpetit pour la échantillon, donc ici le Biolox

% Apetit sera la matrice avec seulements les valeurs de Apetites, dont hc
% correspondant a moins de 300nm.La faiçon dont j'ai fait cette fonction,
% il suffit de la rajouter dans la matrice de rayon de contacte sans les
% rayons "petites". Il faut faire gafe pour être sure que vous le mettiez
% dans la ligne 0 jusqu'a la ligne qui est égale au valeur de la taille( lignes) de Apetit sans avoir remplace un
% valeur non nulle de la matrice de A qui n'a pas les rayons petites.

%%%%% j'ai na pas eu le temps de tester

% Combien de fonctions on a
[ndroits,~]=size(polynome);
minval = 0;
maxval = pas;

for k=1:ndroits
    
    % la position du premier val aprés le minval pour le Biolox et on si'nterrese de
    % l'invervale 1:(posdernierrayonpetite-1)
    posmin = find(B(1:(posdernierrayonpetite-1),1)>minval,'first');
    
    % la position du premier val aprés le maxval pour le Biolox
    posmax = find(B(1:(posdernierrayonpetite-1),1)<maxval,'first');
    
    % Sinon on a un probléme ou le valeur sera 0
    if posmin<posmax
        Apetit(posmin:posmax,1) = polynome(k,1).*B(posmin:posmax,1) + polynome(k,2);
    
    end
    
    % on passe o prochaine max et minval
    minval = maxval;
    maxval = maxval + pas;

end

end

