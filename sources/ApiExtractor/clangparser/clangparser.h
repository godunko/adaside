/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of PySide2.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef CLANGPARSER_H
#define CLANGPARSER_H

#include <clang-c/Index.h>

#include <QtCore/QByteArrayList>
#include <QtCore/QHash>
#include <QtCore/QPair>
#include <QtCore/QString>
#include <QtCore/QVector>

namespace clang {

struct Diagnostic;

class SourceFileCache {
public:
    typedef QPair<const char *, const char *> Snippet;

    Snippet getCodeSnippet(const CXCursor &cursor);

private:
    typedef QHash<QString, QByteArray> FileBufferCache;

    FileBufferCache m_fileBufferCache;
};

class BaseVisitor {
    Q_DISABLE_COPY(BaseVisitor)
public:
    typedef QVector<Diagnostic> Diagnostics;
    typedef SourceFileCache::Snippet CodeSnippet;

    enum StartTokenResult { Error, Skip, Recurse };

    BaseVisitor();
    virtual ~BaseVisitor();

    // Whether location should be visited.
    // defaults to clang_Location_isFromMainFile()
    virtual bool visitLocation(const CXSourceLocation &location) const;

    virtual StartTokenResult startToken(const CXCursor &cursor) = 0;
    virtual bool endToken(const CXCursor &cursor) = 0;

    StartTokenResult cbHandleStartToken(const CXCursor &cursor);
    bool cbHandleEndToken(const CXCursor &cursor, StartTokenResult startResult);

    CodeSnippet getCodeSnippet(const CXCursor &cursor);
    QString getCodeSnippetString(const CXCursor &cursor);

    Diagnostics diagnostics() const;
    void setDiagnostics(const Diagnostics &d);
    void appendDiagnostic(const Diagnostic &d);

private:
    SourceFileCache m_fileCache;
    Diagnostics m_diagnostics;
};

bool parse(const QByteArrayList  &clangArgs, unsigned clangFlags, BaseVisitor &ctx);

} // namespace clang

#endif // !CLANGPARSER_H
