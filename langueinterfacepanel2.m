function [ frases ] = langueinterfacepanel2( langue )
% Cette fonction constitue le dictionnaire anglais/français qui constituera
% l'intégralité du texte présent dans notre  interface et permettra le changement 
% de langue en fonction du souhait de l'utilisateur 
if langue == 1
    % cette cellule va contenir le string, la taille doit être la même que
    % la quantité de string
    frases=cell(1,1);
    frases{1} = 'Numéro de l''échantillon';
    frases{2} = 'Graphique de Smachine en fonction de a';
   
else if langue == 2
    % cette cellule va contenir le string, la taille doit être la même que
    % la quantité de string
    frases=cell(1,1);
    frases{1} = 'Sample number';
    frases{2} = 'Graph of Smachine as opposed to a';
    end
end


end