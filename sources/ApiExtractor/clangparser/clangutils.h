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

#ifndef CLANGUTILS_H
#define CLANGUTILS_H

#include <clang-c/Index.h>
#include <QtCore/QPair>
#include <QtCore/QString>
#include <QtCore/QVector>

QT_FORWARD_DECLARE_CLASS(QDebug)

bool operator==(const CXCursor &c1, const CXCursor &c2);
uint qHash(const CXCursor &c, uint seed = 0);

namespace clang {

QString getCursorKindName(CXCursorKind cursorKind);
QString getCursorSpelling(const CXCursor &cursor);
QString getCursorDisplayName(const CXCursor &cursor);
QString getTypeName(const CXType &type);
inline QString getCursorTypeName(const CXCursor &cursor)
    { return getTypeName(clang_getCursorType(cursor)); }
inline QString getCursorResultTypeName(const CXCursor &cursor)
    { return getTypeName(clang_getCursorResultType(cursor)); }

inline bool isCursorValid(const CXCursor &c)
{
    return c.kind < CXCursor_FirstInvalid || c.kind >  CXCursor_LastInvalid;
}

struct SourceLocation
{
    int compare(const SourceLocation &rhs) const;

    QString file;
    unsigned line = 0;
    unsigned column = 0;
    unsigned offset = 0;
};

SourceLocation getExpansionLocation(const CXSourceLocation &location);

typedef QPair<SourceLocation, SourceLocation> SourceRange;

SourceLocation getCursorLocation(const CXCursor &cursor);
CXString getFileNameFromLocation(const CXSourceLocation &location);
SourceRange getCursorRange(const CXCursor &cursor);

struct Diagnostic {
    enum  Source { Clang, Other };

    Diagnostic() : source(Clang) {}
    // Clang
    static Diagnostic fromCXDiagnostic(CXDiagnostic cd);
    // Other
    explicit Diagnostic(const QString &m, const CXCursor &c, CXDiagnosticSeverity s = CXDiagnostic_Warning);

    QString message;
    QStringList childMessages;
    SourceLocation location;
    Source source;
    CXDiagnosticSeverity severity;
};

QVector<Diagnostic> getDiagnostics(CXTranslationUnit tu);
CXDiagnosticSeverity maxSeverity(const QVector<Diagnostic> &ds);

#ifndef QT_NO_DEBUG_STREAM
QDebug operator<<(QDebug, const SourceLocation &);
QDebug operator<<(QDebug, const Diagnostic &);
#endif // QT_NO_DEBUG_STREAM
} // namespace clang

#endif // CLANGUTILS_H
