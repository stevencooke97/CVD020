function[t3aNewmarks,d3aNewmarks] = Task3aNewmarks()

% % % Accelerogram data loadup
fileID = fopen('Accelerogram Record 7.txt','r');
acc = 0.01*fscanf(fileID,'%f'); % Convert units from cm/sec^2 to m/sec^2. Store all data points in an array called acc
fclose(fileID); % Close the file Record_X.txt

% % % Parameters
accSize = size(acc,1);

NoSteps = accSize - 1;
dt = 0.02; % Seconds (unique to Group 7)

m = 7; % Mg
T0 = 0.2; % Seconds (unique to Group 7)
zeta0 = 0.05; % As per handout

omega0 = 2*pi()/T0;      % (unique to Group 7)

k = (omega0^2)*m ;       % (unique to Group 7)
c = 2*m*omega0*zeta0;   % (unique to Group 7)

f = zeros(NoSteps,1);
fAst = zeros(NoSteps,1);
a = zeros(NoSteps,1);
v = zeros(NoSteps,1);
d = zeros(NoSteps,1);

Beta = 0.25; % As per lecture notes (SAP2000)
Gamma = 0.5; % As per lecture notes (SAP2000)

xFinal = accSize; % Solve from x = [0, xFinal]
tFinal = (xFinal - 1)*dt;
t = dt:dt:tFinal;

% % % Initial values
t0 = 0;
d0 = 0; % Assume zero displacement at point force is applied
v0 = 0; % Force applied at this point, therefore velocity not developed
a0 = acc(1);
% f0 = m*a0; % kN

% % % Calculate MAst
MAst = m + Gamma*dt*c + Beta*(dt^2)*k;

% % % At point 1 (n = 0)
a(1) = acc(2);
v(1) = v0 + dt*((1 - Gamma)*a0 + Gamma*a(1));
d(1) = d0 + dt*v0 + ((dt^2)/2)*((1 - 2*Beta)*a0 + 2*Beta*a(1));

for n = 1:(NoSteps-1)
    % Calculate fAst(n+1)
    f(n+1) = m*acc(n+2);
    fAst(n+1) = f(n+1) - k*d(n) - (c + dt*k)*v(n) - (dt*c*(1 - Gamma) + ((dt^2)/2)*k*(1 - 2*Beta))*a(n);
    
    % Calculate a(n+1)
    a(n+1) = inv(MAst)*fAst(n+1);
    
    % Calculate v(n+1)
    v(n+1) = v(n) + dt*((1 - Gamma)*a(n) + Gamma*a(n+1));
    
    % Calculate d(n+1)
    d(n+1) = d(n) + dt*v(n) + ((dt^2)/2)*((1 - 2*Beta)*a(n) + 2*Beta*a(n+1));
end
   
t3aNewmarks = t;
d3aNewmarks = d;

% % % % Plot
% plot(t,d)
% title('Newmark''s-Beta Displacement-Time graph for bare frame subjected to Yoneyama Bridge accelerogram')
% xlabel('time (s)')
% ylabel('displacement (m)')

end