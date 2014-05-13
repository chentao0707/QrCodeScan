#include <stdlib.h>
#include <iconv.h>

#include <android/log.h>

iconv_t iconv_open (const char *tocode, const char *fromcode) {
	return NULL;
}

size_t iconv (iconv_t cd, const char **inbuf, size_t *inbytesleft, 
		char **outbuf, size_t *outbytesleft) {
	size_t sz = *inbytesleft;
	memcpy(*outbuf, *inbuf, sz);

	__android_log_print(ANDROID_LOG_DEBUG, "zbar", "convert: %s, sz=%d", *inbuf, sz);

	*inbuf += sz;
	*outbuf += sz;
	*inbytesleft -= sz;
	*outbytesleft -= sz;
	return sz;
}

int iconv_close (iconv_t cd) {
	return 0;
}

