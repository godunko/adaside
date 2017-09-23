
#include "apiextractor_wrapper.h"

extern "C"
{

    void ApiExtractor__addIncludePath(ApiExtractor *self, HeaderPath *path) 
    {
        self->addIncludePath(*path);
    }

    void ApiExtractor__classes(AbstractMetaClassList* _result, ApiExtractor *self)
    {
       *_result = self->classes();
    }

    void ApiExtractor__delete(ApiExtractor **self)
    {
        delete *self;
        self = NULL;
    }

    ApiExtractor *ApiExtractor__new()
    {
        return new ApiExtractor();
    }

    bool ApiExtractor__run(ApiExtractor *self)
    {
        bool _return = self->run();
        qCWarning(lcShiboken) << *self;
//        qCDebug(lcShiboken) << *self;
        return _return;
//        return self->run();
    }

    void ApiExtractor__setCppFileName(ApiExtractor *self, QString *fileName)
    {
        self->setCppFileName(*fileName);
    }

    void ApiExtractor__setTypeSystem(ApiExtractor *self, QString *fileName)
    {
        self->setTypeSystem(*fileName);
    }

}

void ApiExtractor__setLogDirectory(ApiExtractor *self, QString *dirName)
{
    self->setLogDirectory(*dirName);
}
