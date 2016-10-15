function [langue, Smachine, Smachinestring ] =selectionersamt(langue,D,C,Effective,fichier,feuilles)

% Dans cette interface l'utilisateur va selectioner la plage de valeur
% qu'il faut utiliser et decider le valeur plus proche de Smachine, (un
% valeur aproxime)
% Effective est le valeur de Effective
% Les fichiers et les feuilles ici sont celles de la calibration


% Cette fonction est l'interface qui permettre l'utilisateur de chosir une
% aproxximation pour le Smachine, l'aproximation de Smachine
% précis sera faite aprés en utilisant ce software. 
% Le Smachine est un renvoié est une cellule, la moyenne serait fait aprés.
% Je prefere envoyer les valeurs sans faire la moyenne car si j'ai la
% besoin de les utiliser individuallement aprés, il faut que j'aye acess a
% tous les valeurs.
% Smachinestring il y les valeur et fichier et feuille à lequelle ce valeur
% est associé. Moi je ne l'utilise pas ici, mais, sa peut être interessent
% de pouvoir les avoir.
% D  = rayon de ciontact et C = matrice sont les cellules avec les valeurs pour tracer les differents
% plots

% je sais que utilisser set ( nomplot,'Xaxis',matrix) est plus vite, mais
% comme je veut qu'on puisse la "ploter" pour plusieurs feuilles
% differentes, la faiçon que je retrouvé est seulement celle qui est
% utilisé ici. Par ex set(curve,'YData',Smat(pospremierval:(tailleA-1),1));
                        %set(curvinit,'LineWidth',0.3);
                        %set(curve,'YData',Smat(:,4));




fig1 = figure('numbertitle','off','name','IntGraphique');

set(fig1, 'Units','Normalized','position', [0.1, 0.1, 0.8, 0.8])

% Mettre une couleur en arrière plan
set(gcf,'Color','white')

% Initialisation des variables qui seront utilisées 

Smachine=zeros(1,1);
Smachinestring = cell(1,1);

titre = langueselectionersamt( langue );
valSmachine = 1;
valslideravantr=0;
valslideravantm=0;

% ça marche comme pour posfichierCalibration dans Objet Graphique
posfichier=1;
posfeuille = 1;
posmachine = 1;
Smat = zeros(1,1);

% Bouton sélection langue

bpUk= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.86,0.95,0.07,0.05],'string',...
    'Uk','Callback',@foncbpuk); %#ok<NASGU>

bpFr= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.93,0.95,0.07,0.05],'string',...
    'Fr ','Callback',@foncbpfr); %#ok<NASGU>

bpSuivant= uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0.93,0.001,0.07,0.06],'string',...
titre{22},'Callback',@foncsuivant);

% il serait utilisé pour ouvrir le tutorielle
    
bphelp= uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0,0.95,0.05,0.05],'string',...
titre{21},'Callback',@fonchelp);

%explication de comment utiliser la fenetre

text1 = uicontrol(fig1,'style','text','Units','Normalized',...
'position',[0.25,0.8,0.50,0.07],'string',...
titre{1},...
'fontsize',10,'BackGroundcolor','white'); 

% explication de comment faire varier Smachine

text4 = uicontrol(fig1,'style','text','Units','Normalized',...
        'position', [0.665 0.58 0.280306715063521 0.047],...
        'string',...
        titre{5},...
        'fontsize',10,'BackGroundcolor','white'); 
% pour mettre un valeur initialle pour le Smachine

txtbox = uicontrol(fig1,'Style','edit',...
                'String',titre{4},...
                 'Units','Normalized','Position',[0.696099818511796 0.520377358490566 0.23402722323049 0.050566037735849],...
                 'callback',@fonImput);


% pour modifier comment le slider va varier
%scrolbox

listboxitens={'1','10' ,'10e+1','10e+2','10e+3','10e+4','10e+5','10e+6','10e+7','10e+8'};
listboxchoixordre = uicontrol('parent',fig1,'Style','listbox','String',listboxitens,...
                                'Units','Normalized','Position',[0.706009074410163 0.255849056603774 0.0625753176043567 0.077358490566038],...
                                'callback',@foncChoix1);         %#ok<NASGU>

