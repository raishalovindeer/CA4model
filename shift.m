function oscillation = shift(t, data)
% oscillation = shift(data)

F = sin(data.A*(t/(60*60*24)));
oscillation = data.In.cyan*F;
if F < 0
    oscillation = data.In.green*(1-F);
end
