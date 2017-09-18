
#include <apiextractor.h>

extern "C"
{
    ApiExtractor *ApiExtractor__new();
    void ApiExtractor__delete(ApiExtractor **self);

    bool ApiExtractor__run(ApiExtractor *self);
    void ApiExtractor__setCppFileName(ApiExtractor *self, QString *fileName);
    void ApiExtractor__setTypeSystem(ApiExtractor *self, QString *fileName);

}
