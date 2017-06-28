% Planta
sys = zpk([], [-1, -1, -1, -1, -1], 1);

figure
rlocus(sys)


sys_osc = feedback(sys*K_cr, 1);

figure
step(sys_osc, 100)

K_cr = 2.88;
P_cr = 8.625;

% Controlador PID
Kp = 0.6 * K_cr;
Ti = 0.5 * P_cr;
Td = 0.125 * P_cr;

s = tf([1 0], [1]);
PID = Kp*(1 + 1/(Ti*s) + Td*s);

% disturbance response
dist_sys = feedback(sys, PID);
% reference response
ref_sys = feedback(sys*PID, 1);

figure
subplot(211)
step(ref_sys)
subplot(212)
step(dist_sys)


