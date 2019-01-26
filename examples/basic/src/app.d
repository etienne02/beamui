/**
This app is a demo of very basic beamui application.

Synopsis:
---
dub run :basic
---

Copyright: Vadim Lopatin 2014-2017, dayllenger 2018
License:   Boost License 1.0
Authors:   Vadim Lopatin, dayllenger
*/
module app;

import beamui;

/// Entry point for application
int main()
{
    GuiApp app;
    app.conf.theme = "light"; // load better theme
    if (!app.initialize())
        return -1;

    // create a window with 1x1 size and expand it to the size of content
    Window window = platform.createWindow("Basic example - beamui", null, WindowOptions.expanded, 1, 1);

    // create some widgets to show
    // Column arranges items vertically
    auto pane = new Column;
        auto header = new Label("Header");
        auto ed1 = new EditLine("Hello");
        auto ed2 = new EditLine("world");
        auto check = new CheckBox("Check me");
        // Row organizes items horizontally
        auto line = new Row;
            auto ok = new Button("OK");
            auto exit = new Button("Exit");

    // using "with" statement for readability
    with (pane) {
        style.minWidth = 200;
        style.padding = Insets(15);
        add(header, ed1, ed2, check, line);
        with (header) {
            style.fontSize = 18;
        }
        with (line) {
            // let the buttons fill horizontal space
            add(ok).setFillWidth(true);
            add(exit).setFillWidth(true);
        }
    }

    // disable OK button
    ok.enabled = false;
    // and enable it when the check box has been pressed
    check.toggled ~= (Widget src, bool checked) {
        ok.enabled = checked;
    };
    // show message box on OK button click
    ok.clicked ~= (Widget src) {
        window.showMessageBox("Message box"d, format("%s, %s!"d, ed1.text, ed2.text));
    };
    // close the window by clicking Exit
    exit.clicked ~= (Widget src) {
        window.close();
    };

    // set main widget for the window and show it
    window.mainWidget = pane;
    window.show();
    // run event loop
    return platform.enterMessageLoop();
}
