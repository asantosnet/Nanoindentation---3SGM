function [langue,eta,val1,val2,posfigure,fichierCalibration,fichierCalibrationcomplet,feuillesCalibration,fichierEchantillon,fichierEchantilloncomplet,feuillesEchantillon,posmatidenteur,posmatcalibration,materiaux,Smachine] = Objet_Graphique (langue)

% Cette fonction va generer l'interface graphique, elle va renvoyer tous
% les donées nesccesaires , voir aprés pour la descritpion de chaque donée.

    fig1 = figure('numbertitle','off','name','IntGraphique');
    set(fig1, 'Units','Normalized','position', [0.1, 0.1, 0.8, 0.8])

% Mettre une couleur en arrière plan
    set(gcf,'Color','white')
    
% La position de la interface
    posfigure = 1;

% Choix des variables par défaut / initialisation des variables
% obs :  la fonction d'aire est de la forme R = val1 * hc^val2
    val1 = 370.91;
    val2 = 0.15509;
    
% Comme on a aucune idée de la quantité de fichiers, feuilles et materiau
% qu'on devrai renvoier à la fin,je peut initialize une cellule de taille
% 1,1 et augmanter sa taille au fur et a mesure que l'utilisateur ajoute
% des nouvelles donées. Ceci va pas prendre beacoup de temps non plus,car
% on ne vais pas traiter avec beacoup des fichier, feuilles ou materiaux.
    
% Le nom du fichier calibration
% Elle est une cellule est caque ligne a le nom du fichier de calibration
% On doit utiliser des cellules car les Strings sont des matrices, donc,
% pour travailler avec un grand nombre des Strings il faut utiliser des
% cellules.
    fichierCalibration = cell(1,1);
    
% Le nom plus le lien du fichier calibration
    fichierCalibrationcomplet = cell(1,1);
    
% La prochaine position où on doit enregistrer le valeurs associée aux
% fichiers. Cette position est la même pour les feuilles
    posFichierCalibration = 1;
    
% Contient les feuilles de la calibration. Dans chaque ligne on aurra une
% deuxiéme cellule qui contient les feuilles correspondents aux fichier.
% par ex : feuilles dans feuillesCalibration{2} sont celles correspondents
% aux fichier 2.
    feuillesCalibration = cell(1,1);

% La même chose mais pour le échantillon
    fichierEchantillon= cell(1,1);
    fichierEchantilloncomplet= cell(1,1);
    posFichierEchantillon = 1;
    feuillesEchantillon = cell(1,1);
    
% On va enregistrer ici tous les valeurs associées à chaque materiaux qui
% on aurra disponible par défaut
% on Commence avec Si et W 

% materiaux est une cellule contenent les donées de chaque materiau,son
% nom, le Module de Young et le coef. poisson. 
    materiaux = cell(2,1);
    
% la position du prochain materiaux
    posmateriaux = 3;
    
% on doit fournir le nom , Young, poisson dans cet ordre
    donesmateriaux = cell(3,1);
    
% pour le Si
    donesmateriaux{1}='Si';
    donesmateriaux{2}= 74000000000;
    donesmateriaux{3}= 0.17;
    materiaux{1} = donesmateriaux;
    
% la même chose pour le W
    donesmateriaux{1}='W';
    donesmateriaux{2}= 400000000000;
    donesmateriaux{3}= 0.3;
    materiaux{2} = donesmateriaux;
    
% la position du materiaux identeur et du materiaux de calibration. Comme
% il a rien choisi on met 0.
    posmatidenteur = 0;
    posmatcalibration = 0;
    
% S'il connais déja Smat il peut modifier ce valeur. Comme il a rien chosi
% on met 0.
    Smachine  = 0;

% eta est le valeur traduisent la geometrie de la point  
    eta = 0.75;
    
% la langue qui serait utilisé  1 -Français, 2 - Anglais
    [titre]=langueinterfacepanel1(langue);


% Bouton sélection langue
    bpUk= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.9,0.95,0.05,0.05],'string',...
    'Uk','Callback',@foncbpuk); %#ok<NASGU>

    bpFr= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.95,0.95,0.05,0.05],'string',...
    'Fr','Callback',@foncbpfr);%#ok<NASGU>

