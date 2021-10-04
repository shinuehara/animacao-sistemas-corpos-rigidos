clear
clc

diretorio = pwd()

exec(diretorio + '\exemplos\simulacao_piao.sce', -1);
exec(diretorio + '\Modularizacao.sce', -1);

// object spec
Radius = 0.1;
Height = 1;
h = 0.7*Height
SideCount = 4;

t = linspace(t0,tf,nt)'
position = [0*t, 0*t, 0*t];   // Position data
angles = [0*t, 0*t, 0*t]; // Orie   ntation data (XYZ Euler angles)

angles(:,1) = res_phi(1,:)
angles(:,2) = res_theta(1,:)
angles(:,3) = res_psi(1,:)

vertices_0 = zeros(SideCount+2, 3);
for i = 1:SideCount
    theta = 2*%pi/SideCount*(i-1);
    vertices_0(i,:) = [Radius*cos(theta), Radius*sin(theta), h];
end

//top and bottom
vertices_0(SideCount+1,:)=[0,0,0]
vertices_0(SideCount+2,:)=[0,0,Height]

// Side faces
sideFaces = zeros(2*SideCount, 3);
for i = 1:(SideCount-1)
    sideFaces(i,:) = [i, i+1, SideCount+1];
    sideFaces(SideCount+i,:) = [i, i+1, SideCount+2];
end
sideFaces(SideCount,:) = [SideCount, 1, SideCount+1];
sideFaces(2*SideCount,:) = [SideCount, 1, SideCount+2];

resposta1 = gera_corpo(vertices_0, sideFaces, position, angles,funcao_rotacao = eulerZx1z2)

h_fig = figure;
h_fig.background = 8;
drawlater();
color_index = 4
data_bounds = [-Height, -Height, -Height; Height, Height, Height]

//lista de corpos
patches = []
patches(:,1) = resposta1.patches

exibe_animacao(h_fig,patches, [37, 63], data_bounds)




