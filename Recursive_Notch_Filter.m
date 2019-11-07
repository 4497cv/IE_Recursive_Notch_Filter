
function MATLAB_2_2()
    close all;
    tspan = [0 1];
    
    for k = 10:10:100
        disp(k);
        NOTCH_FILTER(tspan, 0.001, k*pi);
    end
end

function NOTCH_FILTER(tspan, T, w_in)
    %Rejection Frequency
    wi = 50;
    %Time definition
    t = (tspan(1): T: tspan(2));
    % Declaration of the notch filter parameters %
    n = 0.5; 
    Q = 0.5;
    % Angular frequency for sampling %
    wn = 100*pi;
    phi = (wi/wn);
    % Definition of the input signal %
    X = cos(w_in*t);
    % Definition of the output signal with the same size */
    Y = X*0;    
    % Past samples initialization %
    XKM1 = 0; % ultimate input value
    XKM2 = 0; % penultimate input value
    YKM1 = 0; % ultimate output value
    YKM2 = 0; % penultimate output value
    
    for k=1:size(t,2)
        % output value definition %
        Y(k) = X(k)-(2*cos(phi)*XKM1)+XKM2+(2*n*cos(phi)*YKM1)-(mpower(n,2)*YKM2);
        % Register previous input values %
        XKM2 = XKM1;
        XKM1 = X(k);
        % Register previous output values %
        YKM2 = YKM1;
        YKM1 = Y(k);
    end

    figure('Name', ['wo = ' num2str(w_in/pi)]); hold on;
    plot(t, X,'red'); plot(t, Y,'blue');
    title([' angular input frequency = ' num2str(w_in/pi) '\pi']);
    xlabel('time (t)');
    ylabel(' Amplitude ');
    legend('X(k)','Y(k)', 'Location', 'Southwest');
end
