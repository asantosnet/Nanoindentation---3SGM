function [ frases ] = langueinterfmachineech( langue )
% Cette fonction constitue le dictionnaire anglais/français qui constituera
% l'intégralité du texte présent dans notre interface et permettra le changement 
% de langue en fonction du souhait de l'utilisateur 
if langue == 1
    % cette cellule va contenir le string, la taille doit être la même que
    % la quantité de string
    frases=cell(3,1); 
    
    % pour l'interface selectionnersmat
    
    frases{1}= 'On affiche ici le graphique de Smachine non corrigé du matériau en bleu et le graphique de  machine corrigé du matériau étudié en rouge. En vert on affiche une droite passant par les points corrigés. La courbe noire représente la courbe décalée.';
    frases{2} = 'Enregistrer le graphique'; %de Smachine pour cet échantillon
    frases{3} = 'Suivant';
    frases{4}= 'Rayon de Contact (m)';
    frases{5}= 'Raideur (N/m)';
    frases{6} = 'Raideur en fonction du rayon de Contact';
    frases{7} = 'Enregistré';
    frases{8} = 'Calculer modul d''Young';
    frases{9}  = 'Rentrez la constante de poisson';
    frases{10} = 'Veuillez rentrer la constante de poisson';
    frases{11} = 'La valeur du module d''Young trouvée est : ';
    frases{12} = 'Supprimer / Voir module d''Young';
    frases{13} = 'Vous n''avez rien selectionné';
    frases{14} = 'Vous avez bien supprimé - ';
    frases{15} = 'Le module d''Young n''a pas été calculé pour ce fichier';
    frases{16} = 'Retour';
    frases{17} = 'Aide';

else if langue == 2
    % cette cellule va contenir le string, la taille doit être la même que
    % la qtt de string
    
    frases=cell(3,1);
    
    frases{1} = 'We will plot in blue the graph of the not corrected S for the material and in red the graph of the  corrected S for the material. The green line is the one that passes by the corrected points.The plot in black is the graph that passes through the origin';
    frases{2} = 'Save the graph'; %of S machine for the material
    frases{3} = 'Next';
    frases{4}= 'Contact Radius (m)';
    frases{5}= 'Stifness (N/m)';
    frases{6}= 'Stifness as a fonction of the contact Radius';
    frases{7} = 'Saved';
    frases{8} = 'Calculate Young''s Modulus';
    frases{9} = 'Please provide the Poisson coefficient';
    frases{10} =  'You haven''t written any value for Poisson';
    frases{11} = 'The value for the Young''s Modulus that was found is  : ';
    frases{12} = 'Remove / See Young Modulus';
    frases{13} = 'You haven''t selected anything yet';
    frases{14} = 'You have successfully deleted - ';
    frases{15} = 'You haven''t calculated the Young Modulus for this file';
    frases{16} = 'Return';
    frases{17} = 'Help';
    end
end


end
