%----------------------------
%     Árvore Genealógica
% ---------------------------
% Maria Eduarda Fabiano Pires
% R.A.: 2020.1.08.019
%----------------------------

%Progenitores
pai("Carlos Eduardo", "Victor Hugo").
pai("Carlos Eduardo", "Maria Eduarda").
pai("Carlos Eduardo", murilo).
pai("Emílio", gabriel).
pai("Emílio", "Vinícius").
pai("João Batista", daniela).
pai("João Batista", "Márcia").
pai(hugo, "Carlos Eduardo").
pai(hugo, rodrigo).
pai(rodrigo, felipe).
pai(beto, carol).
pai(beto, lucas).
pai("Antônio", hugo).
pai(bento, didi).
pai(luiz, dirce).

mae(daniela, "Maria Eduarda").
mae(daniela, "Victor Hugo").
mae(daniela, gabriel).
mae(daniela, "Vinícius").
mae(elessandra, murilo).
mae("Márcia", carol).
mae("Márcia", lucas).
mae(dirce, daniela).
mae(dirce, "Márcia").
mae(didi, "Carlos Eduardo").
mae(didi, rodrigo).
mae(selene, felipe).
mae("Maria Mendonça", dirce).
mae(luzia, didi).
mae("Maria José", hugo).

sexo("Maria José", feminino).
sexo(luzia, feminino).
sexo(didi, feminino).
sexo(selene, feminino).
sexo(daniela, feminino).
sexo("Maria Mendonça", feminino).
sexo(dirce, feminino).
sexo("Márcia", feminino).
sexo(carol, feminino).
sexo("Maria Eduarda", feminino).
sexo(elessandra, feminino).

sexo("Vinícius", masculino).
sexo(gabriel, masculino).
sexo("Victor Hugo", masculino).
sexo(murilo, masculino).
sexo("Emílio", masculino).
sexo(lucas, masculino).
sexo(felipe, masculino).
sexo("Carlos Eduardo", masculino).
sexo(beto, masculino).
sexo(rodrigo, masculino).
sexo("João Batista", masculino).
sexo(hugo, masculino).
sexo(luiz, masculino).
sexo(bento, masculino).
sexo("Antônio", masculino).

tem_filho(X) :- pai(X,_).
tem_filho(X) :- pai(X,_).

%avôs
avo_paterno(X,Y) :- pai(X,Z), pai(Z,Y).
avo_materno(X,Y) :- pai(X,Z), mae(Z,Y).

%avós
avo_paterna(X,Y) :- mae(X,Z), pai(Z,Y).
avo_materna(X,Y) :- mae(X,Z), mae(Z,Y).

%bisavôs
bisavo_paterno(W,Z)  :- pai(W,X), pai(X,Y), pai(Y,Z).
bisavo_paterno(W,Z)  :- pai(W,X), mae(X,Y), pai(Y,Z).
bisavo_materno(W,Z)  :- pai(W,X), mae(X,Y), mae(Y,Z).
bisavo_materno(W,Z)  :- pai(W,X), pai(X,Y), mae(Y,Z).

%bisavós
bisavo_paterna(W,Z)  :- mae(W,X), pai(X,Y), pai(Y,Z).
bisavo_paterna(W,Z)  :- mae(W,X), mae(X,Y), pai(Y,Z).
bisavo_materna(W,Z)  :- mae(W,X), mae(X,Y), mae(Y,Z).
bisavo_materna(W,Z)  :- mae(W,X), pai(X,Y), mae(Y,Z).

%antecessores
antecessor(X,Y) :- pai(X,Y).
antecessor(X,Y) :- mae(X,Y).
antecessor(X,Y) :- pai(X,Z), antecessor(Z,Y).
antecessor(X,Y) :- mae(X,Z), antecessor(Z,Y).

%identificação dos irmãos
irma(X,Y) :- pai(W,X), pai(Z,Y), mae(A,X), mae(B,Y), W=Z, A=B, sexo(X, feminino).
irmao(X,Y) :- pai(W,X), pai(Z,Y), mae(A,X), mae(B,Y), W=Z, A=B, sexo(X, masculino).

%identificação dos meio-irmãos
meiairma(X,Y) :- pai(W,X), pai(Z,Y), mae(A,X), mae(B,Y), W=Z, A\=B, sexo(X, feminino).
meiairma(X,Y) :- mae(W,X), mae(Z,Y), pai(A,X), pai(B,Y), W=Z, A\=B, sexo(X, feminino).
meioirmao(X,Y) :- pai(W,X), pai(Z,Y), mae(A,X), mae(B,Y), W=Z, A\=B, sexo(X, masculino).
meioirmao(X,Y) :- mae(W,X), mae(Z,Y), pai(A,X), pai(B,Y), W=Z, A\=B, sexo(X, masculino).

%identificação dos tios (foi considerado apenas tios sanguíneos)
tio(X, Y) :- irmao(X,Z), pai(Z,Y), X\=Z, sexo(X,masculino);
			 irmao(X,Z), mae(Z,Y), X\=Z, sexo(X,masculino).
tia(X, Y) :- irma(X,Z), mae(Z,Y), X\=Z, sexo(X, feminino);
    		 irma(X,Z), pai(Z,Y), X\=Z, sexo(X, feminino).

%identificação dos primos
prima(X,Y) :- tio(W,Y), pai(W,X), sexo(X, feminino); 
    		  tio(W,Y), mae(W,X), sexo(X, feminino);
			  tia(W,Y), pai(W,X), sexo(X, feminino);
    		  tia(W,Y), mae(W,X), sexo(X, feminino).
primo(X,Y) :- tio(W,Y), pai(W,X), sexo(X, masculino); 
    		  tio(W,Y), mae(W,X), sexo(X, masculino);
			  tia(W,Y), pai(W,X), sexo(X, masculino);
    		  tia(W,Y), mae(W,X), sexo(X, masculino).
