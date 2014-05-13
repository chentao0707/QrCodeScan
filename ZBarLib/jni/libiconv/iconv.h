#ifndef __ICONV_H__
#define __ICONV_H__

typedef void *iconv_t;
extern iconv_t iconv_open (const char *tocode, const char *fromcode);
extern size_t iconv (iconv_t cd, const char **inbuf,
                     size_t *inbytesleft, char **outbuf, size_t *outbytesleft);
extern int iconv_close (iconv_t cd);

#endif /* __ICONV_H__ */
