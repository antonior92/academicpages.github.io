% Planta
sys = zpk([], [-1, -1, -1, -1, -1], 1);

% Resposta ao degrau
K = 1
L = 2.3;
T = 7.1 - L;
figure(1)
step(sys)

sys_red = tf([K], [T, 1], 'iodelay', L)
hold on
step(sys_red)

%% Controlador PID
Kp = 1.2*T/L;
Ti = 2*L;
Td = 0.5*L;
s = tf([1 0], [1]);
PID = Kp*(1 + 1/(Ti*s) + Td*s);

% disturbance response
dist_sys = feedback(sys, PID);
% reference response
ref_sys = feedback(sys*PID, 1);

figure(2)
subplot(211)
step(ref_sys)
subplot(212)
step(dist_sys)