% Bouton Suivant
    bpSuivant= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.93,0.001,0.07,0.06],'string',...
    titre{39},'Callback',@foncSuivant);


% il serait utilisé pour ouvrir le tutorielle
    bphelp= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0,0.95,0.05,0.05],'string',...
    titre{38},'Callback',@fonchelp);

% Titre de la fenêtre
    titre1 = uicontrol(fig1,'style','text','Units','Normalized',...
    'position',[0.35,0.92,0.3,0.04],'string',...
    titre{1},...
    'fontsize',15,'BackGroundcolor','white');

% Liste de choix avec texte à côté (Etalon)
    choisirStandard = uicontrol('parent',fig1,'style','text','Units','Normalized',...
    'position',[0.02,0.65,0.3,0.04],'string',...
    titre{2},...
    'fontsize',12,'BackGroundcolor','white');
    
% On va definir str qui a le nom des tous le materiau.
    str=cell((posmateriaux-1),1);
    for t=1:(posmateriaux-1)
        str{t} = materiaux{t}{1};
    end

    listetalon = uicontrol('parent',fig1,'Style','listbox','String',str,...
    'Units','Normalized','Position',[0.3,0.65,0.1,0.05],'callback',@foncchoixStandar);

% Liste de choix avec texte à côté (Indenteur)

    choisirIndenteur = uicontrol('parent',fig1,'style','text','Units','Normalized',...
    'position',[0.02,0.45,0.3,0.04],'string',...
    titre{3},...
    'fontsize',12,'BackGroundcolor','white');

    listidenteur = uicontrol('parent',fig1,'Style','listbox','String',str,...
    'Units','Normalized','Position',[0.3,0.45,0.1,0.05],'callback',@foncchoixidenteur);     

%Bouton Ajouter un étalon

    bpAddStandard= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.5,0.65,0.15,0.05],'string',...
    titre{4},'Callback',@foncajouteretalon);

%Bouton contenant le nom du fichier étalon choisi

    bpnomfichier= uicontrol('parent',fig1,'style','edit','Units','Normalized',...
    'position',[0.7,0.8,0.2,0.05],'string',...
    titre{4},'Callback',@fonc);

% Boutton pour choisir le materiaux
    bpchoixStandart= uicontrol('parent',fig1,'style','push','Units','Normalized',...
                                'position',[0.7,0.65,0.15,0.05],'string',...
                                titre{29},'Callback',@foncchoixStandar);


    bpchoixIdenteur= uicontrol('parent',fig1,'style','push','Units','Normalized',...
                                'position',[0.7,0.45,0.15,0.05],'string',...
                                titre{30},'Callback',@foncchoixidenteur);
% Texte pour aficher le materiaxu qui a eté choisi
    textnometalon= uicontrol('parent',fig1,'style','edit','Units','Normalized',...
                            'position',[0.87,0.65,0.05,0.05],'string',...
                            '','Callback',@fonc);
    
    textnomIdenteur= uicontrol('parent',fig1,'style','edit','Units','Normalized',...
                            'position',[0.87,0.45,0.05,0.05],'string',...
                            '','Callback',@fonc);

%Bouton Ajouter un matériau indenteur
    bpAddMaterial= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.5,0.45,0.15,0.05],'string',...
    titre{5},'Callback',@foncajouteretalon);

%Texte fonction aire
    fonctionest = uicontrol('parent',fig1,'style','text','Units','Normalized',...
    'position',[0.02,0.25,0.3,0.04],'string',...
    titre{6},...
    'fontsize',12,'BackGroundcolor','white');

% Text qui montre la fonction d'aire
    equationdaire = strcat(num2str(val1),'*(hc^',num2str(val2),')');
    
    textequation = uicontrol('parent',fig1,'style','text','Units','Normalized',...
                             'position',[0.3,0.25,0.15,0.04],'string',...
                             equationdaire,...
                             'fontsize',12,'BackGroundcolor','white');




%Bouton Changer fonction d'aire
    bpChangeFoncAire= uicontrol('parent',fig1,'style','push','Units','Normalized',...
	'position',[0.5,0.25,0.15,0.05],'string',...
    titre{7},'Callback',@foncchangerfoncaire);  

% Selectioner le fixier Excel
    bpSelectexcel= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.1,0.8,0.25,0.06],'string',...
    titre{8},'Callback',@foncExcel);

