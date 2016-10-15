
function [langue,posfigure,moduleYoung,Bdecalee,A,Bnouvaux ] =interfsmachineech(A,Bnouvaux,Bancien,fichier,feuilles,langue,poissonid,youngid)
% A sont les cellules qui vont contenir les matrices avec les rayons de
% contacts
% B sont les cellules qui vont contenir les matrices avec la raideur
% (Stiffiness)
% Cette page permet de tracer S machine du échantillon aprés avoir apliqué
% le Smachine
% Elle apparait juste après la page de Smachine nommmée "seclectionersamt"
% et "selectionert2"
% ModuleYoung est une classe dans une classe avec les valeurs pour les
% modules de Young 
% on va renvoier Bdecale, avec les valeurs de Smachine decalées, on renvoie
% A et Bnouvaux aussi pour qu'il ne soit plus nessesaire de enlever les
% zeros



fig1 = figure('numbertitle','off','name','IntGraphique');
set(fig1, 'Units','Normalized','position', [0.1, 0.1, 0.8, 0.8])

% Mettre une couleur en arrière plan
set(gcf,'Color','white')

% Initialisation des variables qui seront utilisées 


titre = langueinterfmachineech( langue );
posfichier = 1;
posfeuille = 1;
[taillefichier,~] = size(fichier);

% on va garder les modules d'young

moduleYoung = cell(taillefichier,1);

% on va garder le valeur décalé pour les B

Bdecalee = cell(taillefichier,1);



% Bouton sélection langue

bpUk=uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.86,0.95,0.07,0.05],'string',...
    'Uk','Callback',@foncbpuk); %#ok<NASGU>

bpFr=uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.93,0.95,0.07,0.05],'string',...
    'Fr ','Callback',@foncbpfr); %#ok<NASGU>

bpSuivant= uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0.93,0.001,0.07,0.06],'string',...
titre{3},'Callback',@foncsuivant);

% il serait utilisé pour ouvrir le tutorielle
    
    bphelp= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0,0.95,0.05,0.05],'string',...
    titre{17},'Callback',@fonchelp);

% Button pour enregistrer l'image du graphe

bpsaveas = uicontrol('parent',fig1,'style','push','Units','Normalized',...
                            'position',[0.66,0.001,0.15,0.06],'string',...
                            titre{2},'Callback',@foncenregister);         

%explication de comment utiliser la fenetre

text1 = uicontrol(fig1,'style','text','Units','Normalized',...
'position',[0.25,0.85,0.50,0.13],'string',...
titre{1},...
'fontsize',10,'BackGroundcolor','white'); 

% Button pour calculer le constante d'Young

bpsYoung = uicontrol('parent',fig1,'style','push','Units','Normalized',...
                            'position',[0.75,0.40,0.15,0.06],'string',...
                            titre{8},'Callback',@fonccalculyoung);
                        
% Button pour enlever les valeurs pour le module d'Young

 bpenleverYoung = uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0.49,0.001,0.15,0.06],'string',...
titre{12},'Callback',@foncenleverYoung);
                        
% Button pour revenir arriére

 bpavant = uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0.83,0.001,0.07,0.06],'string',...
titre{16},'Callback',@foncavant);
                        

% Panel où je vais mettre la plot

panelplot = uipanel('Parent',fig1,'FontSize',12,...             
                    'BackgroundColor', 'white',...
                    'Units','Normalized',...
                    'Position', [0.050137055837563 0.153019538188277 0.61030456852792 0.593250444049736]);

             
% on va initialiser et tracer la premiére plot

D=Bnouvaux{posfichier}{posfeuille};
C=A{posfichier}{posfeuille};              
E = Bancien{posfichier}{posfeuille};  

h=subplot(1,1,1,'Parent',panelplot);
cla;
[matrixBdecale,matriceA,matriceBnovaux] = tracerplotech(C,D,E,titre,2);

% pour recuperer la matrice decalé

Bdecaleefeuille =Bdecalee{posfichier};
Bdecaleefeuille{posfeuille,1} = matrixBdecale;

% on va actualizer la cellule
Bdecalee{posfichier} =  Bdecaleefeuille;

% pour sauvegarder les matrices qu'on a déja calculé zero
Bnouvaux{posfichier}{posfeuille} = matriceBnovaux;
A{posfichier}{posfeuille} = matriceA;
% liste deroulent pour les fichier, feuilles.

