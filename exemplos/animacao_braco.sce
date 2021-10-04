clear
clc

diretorio = pwd()
exec(diretorio + '\eulerZx1z2.sci', -1);
exec(diretorio + '\Modularizacao.sce', -1);

a = 1 //cm
b = 0.1 //cm
L = 5 //cm

//base
vertices_base = [
    L/2, -L/2, -a/2-b;
    L/2, L/2, -a/2-b;
    -L/2, L/2, -a/2-b;
    -L/2, -L/2, -a/2-b;
    L/2, -L/2, -a/2;
    L/2, L/2, -a/2;
    -L/2, L/2, -a/2;
    -L/2, -L/2, -a/2;
    a/2, -a/2, -a/2;
    a/2, a/2, -a/2;
    -a/2, a/2, -a/2;
    -a/2, -a/2, -a/2;
    a/2, -a/2, a/2;
    a/2, a/2, a/2;
    -a/2, a/2, a/2;
    -a/2, -a/2, a/2;
    ]

faces_base = [
    1,2,3,4;
    5,6,7,8;
    1,2,6,5;
    2,3,7,6;
    3,4,8,7;
    4,1,5,8;
    9,10,11,12;
    13,14,15,16;
    9,10,14,13;
    10,11,15,14;
    11,12,16,15;
    12,9,13,16;
    ]

// braco
vertices_braco = [
    0, -a/2, -a/2;
    0, a/2, -a/2;
    b, a/2, -a/2;
    b, -a/2, -a/2;
    0, -a/2, L-a/2;
    0, a/2, L-a/2;
    b, a/2, L-a/2;
    b, -a/2, L-a/2;
    ]

faces_braco = [
    1,2,3,4;
    5,6,7,8;
    1,2,6,5;
    2,3,7,6;
    3,4,8,7;
    4,1,5,8;
    ]

// Construção do vetor tempo
t0=0
tf=20
frames_por_segundo = 30
nt=frames_por_segundo*tf
t   = linspace(t0,tf,nt)'

// base
position_base = [0*t, 0*t, 0*t];   // Position data
angles_base = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_base(:,1) = [linspace(0,%pi/3,length(t)/3)'; ones(length(t)*2/3,1)*%pi/3]

// braco1
angles_braco1 = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_braco1(:,1) = [linspace(0,%pi/3,length(t)/3)'; ones(length(t)*2/3,1)*%pi/3] // acompanha base
angles_braco1(:,2) = [ones(length(t)/3,1)*(-%pi/3); linspace(-%pi/3,%pi/6,length(t)/3)';ones(length(t)/3,1)*%pi/6]

// braco2
angles_braco2 = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_braco2(:,1) = [linspace(0,%pi/3,length(t)/3)'; ones(length(t)*2/3,1)*%pi/3] // acompanha base
angles_braco2(:,2) = 0*t + %pi/2

// braco3
rel_pos_braco3 = [0*t, 0*t,0*t]; //(L)*(t/2)/tf
rel_pos_braco3(:,3) = [ones(length(t)*2/3,1)*(-L/2); linspace(-L/2,0,length(t)/3)'];
angles_braco3 = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_braco3(:,1) = [linspace(0,%pi/3,length(t)/3)'; ones(length(t)*2/3,1)*%pi/3] // acompanha base
angles_braco3(:,2) = 0*t + %pi/2

ponto1.x = 0
ponto1.y = 0
ponto1.z = 0
ponto2.x = 0
ponto2.y = b
ponto2.z = L-a

// frames do base
resposta_base = gera_corpo(vertices_base, faces_base, position_base, angles_base,[ponto1],funcao_rotacao = eulerZx1z2)
position_braco1 = [resposta_base.pontos(1).x,resposta_base.pontos(1).y,resposta_base.pontos(1).z]
resposta_braco1 = gera_corpo(vertices_braco, faces_braco, position_braco1, angles_braco1,[ponto2],funcao_rotacao = eulerZx1z2)
position_braco2 = [resposta_braco1.pontos(1).x,resposta_braco1.pontos(1).y,resposta_braco1.pontos(1).z]
resposta_braco2 = gera_corpo(vertices_braco, faces_braco, position_braco2, angles_braco2,[ponto2],funcao_rotacao = eulerZx1z2)
position_braco3 = [resposta_braco2.pontos(1).x,resposta_braco2.pontos(1).y,resposta_braco2.pontos(1).z]
resposta_braco3 = gera_corpo(vertices_braco, faces_braco, position_braco3, angles_braco2,[ponto2],funcao_rotacao = eulerZx1z2,rel_pos_braco3)

//lista de corpos
patches = []
patches(:,1) = resposta_base.patches
patches(:,2) = resposta_braco1.patches
patches(:,3) = resposta_braco2.patches
patches(:,4) = resposta_braco3.patches

//inicializando tela
h_fig = figure;
h_fig.background = 8;
drawlater();
color_index = 4
data_bounds = [-1.5*L,-1.5*L,-1.5*L; 1.5*L, 1.5*L, 1.5*L]


exibe_animacao(h_fig, patches, [60, 67],data_bounds)


