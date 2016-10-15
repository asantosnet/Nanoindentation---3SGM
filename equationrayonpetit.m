function [polynome,pas] = equationrayonpetit( Smachine,Effective,B,n,intervalle,posdernierrayonpetite)

% Cette fonction va retrouver une equation qui va d�crire le comportement
% du rayon de contact pour des faibles valeurs
% Comme on ne peut pas, sans avoir vu la curbe, la loi qu'elle peut �tre
% suivre dans tous les points, m�me porqoui elle a un comportament tr�s
% variable, donc m�me si on voit la courbe, il serait difficile de trouver
% une bonne fucntion pour la representer. Ici on va diviser les points dans
% certains groupes et les connecter par des droites, comme on fait pour une
% Integrale par example. Je pense qui on peut essayer de retrouver une loi
% pour cette courbe, mais , je vais essayer comme j'ai parl� avant, en
% retrouvent plusieurs droites pour d�crire le comportement dans un petit
% point de la courbe. Donc , par example, pour un penetration de hc qui
% appartient a un certain intervalle, on aurra un fonction lineaire qui
% lui est associ�, on peut aussi prendre un intervalle qui a les points 
% hmax/ n

% Le B est la matrice de calibration , donc de la Silice pour notre
% example.


% je pense que je peut envoyer le Smat corrig� directiement e ne pas avoir
% de lui calculer une autre fois, mais �a demanderait que je enregistre le
% valeur qui on �te calcules pour tracer les droites dans la  fenetre 3, pour
% manque de temps je n'a pas le fait

% Smachine est la constante li�e � la machine , Effective est le E dans la
% formule, Smat = 2*E*a donc on peut d�duir que a = Smat/(2*E);

% posdernierrayonpetite est la pos ou on commence a respecter hc>300nm


% on va l'appliquer pour seulement une echantillon, on peut apr�s appeler
% ce methode pour les differents �chantillons existantes

%%%%%%% Si j'ai le temps, je doit le tester

% donc s'il ne nous informe pas d'un intervalle pr�cis, mais d'une
% "percentage"

% on a que A est la matrice que vient de Smat = 2*Eff*a , donc si
% on connais Smat on va dire que a=Smat / (2*Eff)

Smatcorrige= (Smachine.*B(1:posdernierrayonpetite,4))/(Smachine-B(1:posdernierrayonpetite,4)); 

A = Smatcorrige./(2*Effective);

if intervalle==0
    % taille de l'intervale
    polynome = zeros(n,3);
    % pas dans lequelle on va separer les points pour tracer la droite
    % le B est notre x, car on s"interesse  a la curbe de R en fonction de
    % H et le A, qui est le rayon de contact, sera le y.
    pas = B((posdernierrayonpetite-1),1)/n;
    minval = 0;
    maxval = pas;
    
    for k=1:n
        % la position du premier val apr�s le minval et on si'nterrese de
        % l'invervale 1:(posdernierrayonpetite-1)
        posmin = find(B(1:(posdernierrayonpetite-1),1)>minval,'first');
        % la position du premier val apr�s le maxval
        posmax = find(B(1:(posdernierrayonpetite-1),1)<maxval,'first');
        
        
        % on va prendre les valeurs de a pour cette intervale
        % on va retrouver la fonction lineraie en utilisant p�olyfit pour
        % l'intervalle selection�
        pol = polyfit(B(posmin:posmax,1),A(posmin:posmax,1),1);
        % on enregistre la pente
        polynome(k,1) = pol(1);
        % on enregistre la constante 
        polynome(k,2) = pol(2);
        % on rajoute le "premier point de la droite"
        polynome(k,3) = B(posmin,1);
        
        minval = maxval;
        maxval = maxval + pas;

    end
elseif intervalle ~=0
    minval = 0;
    maxval = intervalle;
    pas = intervalle;
    % n peut etre non entier
    n = B((posdernierrayonpetite-1),1)/intervalle;
    
    % on le 'transforme en entier'
    nentier = round(n);
    
    % on veut que , si on a 2.3 par example , on aie 3
    % ceci est car, m�me si on prende un valeur plus grande, il n'y aurra
    % pas de valeur que ne seront pas associ�e � une droite, ce qui n'est
    % pas le cas si on prende un valeur plus petit, 2 par example
    
    if nentier<n
        nentier = nentier +1;
    end
    
    polynome = zeros(nentier,2);
    
    for k=1:nentier
        % la position du premier val apr�s le minval
        posmin = find(B(:,1)>minval,'first');
        % la position du premier val apr�s le maxval
        posmax = find(B(:,1)<maxval,'first');
        
        % on va prendre les valeurs de a pour cette intervale
        % on va retrouver la fonction lineraie en utilisant p�olyfit pour
        % l'intervalle selection�
        pol = polyfit(B(posmin:posmax,1),A(posmin:posmax,1),1);
        polynome(k,1) = pol(1);
        polynome(k,2) = pol(2);
        minval = maxval;
        maxval = maxval + pas;

    end
    
end

end

