function [g] = param(x,fnum)
if(fnum==3)
P = 6000; L = 14; E = 30e+6; G = 12e+6;
t_max = 13600; s_max = 30000; d_max = 0.25;
M = P*(L+x(2)/2); R = sqrt(0.25*(x(2)^2+(x(1)+x(3))^2));
J = 2/sqrt(2)*x(1)*x(2)*(x(2)^2/12+0.25*(x(1)+x(3))^2);
P_c = (4.013*E/(6*L^2))*x(3)*x(4)^3*(1-0.25*x(3)*sqrt(E/G)/L);
t1 = P/(sqrt(2)*x(1)*x(2)); t2 = M*R/J;
t = sqrt(t1^2+t1*t2*x(2)/R+t2^2);
s = 6*P*L/(x(4)*x(3)^2);
d = 4*P*L^3/(E*x(4)*x(3)^3);
g(1) = t-t_max;
g(2) = s-s_max;
g(4) = x(1)-x(4);
g(7)= 0.10471*x(1)^2+0.04811*x(3)*x(4)*(14.0+x(2))-5.0;
g(3) = d-d_max;
g(5) = P-P_c;
g(6) = -x(1)+0.125;

elseif(fnum==5)
    F_max = 453.6;
    S = 13288.02;
    G = 808543.6;
    l_max = 35.56;
    d_min = 0.508;
    D_max = 7.62;
    d_pm = 15.24;
    F_p = 136.08;
    d_w = 3.175;
    C = x(2)/x(1);
    Cf = (4*C - 1)/(4*C - 4) + (0.615/C);
    
    g(1) = S - (8*Cf*F_max*x(2))/(pi*x(1)^3);
    
    K = (G*x(1)^4)/(8*x(3)*x(2)^3);
    dl = F_max/K;
    lf = dl + 1.05*(x(3)+2)*x(1);
    
    g(2) = l_max - lf;
    g(3) = x(1) - d_min;
    g(4) = D_max - (x(2)+x(1));
    g(5) = C - 3*x(1);
    
    d_p = F_p/K;
    g(6) = d_pm - d_p;
    g(7) = lf - d_p;
    g(8) = dl - d_p - d_w;
end
end