function[t2RK4,d2RK4] = Task2RK4(omegaF)

% % % Parameters
NoSteps = 4000;
dt = 0.01; % Seconds

m = 4; % Mg

k = 133.024044; % Average value obtained from Task 1
c = 6.525818; % Average value obtained from Task 1

omega0 = sqrt(k/m);
zeta0 = c/(2*m*omega0);

A = [0 1; -(omega0^2) -2*zeta0*omega0];
b = [0; 1/m];

xFinal = 4001; % Solve from x = [0, xFinal]
tFinal = (xFinal - 1)*dt;
t = [0:dt:tFinal];

% % % Initial conditions
ndof = 1; % SDoF
u0 = zeros(ndof,1);
v0 = zeros(ndof,1);
y0 = [u0; v0];
ft0 = 20; % kN
f = zeros(2*NoSteps, 1);

y = zeros(2*ndof, xFinal); 

y(:,1) = y0; % State vector at t=0

% % % RK4 loop
for n = 1:xFinal-1
    f1 = ft0*sin(omegaF*n*dt);
    f2 = ft0*sin(omegaF*(n+0.5)*dt);
    f3 = ft0*sin(omegaF*(n+1)*dt);
    
    g1 = A*y(:,n) + b*f1;
    g2 = A*(y(:,n) + g1*0.5*dt) + b*f2;
    g3 = A*(y(:,n) + g2*0.5*dt) + b*f2;
    g4 = A*(y(:,n) + g3*dt) + b*f3;
    
    y(:,n+1) = y(:,n) + (1/6)*(g1 + 2*g2 + 2*g3 + g4)*dt;
end

t2RK4 = t;
d2RK4 = y(1,:);

% % % % Plot
% plot(t,y(1,:));
% title(['RK4 Displacement-Time graph for Test ' num2str(TestNumber) ' (\omega_{F} = ' num2str(omegaF) ' rad/s)'])
% xlabel('time (s)')
% ylabel('displacement (m)')

end