listboxfichier = uicontrol('parent',fig1,'Style','listbox','String',fichier,...
                                'Units','Normalized','Position',[0.706009074410163 0.550849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfichier);         %#ok<NASGU>

listboxfeuille = uicontrol('parent',fig1,'Style','listbox','String',feuilles{posfichier},...
                                'Units','Normalized','Position',[0.856009074410163 0.550849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfeuille);    



    %-------------------------------------------------------------------------
                                                       
    function foncfichier (hObject, ~, ~)
    % Fonction pour recuperer quelle fichier on est en train d'utiliser
        
        posfichier = get(hObject,'value');
        set(listboxfeuille,'String',feuilles{posfichier});
        
    end
    
    %-------------------------------------------------------------------------
    
    function foncfeuille (hObject, ~, ~)
        
    %Cette fonction va reinitialiser la plot en prennent compte de la
    % feuille choisi par l'utilisateur
        
    % on recupere la pos de la feuille
        posfeuille = get(hObject,'value');
        
        h=subplot(1, 1, 1, 'Parent', panelplot);
        cla;
        % on recupere les valeurs associées à ce feuille
        C=A{posfichier}{posfeuille};
        D=Bnouvaux{posfichier}{posfeuille};                
        E = Bancien{posfichier}{posfeuille};  
        % on trace les plot
        [matrixBdecale,matriceA,matriceBnovaux] = tracerplotech(C,D,E,titre,2);

        % pour recuperer la matrice decalé et les autres
        A{posfichier}{posfeuille} = matriceA;
        Bnouvaux{posfichier}{posfeuille} = matriceBnovaux;
        Bdecaleefeuille =Bdecalee{posfichier};
        Bdecaleefeuille{posfeuille,1} = matrixBdecale;

        % on va actualizer la cellule
        Bdecalee{posfichier} =  Bdecaleefeuille;

    end

     %-------------------------------------------------------------------------

    function foncenregister( ~, ~)
    %cette fonction permet d'enregistrer au format voulu le graphique de la
    %page . Voir fonction derinterface pour voir comment elle marche.C'est
    %la même chose.
    
    % les format pour lequelle on peut l'enregistrer
        FilterSpec = { '*.bmp';'*.jpg';'*.tif';'*.png'};

        [FileName,PathName,FilterIndex] = uiputfile(FilterSpec,'Save As');

        pathetname = strcat(PathName,'/',FileName);

        % si FilterIndex = 0 il va avoir fermé la fenetre
        if FilterIndex~= 0
            set(h,'Units','Pixel');
            p= get(h,'Position');
            rect = [(1-0.55*p(1)) (1-0.85*p(2)) 1.2*p(3) 1.2*p(4)];
            F = getframe(h,rect);
            figure
            imshow(F.cdata);
            FilterSpec2 = { 'bmp';'jpg';'tif';'png'};
            imwrite(F.cdata,pathetname, FilterSpec2{FilterIndex});
            set(h,'Units','Normalized');

            mesage = strcat(FileName,'  ',titre{7});
            warndlg (mesage);
        end
    end

     %-------------------------------------------------------------------------
   
    function foncsuivant(~,~)     
        uiresume(fig1);
        posfigure = 3;
        % dans le cas où il na pas  décide de voir la fonction plot, on va
        % calculer le bdecale qui manque ici, on les calcules separements car
        % s'il utilise par example, 10 feuilles, ça va prendre un peut de temps
        % si on fait tout d'un coup
        % On va avant verifir s'il en a des fichier pour lequelles les
        % valeur n'on éte jamais chargées, donc , les cellules de Bdecalee
        % qui sont vides
        
        booleanemptyfichier = cellfun(@isempty,Bdecalee);
        
        for j=1:taillefichier
            % on va verifier que la feuille n'est pas vide, pour savoir si
            % on a besoin de tout calculer ou pas
            
            if booleanemptyfichier(j) ==0 
                
                [taillefeuille,~] = size(feuilles{j});
                [taillebdecalee,~] = size(Bdecalee{j});

                % on va verifier avant s'il y a des vaelurs nulles dans la Bdecalee
                booleanemptyfeuille = cellfun(@isempty,Bdecalee{j});
                for t=1:taillebdecalee
                    
                    % s'il elle est vide
                    if booleanemptyfeuille(t) ==1
                        
                        % on va calculer pour cette fonction le bdecale et corriger
                        % les valeurs de bnouvaux et A
                        [Bdecalee{j}{t,1}, A{j}{t},Bnouvaux{j}{t},Bancien{j}{t},~,~] = calcluerAet2B (A{j}{t},Bnouvaux{j}{t},Bancien{j}{t});                    
                    end
                end
                % aprés on va faire si la taillebdecale n'est pas égale à celle
                % de la feuille on va calculer pour les valeur mancantes
                if taillebdecalee < taillefeuille +1
                    
                    for d= (taillebdecalee+1):taillefeuille

                        % on va calculer pour cette fonction le bdecale et corriger
                        % les valeurs de bnouvaux et A
                        [Bdecalee{j}{d,1}, A{j}{d},Bnouvaux{j}{d},Bancien{j}{d},~,~] = calcluerAet2B (A{j}{d},Bnouvaux{j}{d},Bancien{j}{d});
                    end

                end
            else
                % donc ici dans le cas où elle est vide
                
                Bdecaleefeuille = Bdecalee{j};
                [taillefeuille,~] = size(feuilles{j});
                
                for o=1:taillefeuille
                    % alors, le calcul du truc
                    
                    [Bdecaleefeuille{o,1}, A{j}{o},Bnouvaux{j}{o},Bancien{j}{o},~,~] = calcluerAet2B (A{j}{o},Bnouvaux{j}{o},Bancien{j}{o});
                end
                
                % on va actualizer la cellule
                Bdecalee{j} =  Bdecaleefeuille;
            end
        
    
        end
        close(fig1);
    end

     %-------------------------------------------------------------------------

    function foncbpuk (~,~)
        langue = 2 ;
        titre = langueinterfmachineech( langue );

        % Ces button von effectuer des changements dans la figure "de base"
        % du panel, donc elles doivent rester ici.     
        set(text1,'String',titre{1});
        set(bpSuivant,'String',titre{3});
        set(bpsaveas,'String',titre{2});
        set(bpsYoung,'String',titre{8});
        set(bpenleverYoung,'String',titre{12});
        set(bpavant ,'String',titre{16});
        set(bphelp,'String',titre{17});
    end

     %-------------------------------------------------------------------------
     
    function foncbpfr (~,~)
        langue = 1;
        titre = langueinterfmachineech( langue );
        
        set(text1,'String',titre{1});
        set(bpSuivant,'String',titre{3});
        set(bpsaveas,'String',titre{2});
        set(bpsYoung,'String',titre{8});
        set(bpenleverYoung,'String',titre{12});
        set(bpavant ,'String',titre{16});
        set(bphelp,'String',titre{17});
    end

     %-------------------------------------------------------------------------
    
    function fonccalculyoung (~,~)
        
    % l'utilisateur doit fournir le Poisson
        numlines=1;
        valeurdepoisson=inputdlg(titre{9},'',numlines);
        booleans = ~cellfun(@isempty,valeurdepoisson);
    
    % on va recuperer la matrix du Young pour le fichier qu'on est
    
        Youngfichier = moduleYoung{posfichier};
        
        if all(booleans>0.5)
            
            % la fonction qui vas calculer Young pour le materiaux
            
            Emat = calculyoung( Bnouvaux{posfichier}{posfeuille}(:,4),A{posfichier}{posfeuille}(:,1),str2double(valeurdepoisson{1}),poissonid,youngid);
            
            % on va la metre dans moduleYoung
            % je associe le valeur aux Youngfichier
            
            % si on ne met pas 1 il va creer plusiers colonnes, on veut des
            % lignes
            Youngfichier{posfeuille,1} = num2str(Emat);
            
            % Je actualize les donées dans moduleYoung
            % ici on peut lesser posfichier car on a déja le nombre de
            % places nescessaires, donc il va remplir les places déja
            % existates, qui sont dans ce cas les linges.
            moduleYoung{posfichier} =  Youngfichier;
            
            messageY = strcat( titre{11},num2str(Emat));
            
            warndlg(messageY);
        else
            warndlg(titre{10});
        end
    end

     %-------------------------------------------------------------------------
    
    function foncenleverYoung(~,~)
        
        [Selection,ok] = listdlg('PromptString','',...
                    'SelectionMode','single',...
                    'ListString',fichier,'ListSize',[300,200]);
                
        % s'il veut qu'on supprimer ou regarder les feuilles
        
        if  ok==1
                 
            % loduleYoung{Selecton} sera un double si aucun Young a été
            % selectioné
            if isa(moduleYoung{Selection},'double')
                warndlg(titre{15});
            else
                 
                booleans = ~cellfun(@isempty,moduleYoung{Selection});
            
                % On va retrouver le position pour lequelles on n'a pas 0, donc
                % qui ne sont pas nulles
                positionremplis = find(booleans);
                
                % on va creer une cell avec les valeleurs de Young qui ont
                % éte retrouvé
                [taillepos,~] = size(positionremplis);
                modulesyoungs = cell(taillepos,1);
                for k=1:taillepos
                    
                    modulesyoungs{k} = moduleYoung{Selection}{positionremplis(k)};
                    
                end

                [Selection2,ok2] = listdlg('PromptString','',...
                                        'SelectionMode','single',...
                                        'ListString',modulesyoungs,'ListSize',[300,200]);
                if ok2==1    
                    
                    % on va  supprimer le valeur de la feuille
                    % selectionée
                    
                    message = strcat(titre{14},moduleYoung{Selection}(Selection2)); 
                    moduleYoung{Selection}(Selection2)= [];
                    warndlg(message);
                end
              
            end
        else
            warndlg(titre{13});
       end
    end
    
     %-------------------------------------------------------------------------

    function foncavant(~,~)
    % cette function va faire la fenetre revenir arriére
        uiresume(fig1);
        posfigure = 1;
        close(fig1);
    end

     %-------------------------------------------------------------------------

    function fonchelp(~,~)
    
    % Comme on est sense a ouvri toujour la même application, le même
    % fichier pdf, on peut le faire comme ça. 
        switch langue
            case 1
                winopen('GuideFR.pdf');
            case 2
                winopen('GuideEN.pdf');
        end
        
    end

% attend qu'on met les valeurs

uiwait(fig1);

end

%-------------------------------------------------------------------------

function [Bdecalee, A,Bnouvaux]=tracerplotech(A,Bnouvaux,Bancien,titre,t)
%  cette fonction permet de tracer le graph Smac en fonction de a
% on va renvoyer ces 3 fonctions pour qu'il ne soit plus nescessaire
% d'enlever les zeros etc.....

[tailleA,~]=size(A);

% pour q'uil soit plus vite de enlever les valeurs nulles
pospremierval =find(A,1,'first');

% on va recalculer le raideur de faiçon qu'elle sooit décale et aussi
% enlever les zeros
[Bdecalee, A,Bnouvaux,Bancien,coef,b] = calcluerAet2B (A,Bnouvaux,Bancien);

% val max de A
maxA  = A(tailleA-(b+1),1);


hold on
plot(A(pospremierval:(tailleA-(b+1)),1),Bnouvaux(pospremierval:(tailleA-(b+1)),4),'.r', 'LineWidth',2,'MarkerSize',7);
plot(A(pospremierval:(tailleA-(b+1)),1),Bdecalee(pospremierval:(tailleA-(b+1)),1),'.k', 'LineWidth',2,'MarkerSize',10);

% on va ploter la droite de poitns que passe par la corrigé
 plot(0:(maxA/50):maxA,polyval(coef,0:(maxA/50):maxA),'-G','LineWidth',0.5);

plot(A(pospremierval:(tailleA-(b+1)),1),Bancien(pospremierval:(tailleA-(b+1)),4),'.b','MarkerSize',t);
xlabel(titre{4});
ylabel(titre{5});
title(titre{6});
hold off

end

%-------------------------------------------------------------------------

function [Bdecalee, A,Bnouvaux,Bancien,coef,b] = calcluerAet2B (A,Bnouvaux,Bancien)
% on va enlever les zeros et decaler le valeurs de la raideur
    [tailleA,~]=size(A);

    % pour q'uil soit plus vite de enlever les valeurs nulles
    pospremierval =find(A,1,'first');

    % on va faire de sort que les valeurs nulles soient enleves, si'il en reste

    poszero=find(A(pospremierval:(tailleA),1)==0);

    b=0;
    for j=1:size(poszero)
        A(poszero(j)-b+pospremierval-1,:) = [];  
        Bnouvaux(poszero(j)-b+pospremierval-1,:) = [];  
        Bancien(poszero(j)-b+pospremierval-1,:) = []; 
        b=b+1;
    end
    %On va tracer les deux curbes

    % on retrouve la droit que passe par les points corrigées
    coef = polyfit(A(pospremierval:(tailleA-(b+1)),1),Bnouvaux(pospremierval:(tailleA-(b+1)),4),1);

    [tailleAsanszeros,~]=size(A); 
    % On va utiliser le valeur ici retrouvé pour la constante de la courbe de
    % tendance pour la décaler de faiçon qu'elle passe par l'origine
    Bdecalee = zeros(tailleAsanszeros,1);
    for d=1:(tailleAsanszeros)
        Bdecalee(d,1) =  Bnouvaux(d,4)-coef(2);
    end

    % on va decaler la courbe de tendance de sort qu'elle passe par l'origine
    coef(2) = 0;



end
