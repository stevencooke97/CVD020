function[t2Newmarks,d2Newmarks] = Task2Newmarks(omegaF)

% % % Parameters
t = dlmread('Time.txt');
NoSteps = size(t,1);

dt = 0.01; % Seconds

m = 4; % Mg

k = 133.024044; % Average value obtained from Task 1
c = 6.525818; % Average value obtained from Task 1

f = zeros(NoSteps,1);
fAst = zeros(NoSteps,1);
a = zeros(NoSteps,1);
v = zeros(NoSteps,1);
d = zeros(NoSteps,1);

Beta = 0.25; % As per lecture notes (SAP2000)
Gamma = 0.5; % As per lecture notes (SAP2000)

% % % Initial values
f0 = 20; % kN
t0 = 0;
d0 = 0; % Assume zero displacement at point force is applied
v0 = 0; % Force applied at this point, therefore velocity not developed
a0 = inv(m)*(f0 - c*v0 - k*d0);

% % % Calculate MAst
MAst = m + Gamma*dt*c + Beta*(dt^2)*k;

% % % At point 1 (n = 0)
f(1) = f0*sin(omegaF*dt);
fAst(1) = f(1) - k*d0 - (c + dt*k)*v0 - (dt*c*(1 - Gamma) + ((dt^2)/2)*k*(1 - 2*Beta))*a0;
a(1) = inv(MAst)*fAst(1);
v(1) = v0 + dt*((1 - Gamma)*a0 + Gamma*a(1));
d(1) = d0 + dt*v0 + ((dt^2)/2)*((1 - 2*Beta)*a0 + 2*Beta*a(1));

for n = 1:(NoSteps-1)
    % Calculate fAst(n+1)
    f(n+1) = f0*sin(omegaF*(n+1)*dt);
    fAst(n+1) = f(n+1) - k*d(n) - (c + dt*k)*v(n) - (dt*c*(1 - Gamma) + ((dt^2)/2)*k*(1 - 2*Beta))*a(n);
    
    % Calculate a(n+1)
    a(n+1) = inv(MAst)*fAst(n+1);
    
    % Calculate v(n+1)
    v(n+1) = v(n) + dt*((1 - Gamma)*a(n) + Gamma*a(n+1));
    
    % Calculate d(n+1)
    d(n+1) = d(n) + dt*v(n) + ((dt^2)/2)*((1 - 2*Beta)*a(n) + 2*Beta*a(n+1));
end
   
t2Newmarks = t;
d2Newmarks = d;

% % % % Plot
% plot(t,d)
% title(['Newmark''s-Beta Displacement-Time graph for Test ' num2str(TestNumber) ' (\omega_{F} = ' num2str(omegaF) ' rad/s)'])
% xlabel('time (s)')
% ylabel('displacement (m)')

end