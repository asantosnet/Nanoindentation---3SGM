function [ frases ] = langueinterfacepanel1( langue )
% Cette fonction constitue le dictionnaire anglais/fran�ais qui constituera
% l'int�gralit� du texte pr�sent dans notre premi�re interface et permettra le changement 
% de langue en fonction du souhait de l'utilisateur 

if langue == 1
    % cette cellule va contenir le string, la taille doit �tre la m�me que
    % la quantit� de string
    frases=cell(11,1);
    frases{1} = 'Etalonnage et raideur';
    frases{2} = 'Choisissez votre mat�riau �talon';
    frases{3} = 'Choisissez le mat�riau indenteur';
    frases{4} = 'Ajouter un �talon';
    frases{5} = 'Ajouter un mat�riau indenteur';
    frases{6} = 'La fonction d''aire actuelle est :';
    frases{7} = 'Changer de fonction d''aire';
    frases{8} = 'S�lectionnez votre fichier Excel de donn�es';
    frases{9} = 'S�lectionnez les feuilles';
    frases{10} = 'S�lectionnez le nombre de feuilles du fichier que vous d�sirez traiter : ';
    frases{11} = 'Ecrivez le nom des feuilles pour ce fichier : ';
    frases{12} = 'Vous n''avez pas encore selectionn� de fichier, veuillez d''abord en s�lectionner un';
    frases{13} = 'Utiliser le fichier en tant que...';
    frases{14} = 'Calibration';
    frases{15} = 'Echantillon';
    frases{16} = 'Annuler';
    frases{17} = 'Utiliser la feuille en tant que...';
    frases{18} = 'Veuillez rentrer une valeur';
    frases{19} = 'Supprimer fichiers/feuilles';
    frases{20} = 'Fichier';
    frases{21} = 'Feuille';
    frases{23} = 'Valeur introuvable ou non s�lectionn�e';
    frases{22} = 'L''�l�ment suivant a bien �t� supprim� - ';
    frases{24} = 'Fournir le nom';
    frases{25} = 'Fournir le Module d''Young';
    frases{26} = 'Fournir le coefficient de Poisson';
    frases{27} = 'Veuillez rentrer les donn�es du nouvel �chantillon';
    frases{28} = 'Le nom ne doit pas �tre une valeur numerique';
    frases{29} = 'Valider mat�riau �talon';
    frases{30} = 'Valider indenteur';
    frases{31} = 'Choisir les coefficients';
    frases{32} = 'Vous n''avez rien selectionn�';
    frases{33} = 'Veuillez s�lectionner une feuille pour ce fichier';
    frases{34} = 'Il faut avoir choisi au moins un fichier de Calibration et /ou �chantillon';
    frases{35} = 'Si vous connaissez d�ja Smachine, veuillez rentrer la valeur : ' ;
    frases{36} = 'Vous pouvez rentrer manuellement le param�tre traduisant la g�om�trie de la pointe epsilon';
    frases{37} = 'Voir les fichiers/feuilles';
    frases{38} = 'Aide';
    frases{39} = 'Suivant';
else if langue == 2
    % cette cellule va contenir le string, la taille doit �tre la m�me que
    % la quantit� de string
    frases=cell(11,1);
    frases{1} = 'Calibration and stiffness';
    frases{2} = 'Choose your standard';
    frases{3} = 'Choose the indentors material';
    frases{4} = 'Add a standard';
    frases{5} = 'Add an indentor material';
    frases{6} = 'Your area function is :';
    frases{7} = 'Change area function';
    frases{8} = 'Select your Excel data file';
    frases{9} = 'Select the sheets';
    frases{10} = 'Select the number of sheets you want to input for the file : ';
    frases{11} = 'Write the name of the sheets in the file : ';
    frases{12} = 'You need to first select a file, you haven''t done that yet';
    frases{13} = 'Use the file for...';
    frases{14} = 'Calibration';
    frases{15} = 'Sample';
    frases{16} = 'Cancel';
    frases{17} = 'Use the sheet for...';
    frases{18} = 'Please enter a value';
    frases{19} = 'Remove files/sheets';
    frases{20} = 'Files';
    frases{21} = 'Sheets';
    frases{23} = 'Value not found or not selected yet';
    frases{22} = 'You have successfully deleted this element - ';
    frases{24} = 'Name';
    frases{25} = 'Young''s Modulus';
    frases{26} = 'Poisson''s coefficient';
    frases{27} = 'Input the properties of the new material';
    frases{28} = 'The name can''t be a numerical value';
    frases{29} = 'Confirm the Standart mat.';
    frases{30} = 'Confirm de Identors mat.';
    frases{31} = 'Choose the coeficients';
    frases{32} = 'You haven''t selected anything yet';
    frases{33} = 'You haven''t selected the sheets of this Excel file';
    frases{34} = 'You need to choose at least one file for the Standart material and /or one for the sample';
    frases{35} = 'If you know the value of Smachine,input the value here : ';
    frases{36} = 'This is the parameter that takes into account the shape of the tip';
    frases{37} = 'See files/sheets';
    frases{38} = 'Help';
    frases{39} = 'Next';
    end


end

