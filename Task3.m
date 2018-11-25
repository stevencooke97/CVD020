[t3aNewmarks,d3aNewmarks] = Task3aNewmarks();
[t3aRK4,d3aRK4] = Task3aRK4();
[t3bNewmarks,d3bNewmarks] = Task3bNewmarks();
[t3cRK4,d3cRK4] = Task3cRK4();

Input = input('Full results (1), t=0:8 (2), or t=8:18 (3)? '); % Ask user to input which test (2 or 3)
switch Input
    case 1
        setxlimit = [0 18];
        setylimit = [-0.002 0.0025];
    case 2
        setxlimit = [0 8];
        setylimit = [-0.002 0.0025];
    case 3
        setxlimit = [8 18];
        setylimit = [-0.0003 0.0003];
    otherwise
        fprintf('Code failed: please enter (1), (2) or (3)');
        return
end

plot(t3aNewmarks,d3aNewmarks,'r');
hold on
plot(t3aRK4,d3aRK4,'b');
plot(t3bNewmarks,d3bNewmarks,'g','LineWidth',1.25);
% hold on
plot(t3cRK4,d3cRK4,'c','LineWidth',1.25);
title(['Displacement-Time graph for structural configurations 3a-c subjected to Yoneyama Bridge accelerogram for t = ' num2str(setxlimit(1)) ' - ' num2str(setxlimit(2)) ' s']) 
xlabel('Time (s)')
ylabel('Displacement (m)')
legend('3a Newmark-\beta','3a RK4','3b Newmark-\beta','3c RK4')
xlim(setxlimit)
ylim(setylimit)