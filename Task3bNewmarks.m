function[t3bNewmarks,d3bNewmarks] = Task3bNewmarks()

% % % Accelerogram data loadup
fileID = fopen('Accelerogram Record 7.txt','r');
acc = 0.01*fscanf(fileID,'%f'); % Convert units from cm/sec^2 to m/sec^2. Store all data points in an array called acc
fclose(fileID); % Close the file Record_X.txt

% % % Parameters
accSize = size(acc,1);

NoSteps = accSize - 1;
dt = 0.02; % Seconds (unique to Group 7)
ndof = 2;

m = 7; % Mg
mb = 9; % Mg
% mForBase = m + mb; % Mg, for base displacement calculations consider m and mb
T0 = 0.2; % Seconds (unique to Group 7)
zeta0 = 0.02; % As per handout

omega0 = 2*pi()/T0; % (unique to Group 7)

k = (omega0^2)*m ; % (unique to Group 7)
c = 2*m*omega0*zeta0; % (unique to Group 7)

kiso = 66.512022; % As per Task 1
ciso = 3.262909; % As per Task 1

M = [m 0; 0 m+mb];
K = [k -k; -k k+2*kiso];
C = [c -c; -c c+2*ciso];

f = zeros(NoSteps,ndof);
fAst = zeros(NoSteps,ndof);
a = zeros(NoSteps,ndof);
v = zeros(NoSteps,ndof);
d = zeros(NoSteps,ndof);

Beta = 0.25; % As per lecture notes (SAP2000)
Gamma = 0.5; % As per lecture notes (SAP2000)

xFinal = accSize; % Solve from x = [0, xFinal]
tFinal = (xFinal - 1)*dt;
t = dt:dt:tFinal;

acc(:,2) = acc(:,1);

% % % Initial values
t0 = 0;
d0 = [0 0]; % Assume zero displacement at point force is applied
v0 = [0 0]; % Force applied at this point, therefore velocity not developed
a0 = acc(1,:);

% % % % % U(t)
% % % Calculate MAst
MAst = M + Gamma*dt*C + Beta*(dt^2)*K;

% % % At point 1 (n = 0)
a(1,:) = acc(2,:);
v(1,:) = v0 + dt*((1 - Gamma)*a0 + Gamma*a(1,:));
d(1,:) = d0 + dt*v0 + ((dt^2)/2)*((1 - 2*Beta)*a0 + 2*Beta*a(1,:));

for n = 1:(NoSteps-1)
    % Calculate fAst(n+1)
    f(n+1,:) = M*acc(n+2,:).';
    fAst(n+1,:) = f(n+1,:).' - K*d(n,:).' - (C + dt*K)*v(n,:).' - (dt*C*(1 - Gamma) + ((dt^2)/2)*K*(1 - 2*Beta))*a(n,:).';
    
    % Calculate a(n+1)
    a(n+1,:) = inv(MAst)*fAst(n+1,:).';
    
    % Calculate v(n+1)
    v(n+1,:) = v(n,:) + dt*((1 - Gamma)*a(n,:) + Gamma*a(n+1,:));
    
    % Calculate d(n+1)
    d(n+1,:) = d(n,:) + dt*v(n,:) + ((dt^2)/2)*((1 - 2*Beta)*a(n,:) + 2*Beta*a(n+1,:));
end

drel = d(:,1) - d(:,2); % drelative = dtotal - dbase

t3bNewmarks = t;
d3bNewmarks = drel;

% % % % Plot
% plot(t,drel,'r');
% title('Newmark''s-Beta Displacement-Time graph for base isolated frame subjected to Yoneyama Bridge accelerogram');
% xlabel('time (s)');
% ylabel('displacement (m)');

end