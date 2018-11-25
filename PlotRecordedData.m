close all
clear all
clc

Ts = 0.01;

Input = input('Which test? (1, 2 or 3) '); % Ask user to input which test (1, 2 or 3)
switch Input
    case 1
        TestNumber = 1;
    case 2
        TestNumber = 2;
    case 3
        TestNumber = 3;
    otherwise
        fprintf('Code failed: please enter (1), (2) or (3)');
        return
end

range = input('How many points of data? ');

TestData = dlmread(['Test ' num2str(TestNumber) ' Data.txt']);
Time = TestData(1:range,1);
Disp = TestData(1:range,2);

plot(Time, Disp);
title(['Plot of recorded data for Test ' num2str(TestNumber) ' up to t = ' num2str(range*Ts - Ts) ' s'])
xlabel('Time (s)')
ylabel('Displacement (m)')
ylim([-0.3 0.3])
