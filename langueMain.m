function [ frases ] = langueMain( langue )
% Cette fonction constitue le dictionnaire anglais/français qui constituera
% l'intégralité du texte présent lors de la correction du Smachine et permettra le changement 
% de langue en fonction du souhait de l'utilisateur

if langue == 1
     % cette cellule va contenir le string, la taille doit être la même que
     % la quantité de string
    
    frases=cell(1,1);
    frases{1} = 'On applique la correction pour les échantillons';
else if langue == 2
    % cette cellule va contenir le string, la taille doit être la même que
    % la quantité de string
    frases=cell(1,1);
    frases{1} = 'Correcting  the values of the samples ';
    end
end

end



