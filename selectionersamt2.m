function [langue,posfenetre] = selectionersamt2(langue, Smachine,A,B,Effective)

% Cette fonction va montrer à l'utilisateur les fonctions avec les
% corrections et va delmander si l'utilisateur est d'accord
% A et B sont des cellules chaq'un contenent encore d'autres cellules qui
% contient des matrices. A, comme toujours, rayon de contat et B la matrice
% avec tous les donées retrouvées dans l'excel,parmi eux la raideur.




fig1 = figure('numbertitle','off','name','IntGraphique');

set(fig1, 'Units','Normalized','position', [0.1, 0.1, 0.8, 0.8])

% Mettre une couleur en arrière plan
set(gcf,'Color','white')

% Initialisation des variables qui seront utilisées 

titre = langueselectionersamt2 (langue );


% Bouton sélection langue

bpUk= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.86,0.95,0.07,0.05],'string',...
    'Uk','Callback',@foncbpuk); %#ok<NASGU>

bpFr= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.93,0.95,0.07,0.05],'string',...
    'Fr ','Callback',@foncbpfr); %#ok<NASGU>

% il serait utilisé pour ouvrir le tutorielle
    
bphelp= uicontrol('parent',fig1,'style','push','Units','Normalized',...
'position',[0,0.95,0.05,0.05],'string',...
titre{11},'Callback',@fonchelp);

bpoui= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.93,0.001,0.07,0.06],'string',...
    titre{12},'Callback',@foncoui);
bpnon= uicontrol('parent',fig1,'style','push','Units','Normalized',...
    'position',[0.845,0.001,0.07,0.06],'string',...
    titre{3},'Callback',@foncnon);

% en expliquent a quoi sa sert cette fenetre
text1 = uicontrol(fig1,'style','text','Units','Normalized',...
    'position',[0.25,0.85,0.50,0.04],'string',...
    titre{1},...
    'fontsize',10,'BackGroundcolor','white'); 

% Où on va tracer les plots
panelplot = uipanel('Parent',fig1,'FontSize',12,...             
                    'BackgroundColor', 'black',...
                    'Units','Normalized',...
                    'Position', [0.10137055837563 0.153019538188277 0.80030456852792 0.603250444049736]);
                
% on va mettre un panel dans l'autre, pour qu'on puisse changer sa taille
panelplot2g = uipanel('Parent',panelplot,'FontSize',12,...             
                    'BackgroundColor', 'white',...
                    'Units','Normalized',...
                    'Position', [0 0 0.4800 1]);
panelplot2d = uipanel('Parent',panelplot,'FontSize',12,...             
                    'BackgroundColor', 'white',...
                    'Units','Normalized',...
                    'Position', [0.5 0 0.4800 1]);
              
slidepanel = uicontrol('Parent',panelplot, ...
                        'Style','slider', 'Enable','off', ...
                        'Units','Normalized', 'Position',[0.97 0 0.03 1], ...
                        'Min',0-eps, 'Max',0, 'Value',0, ...
                        'Callback',@foncslidepanel);
             
                
[x,~]= size(A);
numerodeplot = 0;

% Pour savoir combien de graph on doit utiliser. Il faut qu'on sache
% combien de curbes on doit tracer pour savoir combien des axes on est
% sense a creer.

for k=1:x
    [d,~] = size(A{k});
    numerodeplot = numerodeplot + d;
end


% on va tracer les fonctions 

% la position de la plot a gauche et a droite. On a trace, dans un même
% linge deux plots car, si on trace seulement une, la longeur reste
% trop grande par rapport à l'hateur.

% position à gauche
posplot2g = 1;

% position à droite
posplot2d = 1;

n=1;
hAx2g = zeros( numerodeplot,1);
hAx2d = zeros( numerodeplot,1);
for k=1:x
    [y,~]=size(A{k});

    for g=1:y
        
        % Pour decider dans quelle des deux panels on va les tracer( soit à
        % gauche, soit à droite)
        switch n
            case 1 
                
                [tailleA,~]=size(A{k}{g});
                pospremierval = find(A{k}{g},1,'first');
                
                % on va recalculer la matrice avec les donées Smat
                Smachinestr = num2str(Smachine);
                
                % pour recalculer la matrice avec la correction
                Smat = rechargerplot(Smachinestr,titre{2},tailleA,B{k}{g},pospremierval);
                
                % on va charger les axes en fonction de la quantité de
                % feuilles existantes, donc de plots a tracer
                hAx2g(posplot2g) = aditionerAxes(panelplot2g,panelplot,slidepanel);
                
                creerplotver(hAx2g(posplot2g),A{k}{g},B{k}{g},Effective,titre,Smat,0.3);
                posplot2g = posplot2g +1;
                n = 2;
            case 2
                % la même chose mais à droite
                [tailleA,~]=size(A{k}{g});
                pospremierval = find(A{k}{g},1,'first');
                Smachinestr = num2str(Smachine);
                Smat = rechargerplot(Smachinestr,titre{2},tailleA,B{k}{g},pospremierval);
                hAx2d(posplot2d) = aditionerAxes(panelplot2d,panelplot,slidepanel);
                creerplotver(hAx2d(posplot2d),A{k}{g},B{k}{g},Effective,titre,Smat,0.3);
                posplot2d = posplot2d +1;
                n=1;
            otherwise
                msgbox('Error-selectionersamt2');
        end
    end
