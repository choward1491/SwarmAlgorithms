x = linspace(0,3,100);
y = zeros(size(x));

for i = 1:length(y)
    y(i) = drones(1).GetCenterPotential(x(i));
end


figure(1)
plot(x,y,'b-')
title('Center Potential versus radial distance')
xlabel('Radial Distance')
ylabel('Potential Value')