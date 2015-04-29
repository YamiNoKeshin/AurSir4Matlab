key = fileread('example_importer.json');

interface = AurSirInterface('Matlab');
k = loadjson(key);
ia = interface.add_import(k, {});
disp(ia.id);
disp(ia.call('SayHello', '{"Greeting":"Hello from Matlab"}').decode());
ia.callAll('SayHello','{"Greeting":"Hello from Matlab"}');
disp(ia.listen().decode());
ia.start_listen('SayHello');
ia.trigger('SayHello','{"Greeting":"Hello from Matlab"}');
disp(ia.listen().decode());
ia.triggerAll('SayHello','{"Greeting":"Hello from Matlab"}');
disp(ia.listen().decode());
interface.stop();