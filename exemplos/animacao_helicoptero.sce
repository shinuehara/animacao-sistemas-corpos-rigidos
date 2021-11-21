clear
clc

diretorio = pwd()
exec(diretorio + '\eulerZx1z2.sci', -1);
exec(diretorio + '\Modularizacao.sce', -1);

a = 1 //cm
b = 0.1 //cm
L = 5 //cm


// corpo
vertices_corpo = [
    L, b/2, -a/2;
    L, b/2, a/2;
    L/2, b/2, 4*a;
    0, b/2, 4*a;
    0, b/2, a/2;
    -L, b/2, a/2;
    -L, b/2, -a/2;
    L , -b/2, -a/2;
    L, -b/2, a/2;
    L/2, -b/2, 4*a;
    0, -b/2, 4*a;
    0, -b/2, a/2;
    -L, -b/2, a/2;
    -L, -b/2, -a/2;
    ]

faces_corpo = [
    1,2,3,4,5,6,7;
    8,9,10,11,12,13,14
    ]

faces_laterais_corpo = [
    1,2,9,8;
    2,3,10,9;
    3,4,11,10;
    4,5,12,11;
    5,6,13,12;
    6,7,14,13;
    7,1,8,14;
    ]

// helice
vertices_helice = [
    b/2, b/2, 0;
    b/2, b/2, a;
    L, b/2, a;
    L, b/2, a+b;
    -L, b/2, a+b;
    -L, b/2, a;
    -b/2, b/2, a;
    -b/2, b/2, 0;
    b/2, -b/2, 0;
    b/2, -b/2, a;
    L, -b/2, a;
    L, -b/2, a+b;
    -L, -b/2, a+b;
    -L, -b/2, a;
    -b/2, -b/2, a;
    -b/2, -b/2, 0;
    ]


// helice2
vertices_helice2 = [
    b/2, b/2, 0;
    b/2, b/2, a/2;
    L/4, b/2, a/2;
    L/4, b/2, a/2+b;
    -L/4, b/2, a/2+b;
    -L/4, b/2, a/2;
    -b/2, b/2, a/2;
    -b/2, b/2, 0;
    b/2, -b/2, 0;
    b/2, -b/2, a/2;
    L/4, -b/2, a/2;
    L/4, -b/2, a/2+b;
    -L/4, -b/2, a/2+b;
    -L/4, -b/2, a/2;
    -b/2, -b/2, a/2;
    -b/2, -b/2, 0;
    ]

faces_helice = [
    1,2,3,4,5,6,7,8;
    9,10,11,12,13,14,15,16;
    ]

faces_laterias_helice = [
    1,2,10,9;
    2,3,11,10;
    3,4,12,11;
    4,5,13,12;
    5,6,14,13;
    6,7,15,14;
    7,8,16,15;
    8,1,9,16;
    ]

// Construção do vetor tempo
t0=0
tf=2
frames_por_segundo = 30
dt = 0.005
//nt=frames_por_segundo*tf
//t   = linspace(t0,tf,nt)'
t = (t0:dt:tf)'
// helicoptero
position_helicoptero = [0*t, 0*t, 0*t];   // Position data
angles_helicoptero = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_helicoptero(:,2) = 15*%pi/180*sin(2*t)
angles_helicoptero(:,1) = 30*%pi/180*sin(t)
//angles_helicoptero(:,3) = zeros(res_phi(1,:))

angles_helice = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_helice(:,2) = 15*%pi/180*sin(2*t)
angles_helice(:,1) = 30*%pi/180*sin(t)
angles_helice(:,3) = 20*t

angles_helice2 = [0*t, 0*t, 0*t]; // Orientation data (Zx1z2 Euler angles)
angles_helice2(:,2) = 15*%pi/180*sin(2*t)-%pi/2
angles_helice2(:,1) = 30*%pi/180*sin(t)
angles_helice2(:,3) = 20*t

ponto1.x = L/4
ponto1.y = 0
ponto1.z = 4*a
ponto2.x = -(L-a)
ponto2.y = 0
ponto2.z = 0

// frames do helicoptero
resposta_helicoptero = gera_corpo(vertices_corpo, faces_corpo, position_helicoptero, angles_helicoptero,[ponto1, ponto2],funcao_rotacao = eulerZx1z2)
position_helice = [resposta_helicoptero.pontos(1).x,resposta_helicoptero.pontos(1).y,resposta_helicoptero.pontos(1).z]
position_helice2 = [resposta_helicoptero.pontos(2).x,resposta_helicoptero.pontos(2).y,resposta_helicoptero.pontos(2).z]
resposta_helice = gera_corpo(vertices_helice, faces_helice, position_helice, angles_helice,funcao_rotacao = eulerZx1z2)
resposta_helice2 = gera_corpo(vertices_helice2, faces_helice, position_helice2, angles_helice2,funcao_rotacao = eulerZx1z2)

// lista de corpos
patches = []
patches(:,1) = resposta_helicoptero.patches
patches(:,2) = resposta_helice.patches
patches(:,3) = resposta_helice2.patches

h_fig = figure;
h_fig.background = 8;
drawlater();
color_index = 4 
data_bounds = [-L, -L, -2*a; L L, 7*a]
exibe_animacao(h_fig, patches, [45, 67],data_bounds)
//exibe_animacao(h_fig, patches, [45, 67])