% button pour selectioner la feuille
    bpselectfeuille = uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.4,0.8,0.25,0.06],'string',...
    titre{9},'Callback',@foncselectfeuille);

%Enlever fichiers
     bpenlever = uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.77,0.001,0.15,0.06],'string',...
    titre{19},'Callback',@foncenlever);


% Pour regarder les choses qu'il a selectioné
    bpvoir = uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.61,0.001,0.15,0.06],'string',...
    titre{37},'Callback',@foncvoir);



% dans le cas où il connais déja le Smachine;
    textSmachine = uicontrol(fig1,'style','text','Units','Normalized',...
    'position',[0.17,0.14,0.3,0.06],'string',...
    titre{35},...
    'fontsize',10,'BackGroundcolor','white');

    textvalSmachine= uicontrol('parent',fig1,'style','edit','Units','Normalized',...
                        'position',[0.485,0.16,0.07,0.04],'string',...
                        num2str(Smachine));
                    
% Pour qu'il puisse modifier le parametre de la point
    texteta = uicontrol(fig1,'style','text','Units','Normalized',...
    'position',[0.17,0.04,0.3,0.06],'string',...
    titre{36},...
    'fontsize',10,'BackGroundcolor','white');

    textvaleta= uicontrol('parent',fig1,'style','edit','Units','Normalized',...
                        'position',[0.485,0.06,0.07,0.04],'string',...
                        num2str(eta));
                    

    %-------------------------------------------------------------------------
    
    function foncbpuk (~,~)    
    % Permet de tout mettre en anglais 
        langue = 2;
        [titre]=langueinterfacepanel1(langue);
            set(bpSuivant,'String',titre{39})
            set(titre1,'String',titre{1})
            set(choisirStandard,'String',titre{2})
            set(choisirIndenteur,'String',titre{3})
            set(bpnomfichier,'String',titre{4})
            set(bpAddStandard,'String',titre{4})
            set(bpAddMaterial,'String',titre{5})
            set(fonctionest,'String',titre{6})
            set(bpChangeFoncAire,'String',titre{7})
            set(bpSelectexcel,'String',titre{8})
            set(bpselectfeuille,'String',titre{9})
            set(bpenlever,'String',titre{19});
            set(bpchoixStandart,'String',titre{29});
            set(bpchoixIdenteur,'String',titre{30});
            set( textSmachine,'String',titre{35});
            set( texteta,'String',titre{36});
            set( bpvoir,'String',titre{37});
            set(bphelp,'String',titre{38});
    end


    %-------------------------------------------------------------------------
    
    function foncbpfr (~,~)
    % Permet de tout mettre en français
         langue = 1;
         [titre]=langueinterfacepanel1(langue);
            set(bpSuivant,'String',titre{39})
            set(titre1,'String',titre{1})
            set(choisirStandard,'String',titre{2})
            set(choisirIndenteur,'String',titre{3})
            set(bpnomfichier,'String',titre{4})
            set(bpAddStandard,'String',titre{4})
            set(bpAddMaterial,'String',titre{5})
            set(fonctionest,'String',titre{6})
            set(bpChangeFoncAire,'String',titre{7})
            set(bpSelectexcel,'String',titre{8})
            set(bpselectfeuille,'String',titre{9})
            set(bpenlever,'String',titre{19});
            set(bpchoixStandart,'String',titre{29});
            set(bpchoixIdenteur,'String',titre{30});
            set( textSmachine,'String',titre{35});
            set( texteta,'String',titre{36});
            set( bpvoir,'String',titre{37});
	    set(bphelp,'String',titre{38});
    end


    %-------------------------------------------------------------------------
    
    function foncExcel(~,~)
        % Il vas fournir les fichiers excel
        % pour savoir s'il parle du fichier de calibration ou du
        % échantillon
        choix = questdlg(titre{13}, ...
                          '', ...
                          titre{14},titre{15},titre{16},titre{16});

        % on ajoute dans
        % la bonne cellule suivant le coix du utilisateur
        switch choix
            case titre{14}

        % Récupère le nom et l'adresse du fichier donné par l'utilisateur,
        % puis lit le fichier
              [FILENAME, PATHNAME, ~] = uigetfile('.xls', 'Sélectionnez le fichier Excel');
              if isempty(FILENAME) == 0
                  fichierCalibration{posFichierCalibration,1} = FILENAME;
                  pathfile = strcat(PATHNAME,'\',FILENAME); 
                  fichierCalibrationcomplet{posFichierCalibration,1} =pathfile;
                  posFichierCalibration = posFichierCalibration+1;
              else
                    warndlg(titre{32})
              end
              
            case titre{15}
                
        % Récupère le nom et l'adresse du fichier donné par l'utilisateur,
        % puis lit le fichier
                [FILENAME, PATHNAME, ~] = uigetfile('.xls', 'Sélectionnez le fichier Excel');
                
                % il ne peut pas être vide.
                if isempty(FILENAME) == 0
                    fichierEchantillon{posFichierEchantillon,1} = FILENAME;
                    pathfile = strcat(PATHNAME,'\',FILENAME);
                    fichierEchantilloncomplet{posFichierEchantillon,1} =pathfile;
                    posFichierEchantillon = posFichierEchantillon+1;
                else
                    warndlg(titre{32})
                end

            otherwise
                FILENAME = 0;
        end    
        % On change le string qui s'affiche à l'écran 
        set(bpnomfichier,'String',FILENAME);
    end

    %-------------------------------------------------------------------------
    
    function foncselectfeuille(~,~)
        % il va fournir les feuilles
        % on va lui demander si c'est dans la calibration ou échantillon
        % il faut savoir dans quelle fichier on doit les associer.
        choix = questdlg(titre{17}, ...
                              '', ...
                              titre{14},titre{15},titre{16},titre{16});
                          
        % On va lui demander combien de feuilles il en a dans chaque
        % fichier suivant le choix de l'utilisateur
        switch choix
            case titre{14}
                
                % il doit repeter ça pour la quantité de fichier qu'il le
                % met. Si posFichierCalibration est égale a 1, ça veut dire
                % que l'utilisateur a rien sélectioné
                if posFichierCalibration ~= 1
                    listfichier = cell((posFichierCalibration-1),1);
                    
                    %on va remplir la list
                    for k = 1:(posFichierCalibration-1)
                      % pour obtenir seulement le nom du fichier
                      apres = strcat(titre{10},fichierCalibration{k});
                      listfichier{k} = apres;  
                    end
                    
                    % pour specifier combien de lignes il peut remplir
                    numlines=1;
                    
                    % la pop up ou il doit remplir les donées
                    valeurdefeuilles=inputdlg(listfichier,'',numlines);
                    
                    % Elle va renvoier une matrice de 0 ou 1. 1 si elle
                    % n'est pas vide , 0  s'il est vide
                    booleans = ~cellfun(@isempty,valeurdefeuilles);
                    
                    % on aurra une pop up pour chauque fichier
                    % et on va verifier qu'on na pas de valeur manquente
                    if all(booleans>0.5)
                        for k = 1:(posFichierCalibration -1)
                            % on va prepare des reponse pour simplifier la vie
                            % du utilisateur
                            defaultanswer = cell(str2double(valeurdefeuilles{k}),1);
                            listfeuille = cell(str2double(valeurdefeuilles{k}),1);
                            for j = 1:str2double(valeurdefeuilles{k})
                                n = strcat('Test 00',num2str(j));
                                listfeuille{j} = '';
                                defaultanswer{j}=n;
                            end
                            numlines=1;
                            % la pop up qui va premettre le utilisateur de
                            % mettre les noms
                            nomdesfeuilles=inputdlg(listfeuille,titre{11},numlines,defaultanswer);
                            % on va actualiser les valeurs de
                            % feuillecalibration
                            feuillesCalibration{k} =nomdesfeuilles;

                        end
                    else
                        warndlg(titre{18});
                    end

                else
                    warndlg(titre{12});
                end
            case titre{15}
                % la même chose qu'avant mais pour Echantillon
                 if posFichierEchantillon ~= 1
                    listfichier = cell((posFichierEchantillon-1),1);
                    %on va remplir la list
                    for k = 1:(posFichierEchantillon-1)
                      % pour obtenir seulement le nom du fichier
                      apres = strcat(titre{10},fichierEchantillon{k});
                      listfichier{k} = apres;  
                    end
                    numlines=1;
                    % la pop up ou il doit remplir les donées
                    valeurdefeuilles=inputdlg(listfichier,'',numlines);
                    booleans = ~cellfun(@isempty,valeurdefeuilles);
                    % on aurra une pop up pour chauque fichier
                    % et on va verifier qu'on na pas de valeur manquente
                    if all(booleans>0.5)
                        for k = 1:(posFichierEchantillon -1)
                            % on va prepare des reponse pour simplifier la vie
                            % du utilisateur
                            defaultanswer = cell(str2double(valeurdefeuilles{k}),1);
                            listfeuille = cell(str2double(valeurdefeuilles{k}),1);
                            for j = 1:str2double(valeurdefeuilles{k})
                                n = strcat('Test 00',num2str(j));
                                listfeuille{j} = '';
                                defaultanswer{j}=n;
                            end
                            numlines=1;
                            % la pop up qui va premettre le utilisateur de
                            % mettre les noms
                            nomdesfeuilles=inputdlg(listfeuille,titre{11},numlines,defaultanswer);
                            % on va actualiser les valeurs de
                            %  feuillecalibration
                            feuillesEchantillon{k} =nomdesfeuilles;

                        end
                    else
                        warndlg(titre{18});
                    end

                else
                    warndlg(titre{12});
                end

            otherwise
                    
         end
        
    end
    
    %-------------------------------------------------------------------------
    
    function foncenlever(~,~)
        % il va regarder  soit les fichiers, soit feuilles

        % choisir s'il voit le feuille ou fichier. J'ai fait comme ça car
        % si on selectioné un valeur, soit par OK ou en cliquent deux fois
        % dans une listdlg, le valeur selectioné sera toujours Selection,
        % alors, s'il fait le choix de quoi il veut supprimer avant, je
        % peut "appeler" la bonne fonction.
        choix = questdlg('', ...
                              '', ...
                              titre{20},titre{21},titre{16},titre{16});
                          
        % pour rassambler les deux cellules qui existent, elles n'auront
        % pas forcement la même taille
        
        %il faut qu'il aye chosi au moin un fichier 
        if posFichierEchantillon ~= 1 || posFichierCalibration ~=1
            
            % On doit aficher tous le fichier, celles dans
            % fichierCalibration et celles dans fichierEchantillon
            fichiertotal =fichierCalibration;
            for  o=1:(posFichierEchantillon-1)
                fichiertotal{posFichierCalibration -1 +o} = fichierEchantillon{o};
            end
            [Selection,ok] = listdlg('PromptString','',...
                        'SelectionMode','single',...
                        'ListString',fichiertotal,'ListSize',[300,200]);

            switch choix
                case titre{20}
                    % dans le cas où il voit les fichiers
                    if Selection < posFichierCalibration && ok==1    
                        % si c'est un fichier de calibration, pour le supprimer
                        message = strcat(titre{22},fichierCalibration(Selection)); 
                        fichierCalibrationcomplet(Selection)= [];
                        fichierCalibration(Selection) = [];    
                        posFichierCalibration = posFichierCalibration -1;
                        warndlg(message);

                    elseif Selection > (posFichierCalibration-1) && ok==1   
                        % s'il est un fichier de echantillon , pour le
                        % supprmier
                        message = strcat(titre{22},fichierEchantillon((Selection +1 -posFichierCalibration ))); 
                        fichierEchantilloncomplet((Selection +1 -posFichierCalibration ))= [];
                        fichierEchantillon((Selection +1 -posFichierCalibration )) = [];    
                        posFichierEchantillon = posFichierEchantillon -1;
                        warndlg(message);

                    else
                        warndlg(titre{23});
                   end
                case titre{21}
                    % s'il veut qu'on supprimer ou regarder les feuilles
                    if Selection < posFichierCalibration && ok==1
                        % si c'est un fichier de calibration, pour le supprimer
                        % il faut qu'il aye selectioné au moins un feuille
                        % par fichier, s'il y a rien selectione, le
                        % feuilleCalibration{Selectio} sera un double
                        
                        if iscell(feuillesCalibration{Selection})==1
                            [Selection2,ok2] = listdlg('PromptString','',...
                                                    'SelectionMode','single',...
                                                    'ListString',feuillesCalibration{Selection},'ListSize',[300,200]);
                            if ok2==1    
                                % on va  supprimer le valeur de la feuille
                                % selectionée
                                message = strcat(titre{22},feuillesCalibration{Selection}(Selection2)); 
                                feuillesCalibration{Selection}(Selection2)= [];
                                warndlg(message);
                            end
                        else
                            warndlg(titre{33});
                        end
                    
                    % De fois j'ai l'erreur "Operands to the || and && operators must be convertible to logical scalar
                    % values." Le && sert pour comparer des valeurs
                    % scalaires pendant que & est utilisé pour les matrices
                    % si je essaye d'utiliser seulement & MATALB me fait
                    % chier avec en le lessent en jeune.Comme cette erreur ne derrange pas le fonctionemment du programme
                    % je le laisse comme ça &&.
                    elseif Selection > (posFichierCalibration-1) && ok==1   
                        % on va supprimer le valeur de  l'echantillon
                        % selectioné
                        
                        if iscell(feuillesEchantillon{(Selection +1 -posFichierCalibration )})==1
                            [Selection2,ok2] = listdlg('PromptString','',...
                                                      'SelectionMode','single',...
                                                       'ListString',feuillesEchantillon{(Selection +1 -posFichierCalibration )}, 'ListSize',[300,200]);
                            if ok2==1    
                                % on va  supprimer le valeur de la feuille
                                % selectionée
                                message = strcat(titre{22},feuillesEchantillon{(Selection +1 -posFichierCalibration )}(Selection2)); 
                                feuillesEchantillon{(Selection +1 -posFichierCalibration )}(Selection2)= [];
                                warndlg(message);
                            end
                        else
                            warndlg(titre{33});
                        end
                    else
                        warndlg(titre{23});
                   end

                otherwise
            end
        else
            warndlg(titre{34});
        end
        
        
    end
    
    %-------------------------------------------------------------------------
    
    function foncvoir (~,~)
    % cette function permmetre que l'uitlisateur regarde ce qu'il a
    % selectioné
    
    % ça marche comme la foncenlever mais sans la partie de supprimer,
    
    ok=1;
    
    % pour que quand il voit les feuilles il n'a pas besoin de fermer le
    % truc pour qu'il puisse voir pour une autre feuille
    %%%% Je veulais appliquer ça pour les autres listdlg dans le programme
    %%%% mais, j'ai n'a pas eu le temps.
    while ok==1
        
        if posFichierEchantillon ~= 1 || posFichierCalibration ~=1
                fichiertotal =fichierCalibration;
                for  ot=1:(posFichierEchantillon-1)
                    fichiertotal{posFichierCalibration -1 +ot} = fichierEchantillon{ot};
                end

                [Selection,ok] = listdlg('PromptString','',...
                            'SelectionMode','single',...
                            'ListString',fichiertotal,'ListSize',[300,200]);
            
            if Selection < posFichierCalibration && ok==1
            % si c'est un fichier de calibration, pour voir
            % la feuille 
            % il faut qu'il aye selectioné au moins un feuille
            % par fichier, s'il y a rien selectione, le
            % feuilleCalibration{Selectio} sera un double

                if iscell(feuillesCalibration{Selection})==1
                % on va afficher les feuilles associé au
                % fichier

                [~,ok2]=listdlg('PromptString','',...
                                'SelectionMode','single',...
                                'ListString',feuillesCalibration{Selection},'ListSize',[300,200]);
                
                 if ok2 ~= 1
                     ok=0;
                 end
                else
                    warndlg(titre{33});
                end

                elseif Selection > (posFichierCalibration-1) && ok==1   
                % on va afficher les feuilles associé au
                % fichier

                if iscell(feuillesEchantillon{(Selection +1 -posFichierCalibration )})==1
                    [~,ok2]=listdlg('PromptString','',...
                                    'SelectionMode','single',...
                                    'ListString',feuillesEchantillon{(Selection +1 -posFichierCalibration )}, 'ListSize',[300,200]);
                    if ok2 ~= 1
                    end
                else
                    warndlg(titre{33});
                end
        else
            warndlg(titre{23});
            end
            
         else
            warndlg(titre{34});
            ok=0;
        end
    end
                            
    end

    %-------------------------------------------------------------------------
    
    function foncajouteretalon(~,~)
    %Cette fonction permettre l'utilisataire de rajouter un échantillon
        texts={titre{24},titre{25},titre{26}};
        name=titre{27};
        numlines=1;
        doneesmat=inputdlg(texts,name,numlines);
        booleans = ~cellfun(@isempty,doneesmat);
        % on aurra une pop up pour chauque fichier
        % et on va verifier qu'on na pas de valeur manquente
        if all(booleans>0.5)
            
            % on va recuperer les valeurs fournis et le mettre dans la
            % cell qui contient les mat.
            if ischar(class(doneesmat{1})) == 1
                
                % On va ajouter les valeurs dans la cellule "intermidiaire"
                donesmateriaux{1}=doneesmat{1};
                donesmateriaux{2}= str2double(doneesmat{2});
                donesmateriaux{3}= str2double(doneesmat{3});
                
                %On va mettre les valeurs de la cellule intermidiaire dans
                %une nouvelle cellule du materiaux, on a fait comme ça car
                %la cellule de pos posmateriaux,1 n'existait pas. Alors il
                %faut la creer , on va au meme temp la remplir
                materiaux{posmateriaux,1} = donesmateriaux; 
                posmateriaux = posmateriaux+1;
                % on va encore recuperer tous ne noms
                str2=cell((posmateriaux-1),1);
                for g=1:(posmateriaux-1)
                    str2{g} = materiaux{g}{1};
                end
                % on va actualizer la list que le utilisateur peut chosir
                set(listetalon,'String',str2);
                set(listidenteur,'String',str2);
            else
                warndlg(titre{28});
            end
            
        else
            warndlg(titre{18});
        end
    end

    %-------------------------------------------------------------------------

    function foncchoixStandar(~,~)
    % on va recuperer le valeur chosi par l'utilisateur dans la lsitbox
       pos = get(listetalon,'value');
       posmatcalibration = pos;
       % on va aficher le veleur chosi
       set( textnometalon,'String', materiaux{posmatcalibration}{1});
    end
    
    function foncchoixidenteur(~,~)
    % on va recuperer le valeur chosi par l'utilisateur dans la lsitbox
       pos = get(listidenteur,'value');
       posmatidenteur = pos;
       % on va aficher le veleur chosi
       set( textnomIdenteur,'String', materiaux{posmatidenteur}{1});
    end
    function foncchangerfoncaire(~,~)
            % permettre de changer la fonction d'aire
            defaultanswer = { num2str(val1) , num2str(val2)};
            listfeuille ={ '',''};
            numlines=1;
            % la pop up qui va premettre le utilisateur de
            % mettre les valeurs
            valcoef=inputdlg(listfeuille,titre{31},numlines,defaultanswer);
            
             booleans = ~cellfun(@isempty,valcoef);
             % pour verifier qu'il ,y a aucune information qui manque
             if all(booleans>0.5)
                 val1 = str2double(valcoef{1});
                 val2 = str2double(valcoef{2});
                 equationdaire = strcat(valcoef{1},'*(hc^',valcoef{2},')');
                 set(textequation,'String',equationdaire);
             else
                warndlg(titre{18})
             end
    
    end
    
    %-------------------------------------------------------------------------
    
    function foncSuivant (~,~)
        % actualiser le vaelur de Smachine
        uiresume(fig1);
        Smachine = str2double(get(textvalSmachine,'String'));
        eta= str2double(get(textvaleta,'String'));
        % ça veut dire qu'il peut aller à la prochaine étape
        posfigure = 2;
        close(fig1);
        
        
    end
    
    %-------------------------------------------------------------------------

    function fonchelp(~,~)
    
    % Comme on est sense a ouvri toujour la même application, le même
    % fichier pdf, on peut le faire comme ça
    
    % il est inutile de mettre un otherwise ici, mais, pour les switch il
    % est mieux de toujours le mettre.
        switch langue
            case 1
                winopen('GuideFR.pdf');
            case 2
                winopen('GuideEN.pdf');
        end
        
    end

% le code va se arreter ici et on ne va pas être renvoyé a la fcontione main jusuq'a quand uiresume ou que la fenetre soit fermé
uiwait(fig1);

end


    

      