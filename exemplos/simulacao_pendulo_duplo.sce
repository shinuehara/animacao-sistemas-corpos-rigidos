
//xdel(winsid());

//simulação do movimento do giroscópio
//condições iniciais

// Definição dos parâmetros e propriedades
l1 = 1 //m
m1 = 1 //kg
l2 = 1 //m
m2 = 1 //kg
g = 9.8 // m/s^2
zero = 10^(-9)

A1 = m2/(m1+m2)
A2 = l2/l1
A3 = g/l1
A4 = g/l2

// Construção do vetor tempo
t0=0
tf=10
frames_por_segundo = 30
nt=frames_por_segundo*tf
t   = linspace(t0,tf,nt)'

// Condições arbitrárias
//cuspide
phi0        = zero + 15*%pi/180
theta0      = zero + 0*%pi/180
dphi0       = zero + 0*%pi/180
dtheta0     = zero + 0*%pi/180

y0 = [phi0;dphi0;theta0;dtheta0]
top1 = [0;0;-l1]

function dy = PenduloDuplo(t,y)
    alfa = y(1)-y(3)
    B1 = 1/(1-A1*cos(alfa)^2)
    B2 = - cos(alfa) / (A2*(1-A1*cos(alfa)^2))
    dy(1) = y(2)
    dy(2) = B1 * ( - A1*cos(alfa)*sin(alfa)*y(2)^2 - A1*A2*sin(alfa)*y(4)^2 + A1*A3*cos(alfa)*sin(y(3)) - A3*sin(y(1)) )
    dy(3) = y(4)
    dy(4) = B2 * ( - A1*cos(alfa)*sin(alfa)*y(2)^2 - A1*A2*sin(alfa)*y(4)^2 + A1*A3*cos(alfa)*sin(y(3)) - A3*sin(y(1)) ) + sin(alfa)*y(2)^2/A2 - A4*sin(y(3))
endfunction

y = ode(y0,0,t,PenduloDuplo)

res_phi     = y(1,:)
res_dphi    = y(2,:)
res_theta   = y(3,:)
res_dtheta  = y(4,:)