% pour explique au utilisatuer 

text5 = uicontrol(fig1,'style','text','Units','Normalized',...
        'position', [0.7806099818511797 0.255849056603774 0.154827586206897 0.0773584905660384],...
        'string',...
        titre{6},...
        'fontsize',10,'BackGroundcolor','white'); 
    
% slider, pour qu'on puisse faire varier le Smachine

% les pas de modification par défaut, il peut modifier ce valeur

majorstep=10e-11;
minorstelp=10e-10;
majorstep2=10e-11;
minorstep2=10e-10;

% J'ai creer deux "slider" car j'avais un probléme liée au valeur " Value"
% qu'on devait recuperer(donc Smachine), car chaque fois qui je essaye d'augmanter ou reduire il me disait que le valeur
% "Value" etait égale au "Min", donc si je faisait get(saugmante,'Value) j'avais un chose completement faux. Je n'arrivais pas a modifier
% correctement le valeur de Smachine sans les deux.


% pour augmanter le valeur
saugmante = uicontrol(fig1,'Style','slider',...
                'Min',1,'Max',10^9,'Value',1,...
                'SliderStep',[ minorstelp majorstep],...
                'Units','Normalized','Position', [0.696099818511796 0.464377358490566 0.13402722323049 0.050566037735849],...
                'callback',@fonctionslider);

% pour reduire le valeur           
sreduit = uicontrol(fig1,'Style','slider',...
                'Min',1,'Max',10^9,'Value',1,...
                'SliderStep',[ minorstep2 majorstep2],...
                'Units','Normalized','Position', [0.696099818511796 0.40377358490566 0.13402722323049 0.050566037735849],...
                'callback',@fonctionslidereduit);


% Panel où je va mettre la plot

panelplot = uipanel('Parent',fig1,'FontSize',12,...             
                    'BackgroundColor', 'white',...
                    'Units','Normalized',...
                    'Position', [0.050137055837563 0.103019538188277 0.61030456852792 0.593250444049736]);


% Button pour applquer la correction dans la plot

bpappliquer= uicontrol('parent',fig1,'style','push','Units','Normalized',...
        'position',[0.85 0.43 0.12 0.05],'string',...
        titre{12},'Callback',@foncappliquer); 
    
% Button pour enregistrer le valeur de Smachine

bpenregisterSmachine= uicontrol('parent',fig1,'style','push','Units','Normalized',...
                            'position',[0.70,0.001,0.22,0.06],'string',...
                            titre{13},'Callback',@foncenregister);
                        
% Pour voir les Smachine enregistrés

bpvoirSmachines= uicontrol('parent',fig1,'style','push','Units','Normalized',...
                            'position',[0.52,0.001,0.17,0.06],'string',...
                            titre{15},'Callback',@foncenvoir); 
                        
% pour suprimmer un Smachine

bpsupprimerSmachines= uicontrol('parent',fig1,'style','push','Units','Normalized',...
                            'position',[0.34,0.001,0.17,0.06],'string',...
                            titre{17},'Callback',@foncensupprimer);
                       

% liste deroulent pour les fichier, feuilles.

listboxfichier = uicontrol('parent',fig1,'Style','listbox','String',fichier,...
                                'Units','Normalized','Position',[0.706009074410163 0.150849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfichier);  %#ok<NASGU>       

listboxfeuille = uicontrol('parent',fig1,'Style','listbox','String',feuilles{1},...
                                'Units','Normalized','Position',[0.856009074410163 0.150849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfeuille);    


%On va tracer la plot en utilisent ces valeurs

A=D{posfichier}{posfeuille};
T=C{posfichier}{posfeuille};

subplot(1, 1, 1, 'Parent', panelplot);
% pour supprimer les plots qui on éte fait avant
cla;
% la fonction qui va renvoyer les differents courbes.
% je fait une fonction car je l'utilise plusiers fois
creerplot(A,T,Effective,titre,Smat,2);

    %----------------------------------------------------------------------------------
    
     function foncChoix1(hObject, ~, ~)
        % Pour récupérer une valeur sélectionnée dans la lisbox. Cela retourne le 
        % numéro de la ligne de l'élément sélectionné

        pos = get(hObject,'value');
        valeur=listboxitens{pos};

        valeur=str2double(valeur);
        
        %pour modifier le pas de la slider
        setp=zeros(1,1);
        setp(1,1) = valeur/(10^9);
        setp(1,2) = valeur/(10^8);
        set(saugmante,'SliderStep',[  setp(1,1)  setp(1,2)])
        set(sreduit,'SliderStep',[ setp(1,1)  setp(1,2)])
     end

    %----------------------------------------------------------------------------------

    function fonctionslider(hObject, ~, ~)
    
        valslider = get(hObject,'value');
        valSmachine=valSmachine + abs(valslider-valslideravantm);     
        valslider2 = num2str(valSmachine);
        
        % pour afficher le valeur actuel au utilisateur
        
        set(txtbox,'String',valslider2)
        valslideravantm=valslider;

    end
    
    %----------------------------------------------------------------------------------

    function fonctionslidereduit (hObject, ~, ~)
        
        % pour actualizer le valeur qui apparait pour l'utilisateur
        
        valslider = get(hObject,'value');
        valSmachine=valSmachine - abs(valslider-valslideravantr);       
        valslider2 = num2str(valSmachine);    
        
        % pour afficher le valeur actuel au utilisateur
        
        set(txtbox,'String',valslider2);   
        valslideravantr=valslider;
    end

    %----------------------------------------------------------------------------------

    function fonImput(hObject, ~, ~)
    % cette Fonction va recuperer le valeur fourni par le utilisateur

        valimput=get(hObject,'string');

        % on va recuperer le valeur associé au imput
        
        valSmachinepossible = str2double(valimput);
        % pour savoir si on vraiement que des chifres
        status = all(ismember(valimput,'0123456789+-.eE'));
        if status 
            
            % on va ici appliquer la correction du Smachine et modifier la
            % curbe
            
            % on corrige la raideur
            [tailleA,~]=size(D{posfichier}{posfeuille});
            pospremierval = find(A,1,'first');
            Smat = rechargerplot(valimput,titre{11},tailleA,C{posfichier}{posfeuille},pospremierval);
            valSmachine=valSmachinepossible;
            
            % on modifie la courbe
            subplot(1, 1, 1, 'Parent', panelplot);
            cla;
            creerplot(D{posfichier}{posfeuille},C{posfichier}{posfeuille},Effective,titre,Smat,0.3);
            
        else
            warndlg(titre{9});
        end
    end

    %----------------------------------------------------------------------------------

    function foncappliquer ( ~, ~)
        % cette fonction vas appliquer la correction à la plot en utilisant
        % le valeur de Smachine dans le txtbox.
        % J'ai la fait car Sylvan Meille m'avais demandé

        valimput=get(txtbox,'string');

        % pour savoir si on vraiement que des chifres
        status = all(ismember(valimput,'0123456789+-.eE'));
        if status 
            % on va ici appliquer la correction du Smachine et modifier la
            % curve
            
            [tailleA,~]=size(D{posfichier}{posfeuille});
            pospremierval = find(A,1,'first');
            Smat = rechargerplot(valimput,titre{11},tailleA,C{posfichier}{posfeuille},pospremierval);
            
            subplot(1, 1, 1, 'Parent', panelplot);
            cla;
            creerplot(D{posfichier}{posfeuille},C{posfichier}{posfeuille},Effective,titre,Smat,0.3);
                
        else
            warndlg(titre{9});
        end


    end

     %----------------------------------------------------------------------------------

    function foncfichier (hObject, ~, ~)
        % Fonction pour recuperer quelle fichier on est en train d'utiliser
        
        posfichier = get(hObject,'value');
        set(listboxfeuille,'String',feuilles{posfichier});
    end

     %----------------------------------------------------------------------------------

    function foncfeuille (hObject, ~, ~)
        % Cette fonction va reinitialiser la plot en prennent compte de la
        % feuille choisi par l'utilisateur

        posfeuille = get(hObject,'value');
        
        subplot(1, 1, 1, 'Parent', panelplot);
        cla;
        creerplot(D{posfichier}{posfeuille},C{posfichier}{posfeuille},Effective,titre,0,2);

    end

    %----------------------------------------------------------------------------------

    function foncenregister( ~, ~)
        % cette fonction va enregister le valeur de Smachine et l'assosier
        % au valeur du echantillon
        
        valeurtxt = get(txtbox,'String');
        status = all(ismember(valeurtxt,'0123456789+-.eE'));
        if  status  
            
            % Je ne sais pas combien de fois il va choisir le Smachine, donc je
            % ne peut pas intializer avant
            Smachine(posmachine,1)= str2double(valeurtxt);
            
            % pour recuperer le fichier et la feuille correspondent à ce
            % Smachine
            strposmachine = num2str(posmachine);
            valeurenregistrer = strcat(strposmachine,' -  ',fichier{posfichier},feuilles{posfichier}{posfeuille},'   ----- ',valeurtxt);
            Smachinestring{posmachine,1} = valeurenregistrer;
            posmachine = posmachine +1;
            
            % Pour confirme l'enregistrement
            avisoenregistrement = strcat(valeurtxt,titre{14});
            warndlg(avisoenregistrement);
        else
            warndlg(titre{9});
        end
    end

     %----------------------------------------------------------------------------------

    function foncenvoir ( ~, ~)
        
        % il va afficher les Smachines qui on éte enregistrées
       if cellfun(@isempty,Smachinestring);
            warndlg(titre{16});
       else
           listdlg('PromptString',titre{18},...
                    'SelectionMode','single',...
                    'ListString',Smachinestring,'ListSize',[300,200]);
 
       end
    end
    
     %----------------------------------------------------------------------------------

    function foncensupprimer(~,~)
    % il va supprimer le valeur selectioné

    [Selection,ok] = listdlg('PromptString',titre{18},...
                    'SelectionMode','single',...
                    'ListString',Smachinestring,'ListSize',[300,200]);
                
    % On cherche à savoir si le valeur choisi existe et ok==1 ça veut dire
    % qu'un valeur a éte choisi
    if Selection < posmachine && ok==1
        
        message = strcat(titre{20},Smachinestring(Selection));
        
        % pour supprimer les vaelurs des matrices et cellules
        Smachine(Selection)= [];
        Smachinestring(Selection) = [];    
        posmachine = posmachine -1;
        warndlg(message);
        
    else
        warndlg(titre{19});
    end
    
    end
    
    %----------------------------------------------------------------------------------

    function foncsuivant(~,~)
        
        uiresume(fig1);
        close(fig1);
    end

    %----------------------------------------------------------------------------------

    function foncbpuk (~,~)
        langue = 2;
        titre = langueselectionersamt ( langue);

        % ces setter ser a changer le nom des button, texts .....     
        set(bpSuivant,'String',titre{22});
        set(text1,'String',titre{1});
        set(text4,'String',titre{5});
        set(txtbox,'String',titre{4});
        set(text5,'String',titre{6});
        set(bpappliquer,'String',titre{12});
        set(bpenregisterSmachine,'String',titre{13});
        set(bpvoirSmachines,'String',titre{15});
        set(bpsupprimerSmachines,'String',titre{17});
        set(bphelp,'String',titre{21});
    end

    %----------------------------------------------------------------------------------

    function foncbpfr (~,~)
        langue = 1;
        titre = langueselectionersamt( langue );
        
        set(bpSuivant,'String',titre{22});
        set(text1,'String',titre{1});
        set(text4,'String',titre{5});
        set(txtbox,'String',titre{4});
        set(text5,'String',titre{6});
        set(bpappliquer,'String',titre{12});
        set(bpenregisterSmachine,'String',titre{13});
        set(bpvoirSmachines,'String',titre{15});
        set(bpsupprimerSmachines,'String',titre{17});
        set(bphelp,'String',titre{21});


    end

    %----------------------------------------------------------------------------------

    function fonchelp(~,~)
    
    % Comme on est sense a ouvri toujour la même application, le même
    % fichier pdf, on peut le faire comme ça
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

