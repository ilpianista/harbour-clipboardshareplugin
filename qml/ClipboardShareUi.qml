/*
The MIT License (MIT)

Copyright (c) 2016 Oleg Linkin <maledictusdemagog@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property var shareAction
    property var content
    property bool _doPop: false

    function close() {
        if (pageStack.busy) {
            _doPop = true;
        } else {
            _doPop = false;
            pageStack.pop(null, PageStackAction.Immediate);
            if (pageStack.depth > 1)
                pageStack.pop(null, PageStackAction.Immediate);

        }
    }

    onContentChanged: {
        if (content !== undefined && content.status !== undefined && content.status.length > 0)
            Clipboard.text = content.status;

        close();
    }
    Component.onCompleted: {
        if (shareAction !== undefined) {
            if (shareAction.resources !== undefined) {
                for (var i = 0, size = shareAction.resources.length; i < size; i++) {
                    if (shareAction.resources[i].status && shareAction.resources[i].status.length > 0) {
                        Clipboard.text = shareAction.resources[i].status;
                        break;
                    }
                }
            }
            shareAction.done();
        }
    }

    Connections {
        target: pageStack
        onBusyChanged: close()
    }

}
