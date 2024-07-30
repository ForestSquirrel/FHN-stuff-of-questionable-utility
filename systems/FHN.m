function Ydot = FHN(t, Y, alpha, b, amp, w)
% FitzHugh-Nagumo (FHN) chaotic neuron model
Ydot = zeros(2,1);
x = Y(1); y = Y(2);
% parameters
Ydot(1) = x*(x - 1)*(1 - alpha*x) - y + amp/w*cos(w*t);
Ydot(2) = b*x;
end