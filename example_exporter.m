key = fileread('example_exporter.json');

interface = AurSirInterface('Matlab');
k = loadjson(key);
ea = interface.add_export(k, {});
disp(ea.id)
while 1
    r = ea.request();
    req = r.decode();
    disp(req);
    ea.reply(r,strcat('{"Answer": "Greetings back from Matlab you said ''',req.Greeting,'''"}'));
end
