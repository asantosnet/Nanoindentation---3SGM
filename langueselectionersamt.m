function [ frases ] = langueselectionersamt( langue )
% Cette fonction constitue le dictionnaire anglais/français qui constituera
% l'intégralité du texte présent lors du calcul de Smachine et permettra le changement 
% de langue en fonction du souhait de l'utilisateur
if langue == 1
    % cette cellule va contenir le string, la taille doit être la même que
     % la quantité de string
    frases=cell(16,1);
    % pour l'interfaceselctionerSmat
    
    frases{1}= 'On affiche ici tous les A pour lequelles la condiction hc>300nm est respectée, ce qui explique le fait que la courbe de Stot n''est pas completement affichée.';
    frases{2} = 'Après avoir calculé le Smat on va recalculer la correction du rayon R(indenteur) pour pouvoir utiliser des valeur pour lequelles hc>300nm n''est pas respecté pour l''échantillon test ';
    frases{3} =  'Il n''est pas nécessaire de choisir Smat avec un grand soin, le logiciel va tenter d''approximer le mieux possible les deux courbes. Pour cette raison, si vous avez plusieurs essais pour l''echantillon de calibration, vous devez sélectionner Smat seulement une fois';
    frases{4} = 'Choisir une valeur pour Smachine';
    frases{5} = 'Vous pouvez ici faire varier Smachine';
    frases{6} = 'Choisir l''ordre de grandeur dans lequel vous désirer faire varier la valeur.';
    frases{9} = 'Veuillez rentrer un valeur numerique';
    frases{8} = 'Rayon de Contact (m)';
    frases{7} = 'Raideur (N/m)';
    frases{10} = 'Raideur en fonction du rayon de Contact';
    frases{11} = 'Veuillez patienter';
    frases{12} = 'Appliquer Smachine';
    frases{13} = 'Enregistrer Smachine pour cet échantillon';
    frases{14} = ' - Enregistré ';
    frases{15} = 'Voir Smachines enregistrés ';
    frases{16} = 'Vous n''avez pas encore enregistré de valeur';
    frases{17} = 'Supprimer';
    frases{18} = 'Veuillez indiquer la position';
    frases{19} = 'Valeur introuvable ou non sélectionnée';
    frases{20} = 'Vous avez bien supprimé - ';
    frases{21}  ='Aide';
    frases{22} = 'Suivant';
else if langue == 2
    % cette cellule va contenir le string, la taille doit être la même que
    % la qtt de string
    frases=cell(16,1);
    frases{1} = 'We will plot the graph for the values of A for wich the condiction hc>300nm is respected. That is why the plot of Stot doesn''t have any initial value.';
    frases{2} = 'After Smat has been calculated we will recalculate the indentor''s radius correction coefficient so we can use the values that do not respect the condition of hc>300nm for the test sample';
    frases{3} = 'It''s not necessary to chose a Smat for each calibration sample since the software will, with the value that will be chosen here for Smat, approximate the two curves (The standard''s one and the straight line(slope = E)';
    frases{4} = 'Choose Smachine';
    frases{5} = 'You can change the value of Smachine using those sliders';
    frases{6} = 'You can change the step that you''ll change the Smachine.';
    frases{9} = 'Please select a numerical value for Smachine';
    frases{8}= 'Contact Radius (m)';
    frases{7}= ' Stifness (N/m)';
    frases{10}= 'Stifness vs Contact Radius';
    frases{11}='Please Wait...';
    frases{12} = 'Apply SMachine';
    frases{13} = 'Save Smachine for this sample';
    frases{14} = 'has been saved';
    frases{15} = 'See saved Smachines ';
    frases{16} = 'You haven''t saved any value';
    frases{17} = 'Delete';
    frases{18} = 'You need to provide the position';
    frases{19} = 'Value not found or you haven''t selected anything';
    frases{20} = 'You have successfully deleted - ';
    frases{21}  ='Help';
    frases{22} = 'Next';
    end
end


end