end

% pour que la taille du slidepanel soit le bonne*, si on n'a pas sa la
% dernier curbe est coupé dans la motié
p = get(panelplot, 'Position');
h = p(4);
mx = get(slidepanel, 'Max');
set(slidepanel, 'Max',mx+(h/2), 'Min',0, 'Enable','on')
hgfeval(get(slidepanel,'Callback'), slidepanel, []);


    %--------------------------------------------------------------------------------------

    function foncbpuk (~,~)
        langue = 2;
        titre = langueselectionersamt2( langue );

        % Ces button von effectuer des changements dans la figure "de base"
        % du panel, donc elles doivent rester ici.     
        set(bpoui,'String',titre{12});
        set(text1,'String',titre{1});
        set(bpnon,'String',titre{3});
        set(bphelp,'String',titre{11});
        
    end
    
    %--------------------------------------------------------------------------------------

    function foncbpfr (~,~)
        langue = 1;
        titre = langueselectionersamt2( langue );
        
        set(bpoui,'String',titre{12});
        set(text1,'String',titre{1});
        set(bpnon,'String',titre{3});
        set(bphelp,'String',titre{11});

    end

    %--------------------------------------------------------------------------------------
    
    function foncoui(~,~)
    
        posfenetre = 1;    
        uiresume(fig1);
        close(fig1);
    
    end

    %--------------------------------------------------------------------------------------

    function foncnon (~,~)
        posfenetre = 0;    
        uiresume(fig1);
        close(fig1);
    end

    %--------------------------------------------------------------------------------------
        
    function foncslidepanel(~,~)
        %# slider value
        offset = get(slidepanel,'Value');

        
        set(panelplot, 'Units','pixels');
        p = get(panelplot2g, 'Position');  %# la position du panel
        set(panelplot2g, 'Position',[p(1) -offset p(3) p(4)])
        
        p = get(panelplot2d, 'Position');  %# la position du panel
        set(panelplot2d, 'Position',[p(1) -offset p(3) p(4)])
        
        
    end

    %--------------------------------------------------------------------------------------
    
    function fonchelp(~,~)
    
    % Comme on est sense a ouvri toujour la même application, le même
    % fichier pdf, on peut le faire comme ça
        switch langue
            case 1
                winopen('GuideFR.pdf');
            case 2
                winopen('GuideEN.pdf');
        end;
        
    end
uiwait(fig1);
end

%--------------------------------------------------------------------------------------

function hAxi = aditionerAxes (painelplot,panelprincipal,slidepanel)
    %# vas essayer des retrouver s'il existe d'autres axes
    axe = findobj(painelplot, 'type','axes');
    
    if isempty(axe)
        %# va creer le premier axe
        hAxi = axes('Parent',painelplot, ...
            'Units','normalized', 'Position',[0.13 0.11 0.775 0.815]);
        set(hAxi, 'Units','pixels');
    else
        %# prendre l'hauteur de la figure
        set(panelprincipal, 'Units','pixels');
        p = get(panelprincipal, 'Position');
        h = p(4);

        %# augmanter la taille du panel et modifier sa position
        set(painelplot, 'Units','pixels');
        p = get(painelplot, 'Position');
        
        set(painelplot, 'Position',[p(1) p(2)-h p(3) p(4)+h])

        %# modifier la position du nouvelle axe
        p = get(axe,'Position');
        if iscell(p)
            p = cell2mat(p);
        end
        p = [p(1,1) max(p(:,2))+h p(1,3) p(1,4)];

        %# initialiser le nouvelle axe
        hAxi = axes('Parent',painelplot, ...
            'Units','Pixel', 'Position',p);

        %# corriger le valeur de la slider et de la fonction callback
        mx = get(slidepanel, 'Max');
        set(slidepanel, 'Max',mx+(h/2), 'Min',0, 'Enable','on')
        hgfeval(get(slidepanel,'Callback'), slidepanel, []);
    end

    %# recharger l'interface
    drawnow
end

%--------------------------------------------------------------------------------------

function [curve,curvinit,curvdroite]=creerplotver(axe,A,T,Effective,titre,Smat,t)

%cette fonction permet de tracer le graph Smac en fonction de a
[tailleA,~]=size(A);
pospremierval = find(A,1,'first');


% Pour tracer la droite a*Eff passent par zero
if all(Smat == 0)
    Smateriale = T;
    d=4;
else
    Smateriale = Smat;
    d=1;
end
S=2*Effective*A(pospremierval:tailleA,1);
%On va tracer les deux curbes
hold on
curve=plot(axe,A(pospremierval:(tailleA-1),1),Smateriale(pospremierval:(tailleA-1),d),'-r','LineWidth', 2);
curvinit=plot(A(pospremierval:(tailleA-1),1),T(pospremierval:(tailleA-1),4),'-b','LineWidth', t);
xlabel(titre{8});
ylabel(titre{7});
title(titre{10});
curvdroite = plot(A(pospremierval:tailleA,1),S,'-g','LineWidth', 2);
hold off
end
