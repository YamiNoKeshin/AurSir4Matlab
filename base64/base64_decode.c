#include "mex.h"
#include <string.h>

extern int b64_pton(char const *src, u_char *target, size_t targsize);

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[]){
    char* buf;
    char* code;
    size_t buflen;
    size_t codelen;
    
    if (nrhs != 1) { 
	    mexErrMsgIdAndTxt( "AurSir:base64_encode:invalidNumInputs", 
                "One input argument required.");
    } 
    if (nlhs > 1) {
	    mexErrMsgIdAndTxt( "AurSir:base64_encode:maxlhs",
                "Too many output arguments.");
    }
    
    if (!mxIsChar(prhs[0]) || (mxGetM(prhs[0]) != 1 ) )  {
	    mexErrMsgIdAndTxt( "AurSir:base64_encode:invalidInput", 
                "Input argument must be a string.");
    }
    
    buf = mxArrayToString(prhs[0]);
    buflen = strlen(buf);
    codelen = buflen;
    
    code = mxCalloc(codelen, sizeof(char));
    
    b64_pton(buf, code, codelen);
    
    plhs[0] = mxCreateString(code);
    
    mxFree(buf);
    mxFree(code);
    
}