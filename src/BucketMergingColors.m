function NetColor = BucketMergingColors( colors, volumes)
net = sum(volumes);
vol_portion = volumes./net;

NetColor = [0, 0, 0];

for i = 1:length(volumes)
    NetColor = NetColor + colors(i,:)*vol_portion(i);
end

end