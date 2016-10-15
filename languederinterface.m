function [frases ] = languederinterface( langue )
% Cette fonction constitue le dictionnaire anglais/fran�ais qui constituera
% l'int�gralit� du texte pr�sent dans notre programme et permettra le changement 
% de langue en fonction du souhait de l'utilisateur 

switch langue
    case 1
        frases = cell(6,1);
        frases{1} = 'Graphique de la duret� H en fonction du quotient a/R de la sph�re';
        frases{2} = 'Pr�c�dent';
        frases{3} = 'Changer d''�chantillon';
        frases{4} = 'Calculer module d''Young';
        frases{5} = 'Enregistrer graphique sous';
        frases{6} = 'Enregistrer tous les graphiques sous';
        frases{7} = 'Le valeur du Module d''Young est : ';
        frases{8} = 'A �t� enregistr�';
        frases{9} = 'a/R';
        frases{10} = 'H(N.m-1)';
        frases{11} = 'H(a/R)';
        frases{12} = 'Aide';
    case 2
        frases = cell(6,1);
        frases{1} = 'Graph of hardness H as a function of the ratio a/R of the sphere';
        frases{2} = 'Previous';
        frases{3} = 'Change standard';
        frases{4} = 'Calculate Young modulus';
        frases{5} = 'Save graph as';
        frases{6} = 'Save all graphs as';
        frases{7} = 'The value for the Young''s modulus is : ';
        frases{8} = 'Has been saved';
        frases{9} = 'a/R';
        frases{10} = 'H(N.m-1)';
        frases{11} = 'H(a/R)';
        frases{12} = 'Help';
    otherwise
end


end

