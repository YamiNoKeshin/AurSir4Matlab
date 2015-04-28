key = fileread('example_exporter.json');

interface = AurSirInterface('Matlab');
k = loadjson(key);
ea = interface.add_export(k, {});
disp(ea.id)

while 1
    r = ea.request();
    disp(r);
end