function make()

mex base64_encode.c base64.c -I.
mex base64_decode.c base64.c -I.

end

