function[t3aRK4,d3aRK4] = Task3aRK4()

% % % Accelerogram data loadup
fileID = fopen('Accelerogram Record 7.txt','r');
acc = 0.01*fscanf(fileID,'%f'); % Convert units from cm/sec^2 to m/sec^2. Store all data points in an array called acc
fclose(fileID); % Close the file Record_X.txt

% % % Parameters
accSize = size(acc,1);

NoSteps = accSize;
dt = 0.02; % Seconds (unique to Group 7)

xFinal = accSize; % Solve from x = [0, xFinal]
tFinal = (xFinal-1)*dt;
t = 0:dt:tFinal;

m = 7; % Mg
T0 = 0.2; % Seconds (unique to Group 7)
zeta0 = 0.05; % As per handout

omega0 = 2*pi()/T0; % (unique to Group 7)

k = (omega0^2)*m ; % (unique to Group 7)
c = 2*m*omega0*zeta0; % (unique to Group 7)

A = [0 1; -(omega0^2) -2*zeta0*omega0];
b = [0; 1/m];

% % % Initial conditions
ndof = 1; % SDoF
u0 = zeros(ndof,1);
v0 = zeros(ndof,1);
y0 = [u0; v0];

y = zeros(2*ndof, xFinal); 

y(:,1) = y0; % State vector at t=0

% % % RK4 loop
for n = 1:xFinal-1
    f1 = m*acc(n);
    f2 = m*(acc(n) + acc(n+1));
    f3 = m*acc(n+1);
    
    g1 = A*y(:,n) + b*f1;
    g2 = A*(y(:,n) + g1*0.5*dt) + 0.5*b*f2;
    g3 = A*(y(:,n) + g2*0.5*dt) + 0.5*b*f2;
    g4 = A*(y(:,n) + g3*dt) + b*f3;
    
    y(:,n+1) = y(:,n) + (1/6)*(g1 + 2*g2 + 2*g3 + g4)*dt;
end

t3aRK4 = t;
d3aRK4 = y(1,:);

% % % % Plot
% plot(t,y(1,:));
% title('RK4 Displacement-Time graph for bare frame subjected to Yoneyama Bridge accelerogram')
% xlabel('time (s)')
% ylabel('displacement (m)')

end