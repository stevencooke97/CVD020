% % % Test identification and OmegaF value assignment
Input = input('Which test? (2 or 3) '); % Ask user to input which test (2 or 3)
switch Input
    case 2
        omegaF = 3; % rad/s
        TestNumber = 2;
    case 3
        omegaF = 8; % rad/s
        TestNumber = 3;
    otherwise
        fprintf('Code failed: please enter (2) or (3)');
        return
end

[t2Newmarks,d2Newmarks] = Task2Newmarks(omegaF);
[t2RK4,d2RK4] = Task2RK4(omegaF);

plot(t2Newmarks,d2Newmarks,'r');
hold on
plot(t2RK4,d2RK4,'b')
title(['Displacement-Time graph for Test ' num2str(TestNumber) ' (\omega_{F} = ' num2str(omegaF) ' rad/s)'])
xlabel('Time (s)')
ylabel('Displacement (m)')
ylim([-0.3 0.3])
legend('Newmark-\beta','RK4','Location','northeast')