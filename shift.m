function oscillation = shift(t, data)
% oscillation = shift(t, data)

F = sin(data.frequency*(t/(60*60*24)));
plot(t,F)
keyboard
if F > 0
    oscillation = data.Light1;
else
    oscillation = data.Light2;
end
