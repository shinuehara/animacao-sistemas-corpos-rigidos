clear
clc

diretorio = pwd()
exec(diretorio + '\exemplos\simulacao_pendulo_duplo.sce', -1);
exec(diretorio + '\eulerZx1z2.sci', -1);
exec(diretorio + '\Modularizacao.sce', -1);

l_haste = -1
r_bloco = 0.1
SideCount = 4
r_haste = r_bloco/5

// Vertices
vertices_0 = zeros(SideCount*4, 3);
for i = 1:SideCount
    theta = 2*%pi/SideCount*(i-1);
    vertices_0(i,:) = [r_haste*cos(theta), r_haste*sin(theta), 0];
    vertices_0(SideCount+i,:) = [r_haste*cos(theta), r_haste*sin(theta), l_haste ];
    vertices_0(2*SideCount+i,:) = [r_bloco*cos(theta), r_bloco*sin(theta), l_haste + r_bloco];
    vertices_0(3*SideCount+i,:) = [r_bloco*cos(theta), r_bloco*sin(theta), l_haste-r_bloco];
end

// Faces
sideFaces = zeros(SideCount, 4);
for i = 1:(SideCount-1)
    sideFaces(i,:) = [i, i+1, SideCount+i+1, SideCount+i];
    sideFaces(SideCount+i,:) = [2*SideCount+i, 2*SideCount+i+1, 3*SideCount+i+1, 3*SideCount+i]
end
sideFaces(SideCount,:) = [SideCount, 1, SideCount+1, 2*SideCount];
sideFaces(2*SideCount,:) = [3*SideCount, 2*SideCount+1, 3*SideCount+1, 4*SideCount];

// Construção do vetor tempo
position1 = [0*t, 0*t, 0*t];   // Position data
angles1 = [0*t, 0*t, 0*t]; // Orie   ntation data (Zx1z2 Euler angles)
angles1(:,1) = zeros(res_phi(1,:))
angles1(:,2) = res_phi(1,:)
angles1(:,3) = zeros(res_phi(1,:))

angles2 = [0*t, 0*t, 0*t]; // Orie   ntation data (Zx1z2 Euler angles)
angles2(:,1) = zeros(res_theta(1,:))
angles2(:,2) = res_theta(1,:)
angles2(:,3) = zeros(res_theta(1,:))

ponto1.x = 0
ponto1.y = 0
ponto1.z = l_haste

resposta1 = gera_corpo(vertices_0, sideFaces, position1, angles1,[ponto1],funcao_rotacao = eulerZx1z2)
position2 = [resposta1.pontos(1).x,resposta1.pontos(1).y,resposta1.pontos(1).z]
resposta2 = gera_corpo(vertices_0, sideFaces, position2, angles2,[ponto1], funcao_rotacao = eulerZx1z2)
// exemplo de como ligar mais corpos
//position3 = [resposta2.pontos(1).x,resposta2.pontos(1).y,resposta2.pontos(1).z]
//resposta3 = gera_corpo(vertices_0, sideFaces, position3, angles2,[ponto1], funcao_rotacao = eulerZx1z2)
//position4 = [resposta3.pontos(1).x,resposta3.pontos(1).y,resposta3.pontos(1).z]
//resposta4 = gera_corpo(vertices_0, sideFaces, position4, angles2, funcao_rotacao = eulerZx1z2)

h_fig = figure;
h_fig.background = 8;
drawlater();
color_index = 4
data_bounds = [-0.1, -1, -2.4; 0.1, 1, 0]

//lista de corpos
patches = []
patches(:,1) = resposta1.patches
patches(:,2) = resposta2.patches
// exemplo de como exibir mais corpos
//patches(:,3) = resposta3.patches
//patches(:,4) = resposta4.patches
//exibe_animacao(h_fig, [resposta1.patches, resposta2.patches, resposta3.patches], [90, 0])

exibe_animacao(h_fig,patches, [90, 0], data_bounds)


