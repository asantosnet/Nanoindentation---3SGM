function [ frases ] = langueMain( langue )
% Cette fonction constitue le dictionnaire anglais/fran�ais qui constituera
% l'int�gralit� du texte pr�sent lors de la correction du Smachine et permettra le changement 
% de langue en fonction du souhait de l'utilisateur

if langue == 1
     % cette cellule va contenir le string, la taille doit �tre la m�me que
     % la quantit� de string
    
    frases=cell(1,1);
    frases{1} = 'On applique la correction pour les �chantillons';
else if langue == 2
    % cette cellule va contenir le string, la taille doit �tre la m�me que
    % la quantit� de string
    frases=cell(1,1);
    frases{1} = 'Correcting  the values of the samples ';
    end
end

end



