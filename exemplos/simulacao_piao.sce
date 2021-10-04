//SCRIPT PARA A REALIZAÇÃO DOS CÁLCULOS DO MODELO
//constantes        -> define principais variáveis
//simulacao_v0      -> faz a simulação para determinadas condições iniciais
//Nutacao           -> faz o calculo da faixa de ângulos Theta
//trajetoria_C      -> faz a nova simulação com o novo Theta0
//anima_piao        -> recebe os deslocamentos angulares em função do tempo e realiza a animação do movimento

//xdel(winsid());


// Definição dos parâmetros e propriedades
l   = 1                   //m - comprimento da haste
r   = 0.1                 //m - raio do disco
e   = 0.01                //m - espessura do disco
g   = 9.8                 //m/s^2 - aceleração da gravidade
rho = 7850              //kg/m^3 - densidade do disco
V   = %pi*e*r^2         //volume
m   = rho*V
zero = 10^(-9)
A   = (m*r^2)/4 + m*l^2     //kg.m^2 - Momento de inércia Jox e Joy
C   = (m*r^2/2)             //kg.m^2 - Momento de inércia Joz
a = 2*m*g*l/A
b = C/A

// Construção do vetor tempo
t0=0
tf=10
frames_por_segundo = 30
nt=frames_por_segundo*tf
t   = linspace(t0,tf,nt)'

phi0        = zero + 0*%pi/180
theta0      = zero + 60*%pi/180
psi0        = zero + 0*%pi/180
dphi0       = zero + 120*%pi/180
dtheta0     = zero + 0*%pi/180
dpsi0       = zero + 800*%pi/180
y0 = [phi0;dphi0;theta0;dtheta0;psi0;dpsi0]
//simulação do movimento do giroscópio
//condições iniciais

function dy = piao(t,y)
    dy(1) = y(2)
    dy(2) = ((C-2*A)/A)*cotg(y(3))*y(2)*y(4) + (C/A)*(1/sin(y(3)))*y(4)*y(6)
    dy(3) = y(4)
    dy(4) = ((A-C)/A)*sin(y(3))*cos(y(3))*y(2)^2 - (C/A)*sin(y(3))*y(2)*y(6) + (m*g*l/A)*sin(y(3))
    dy(5) = y(6)
    dy(6) = sin(y(3))*y(2)*y(4) - cos(y(3))*(((C-2*A)/A)*cotg(y(3))*y(2)*y(4) + (C/A)*(1/sin(y(3)))*y(4)*y(6))
endfunction

y = ode(y0,0,t,piao)

res_phi     = y(1,:)
res_dphi    = y(2,:)
res_theta   = y(3,:)
res_dtheta  = y(4,:)
res_psi     = y(5,:)
res_dpsi    = y(6,:)
