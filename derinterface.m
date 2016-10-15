function [langue,posfigure,Xtotale,Ytotale ]  = derinterface (Asanszeros,Bnouvauxsanszeros,Bancien,fichier,feuilles,langue,val1,val2,eta,Young,Bdecalee)
    
% cette function sert a creer l'interface pour qu'on puisse montrer la
% curbe de H(a/R)
% J'ai fourni ici Bancien pour que , si l'utilisateur veut enregistrer ces
% valeurs sur excel, on puisse aussi fournir la matrice avec les valeurs
% non decalées. Comme dit dans le Rapport, on n'a pas eu le temps de creer
% cette fonctionalité ( enregistrer les donées sur fomat excel)

% le fichier et feuille sont celles utilisées pour l'echantillon, donc
% Biolox et Young est le Young du materiaux echantillon, donc, par ex, de
% la Biolox.

% Xtotale et Ytotale sont, respectivement, les cellues avec le H et le a/R.



titre =  languederinterface( langue );

% la même chose que pour posFichierCalibration dans Objet Graphique
posfichier = 1;
posfeuille = 1;
[taillefichier,~] = size(fichier);

% les abscisses X A/R
% On peut ici inicializer avec une taille précis car on la connais.
Xtotale = cell(taillefichier,1);

% les abscisses Y P/(pi*A^2)
Ytotale = cell(taillefichier,1);




fig9 = figure('numbertitle','off','name','IntGraphique');
set(fig9, 'Units','Normalized','position', [0.1, 0.1, 0.8, 0.8])
set(gcf,'Color','white')

% explcication de qu'est que l'interface va faire

text1 = uicontrol(fig9,'style','text','Units','Normalized',...
'position',[0.35,0.77,0.3,0.2],'string',...
 titre{1},...
'fontsize',15,'BackGroundcolor','white');

% Buttons de langue

bpUk= uicontrol('parent',fig9,'style','push','Units','Normalized',...
'position',[0.9,0.95,0.05,0.05],'string',...
'Uk','Callback',@foncbpuk); %#ok<NASGU>

bpFr= uicontrol('parent',fig9,'style','push','Units','Normalized',...
'position',[0.95,0.95,0.05,0.05],'string',...
'Fr','Callback',@foncbpfr); %#ok<NASGU>

% il serait utilisé pour ouvrir le tutorielle
    
bphelp= uicontrol('parent',fig9,'style','push','Units','Normalized',...
'position',[0,0.95,0.05,0.05],'string',...
titre{12},'Callback',@fonchelp);

% revenir arriére

bpPrecedent= uicontrol('parent',fig9,'style','push','Units','Normalized',...
'position',[0.9,0.05,0.07,0.06],'string',...
titre{2},'Callback',@foncrevernir);


% On va afficher le module de Young retrouve, la moyenne retrouvé;

infoyoung = strcat(titre{7},Young{posfichier});
textyoug = uicontrol(fig9,'style','text','Units','Normalized',...
'position',[0.70,0.40,0.25,0.06],'string',...
 infoyoung,...
'fontsize',12,'BackGroundcolor','white');


%  Pour enregistrer la courbe

bpEnreg= uicontrol('parent',fig9,'style','push','Units','Normalized',...
'position',[0.1,0.05,0.12,0.06],'string',...
titre{5},'Callback',@foncenregister);

% Panel où je vais mettre la plot

panelplot = uipanel('Parent',fig9,'FontSize',12,...             
                    'BackgroundColor', 'white',...
                    'Units','Normalized',...
                    'Position', [0.050137055837563 0.153019538188277 0.61030456852792 0.593250444049736]);

             
% on va initialiser et tracer la premiére plot

C=Asanszeros{posfichier}{posfeuille};
D=Bnouvauxsanszeros{posfichier}{posfeuille};  
E = Bdecalee{posfichier}{posfeuille};
h=subplot(1,1,1,'Parent',panelplot);
cla;

% On va ici rajouter le premier valeur des courbes
% On doit creer un intermediaire Xfeuille et Yfeuille car 
% Xtotale et Ytotale ont des cellules dans ses positions, ex :
% Xtotale{posfichier} est une cellule. Ces cellules auront les donées liées
% aux feuilles qui sont dans le fichier correspondent à la position
% posfichier de Xtotale.
Xfeuille = Xtotale{posfichier};
Yfeuille = Ytotale{posfichier};

