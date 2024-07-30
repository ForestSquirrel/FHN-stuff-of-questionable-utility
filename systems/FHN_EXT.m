function Ydot = FHN_EXT(t, y, w, alpha, b, EXT, h)
Ydot = zeros(2,1);
x = y(1); y = y(2);
I0 = interp_point_by_point(EXT, t, h); %interpolates external force to exact point of integration
Ydot(1) = w * (x*(x - 1)*(1 - alpha*x) - y + I0);
Ydot(2) = w * b*x;

end
