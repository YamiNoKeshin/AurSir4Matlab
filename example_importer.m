key = fileread('example_importer.json');

interface = AurSirInterface('Matlab');
k = loadjson(key);
ia = interface.add_import(k, {});
disp(ia.id)
disp(ia.call('SayHello', '{"Greeting":"Hello from aursir4py"}').decode())