% fonction pour tracer la plot
[Y,X] =  tracerplotH(C,D,titre,val1,val2,eta,E);

% je associe le valeur aux X/Yfeuille
            
Xfeuille{posfeuille} = X;
Yfeuille{posfeuille} = Y;

% Je actualize les donées dans moduleYoung

Xtotale{posfichier} =  Xfeuille;
Ytotale{posfichier} = Yfeuille;

% liste deroulent pour les fichier, feuilles.

listboxfichier = uicontrol('parent',fig9,'Style','listbox','String',fichier,...
                                'Units','Normalized','Position',[0.706009074410163 0.550849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfichier);         %#ok<NASGU>

listboxfeuille = uicontrol('parent',fig9,'Style','listbox','String',feuilles{posfichier},...
                                'Units','Normalized','Position',[0.856009074410163 0.550849056603774 0.125753176043567 0.077358490566038],...
                                'callback',@foncfeuille);    

                            
                            
    %--------------------------------------------------------------------------------
    
    function foncenregister( ~, ~)
        %cette fonction permet d'enregistrer au format voulu le graphique de la
        %page

        % les format pour lequelle on peut l'enregistrer
        FilterSpec = { '*.bmp';'*.jpg';'*.tif';'*.png'};

        % pour savoir comment et où il veut enregistrer
        [FileName,PathName,FilterIndex] = uiputfile(FilterSpec,'Save As');

        pathetname = strcat(PathName,'/',FileName);

        % si FilterIndex = 0 il va avoir fermé la fenetre
        if FilterIndex~= 0
            % pour que les unitées soient en Pixel et pas normalizées
            set(h,'Units','Pixel');
            p= get(h,'Position'); % il faut qu'ils soient en Pixel pour que sa marche

            % on va choisir un rectangle qui appartiennt au panel h . Les
            % contenues de ce rectangle seront transformées en une image, celle
            % que sera enregistré.
            rect = [(1-0.55*p(1)) (1-0.85*p(2)) 1.2*p(3) 1.2*p(4)];

            % Sert a transformer les contenus du rectangle dans une image
            F = getframe(h,rect);

            % monter l'image selectioné
            figure
            imshow(F.cdata);
            FilterSpec2 = { 'bmp';'jpg';'tif';'png'};

            % On va enregistrer l'image
            imwrite(F.cdata,pathetname, FilterSpec2{FilterIndex});

            % il faut qu'on "reset" les unitées au format Normalized
            set(h,'Units','Normalized');

            mesage = strcat(FileName,'  ',titre{8});
            warndlg (mesage);
        end
   
    end
    
     %--------------------------------------------------------------------------------
    
    function foncbpuk(~,~)
        langue = 2;
        titre =  languederinterface( langue );
        set(text1,'String',titre{1});
        set(bpPrecedent,'String',titre{2});
        set(bpEnreg,'String',titre{5});
        
        infoyoung = strcat(titre{7},Young{posfichier});
        
        set(textyoug,'String',infoyoung);
        set(bphelp,'String',titre{12});
        
    end

    %--------------------------------------------------------------------------------

    function foncbpfr(~,~)
        langue = 1;
        titre =  languederinterface( langue );
        
        set(text1,'String',titre{1});
        set(bpPrecedent,'String',titre{2});
        set(bpEnreg,'String',titre{5});
        
        infoyoung = strcat(titre{7},Young{posfichier});
        
        set(textyoug,'String',infoyoung);
        set(bphelp,'String',titre{12});
        
    end
    
    %--------------------------------------------------------------------------------

    function foncfichier (hObject, ~, ~)
    % Fonction pour recuperer quelle fichier on est en train d'utiliser
        
        posfichier = get(hObject,'value');
        set(listboxfeuille,'String',feuilles{posfichier});
        infoyoung = strcat(titre{7},Young{posfichier});
        set(textyoug,'String',infoyoung);
        
    end
    
    %--------------------------------------------------------------------------------

    function foncfeuille (hObject, ~, ~)
    %Cette fonction va reinitialiser la plot en prennent compte de la
    % feuille choisi par l'utilisateur

        posfeuille = get(hObject,'value');
        
        h=subplot(1, 1, 1, 'Parent', panelplot);
        cla;
        C=Asanszeros{posfichier}{posfeuille};
        D=Bnouvauxsanszeros{posfichier}{posfeuille};     
        E = Bdecalee{posfichier}{posfeuille};
        
        % On va ici rajouter le  valeur des courbes
        Xfeuille = Xtotale{posfichier};
        Yfeuille = Ytotale{posfichier};

        [Y,X] =  tracerplotH(C,D,titre,val1,val2,eta,E);

        % je associe le valeur aux X/Yfeuille
            
        Xfeuille{posfeuille} = X;
        Yfeuille{posfeuille} = Y;

        % Je actualize les donées dans moduleYoung

        Xtotale{posfichier} =  Xfeuille;
        Ytotale{posfichier} = Yfeuille;
        
    end

    %--------------------------------------------------------------------------------

    function foncrevernir(~,~)
    % cette function va faire la fenetre revenir arriére
        uiresume(fig9);
        posfigure = 2;
        close(fig9);
        
    end

    %--------------------------------------------------------------------------------

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
uiwait(fig9);

end

%--------------------------------------------------------------------------------------

function [Y,X] =  tracerplotH(A,Bnouvaux,titre,val1,val2,eta,Bdecalee)
% cette fonction va tracer le coube voulu
% elle va renvoyer les valeurs de Y et de X pour qu'on puisse les
% enregistrer aprées
% On va recalculer ici les R 
% On va utiliser ici les valeurs qui ont éte decalées pour la raideur

% On vas retrouver ici le valeur de hc pour tous les valeurs utilisées, on
% veut Hc en metres
% On ne s'interesse pas ici aux valeurs  = 0;

[tailleA,~] = size(A); % qui a la meme taille que B
Hc = zeros(tailleA,1);
Re = zeros(tailleA,1);

% les abscisses X A/R
X = zeros(tailleA,1);

% les abscisses Y P/(pi*A^2)
Y = zeros(tailleA,1);

% on initialize ce B pour qu'on aye une matrice X et Y avec seuelment les
% valeurs differentes de 0, car les 0 on s'en fou.
posXY=1;


for k = 1:(tailleA)
    
    % Si un valeur de la quatriéme colonne de B est different de zero, il y
    % aurra pas de 0 dans cette colonne. On a déja enleve les zeros, mais
    % pour être sure
    
    if A(k,1) ~= 0 && Bnouvaux(k,4) ~=0 && Bdecalee(k,1) ~=0
        
        Hc(posXY,1)=((Bnouvaux(k,1)*(10^-9))-(eta.*((Bnouvaux(k,2)*(10^-3))./Bdecalee(k,1))));
        
        % on a déja fait la selection des H qui respectant la régle de
        % hc > 300nm
        % on recalcule les R avec la correcton
        Re(posXY,1)=val1*(Hc(posXY,1)^val2)*(10^-6);
        
        % on calcule les valeurs de l'abscisse X
        X(posXY,1) = A(k,1)/Re(posXY,1);
        
        % On calcule les valeurs de l'abscisse Y
        Y(posXY,1) = (Bnouvaux(k,2)*(10^-3))/(pi()*(A(k,1)^2));
        posXY=posXY+1;
    end
    
end

% pour qu'on s'interesse seulement aux valeurs non nulles
% retrouver le dernier valeur non nulle
%pospremierval =find(X,1,'last');
% on peut utiliser directement posXY à la place de cette expression car le
% valeur max de posXY sera la dernier position où on a mis un valeur 

% on va faire de sort que les valeurs nulles soient enleves, si'il en reste

% % poszero=find(A(pospremierval:(tailleA),1)==0);
% % 
% % b=0;
% % for j=1:size(poszero)
% %     X(poszero(j)-b+pospremierval-1,:) = [];  
% %     Y(poszero(j)-b+pospremierval-1,:) = []; 
% %     b=b+1;
% % end

hold on
plot(X(1:posXY,1),Y(1:posXY,1),'.r', 'LineWidth',2,'MarkerSize',10);
xlabel(titre{9});
ylabel(titre{10});
title(titre{11});

hold off





end