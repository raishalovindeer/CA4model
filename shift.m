function oscillation = shift(t, data)
% oscillation = shift(data)

A = 0.5;    % oscillation frequency
F = cos(A*t);
% keyboard
oscillation = data.In.blue * F + (1-F) * data.In.green;

