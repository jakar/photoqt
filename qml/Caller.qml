import QtQuick 2.6

Item {

    property var elementssetup: []

    // The loaded elements connect to these signals to show/hide
    signal openfileShow()
    signal openfileHide()

    signal thumbnailsShow()
    signal thumbnailsHide()
    signal thumbnailsLoadDirectory(var filename, var filter)

    signal settingsmanagerShow()
    signal settingsmanagerHide()
    signal settingsmanagerSave()
    signal settingsmanagerNextTab()
    signal settingsmanagerPrevTab()
    signal settingsmanagerGoToTab(var index)

    signal slideshowSettingsShow()
    signal slideshowSettingsHide()
    signal slideshowBarShow()
    signal slideshowBarHide()
    signal slideshowStart()
    signal slideshowStop()
    signal slideshowQuickStart()
    signal slideshowPause()

    signal histogramShow()
    signal histogramHide()

    signal filemanagementShow(var category)
    signal filemanagementHide()
    signal permanentDeleteFile()

    signal aboutShow()
    signal aboutHide()

    property var whatisshown: ({"thumbnails" : false,
                                   "openfile" : false,
                                   "settingsmanager" : false,
                                   "slideshowsettings" : false,
                                   "slideshowbar" : false,
                                   "histogram" : false,
                                   "filemanagement" : false,
                                   "about" : false})

    // Load and show a component
    function show(component) {

        ensureElementSetup(component)

        if(component == "openfile") {
            openfileShow()
            whatisshown[component] = true
        } else if(component == "thumbnails") {
            thumbnailsShow()
            whatisshown[component] = true
        } else if(component == "settingsmanager") {
            settingsmanagerShow()
            whatisshown[component] = true
        } else if(component == "slideshowsettings") {
            slideshowSettingsShow()
            whatisshown[component] = true
        } else if(component == "slideshowbar") {
            slideshowBarShow()
            whatisshown[component] = true
        } else if(component == "histogram") {
            histogramShow()
            whatisshown[component] = true
        } else if(component == "about") {
            aboutShow()
            whatisshown[component] = true
        }

    }

    // Hide a component
    function hide(component) {
        if(component == "openfile") {
            openfileHide()
            whatisshown[component] = false
        } else if(component == "thumbnails") {
            thumbnailsHide()
            whatisshown[component] = false
        } else if(component == "settingsmanager") {
            settingsmanagerHide()
            whatisshown[component] = false
        } else if(component == "slideshowsettings") {
            slideshowSettingsHide()
            whatisshown[component] = false
        } else if(component == "slideshowbar") {
            slideshowBarHide()
            whatisshown[component] = false
        } else if(component == "histogram") {
            histogramHide()
            whatisshown[component] = false
        } else if(component == "filemanagement") {
            filemanagementHide()
            whatisshown[component] = false
        } else if(component == "about") {
            aboutHide()
            whatisshown[component] = false
        }
    }

    // Load some function
    function load(func) {

        if(func == "thumbnailLoadDirectory")
            thumbnailsLoadDirectory(variables.currentFile, variables.filter)
        else if(func == "settingsmanagerSave")
            settingsmanagerSave()
        else if(func == "settingsmanagerNextTab")
            settingsmanagerNextTab()
        else if(func == "settingsmanagerPrevTab")
            settingsmanagerPrevTab()
        else if(func == "settingsmanagerPrevTab")
            settingsmanagerPrevTab()
        else if(func == "settingsmanagerGoToTab1")
            settingsmanagerGoToTab(0)
        else if(func == "settingsmanagerGoToTab2")
            settingsmanagerGoToTab(1)
        else if(func == "settingsmanagerGoToTab3")
            settingsmanagerGoToTab(2)
        else if(func == "settingsmanagerGoToTab4")
            settingsmanagerGoToTab(3)
        else if(func == "settingsmanagerGoToTab5")
            settingsmanagerGoToTab(4)
        else if(func == "settingsmanagerGoToTab6")
            settingsmanagerGoToTab(5)
        else if(func == "slideshowStart")
            slideshowStart()
        else if(func == "slideshowStop")
            slideshowStop()
        else if(func == "slideshowQuickStart") {
            ensureElementSetup("slideshowsettings")
            slideshowQuickStart()
        } else if(func == "slideshowPause")
            slideshowPause()
        else if(func == "filemanagementCopyShow") {
            ensureElementSetup("filemanagement")
            filemanagementShow("cp")
            whatisshown["filemanagement"] = true
        } else if(func == "filemanagementDeleteShow") {
            ensureElementSetup("filemanagement")
            filemanagementShow("del")
            whatisshown["filemanagement"] = true
        } else if(func == "filemanagementMoveShow") {
            ensureElementSetup("filemanagement")
            filemanagementShow("mv")
            whatisshown["filemanagement"] = true
        } else if(func == "filemanagementRenameShow") {
            ensureElementSetup("filemanagement")
            filemanagementShow("rn")
            whatisshown["filemanagement"] = true
        } else if(func == "permanentDeleteFile") {
            ensureElementSetup("filemanagement")
            permanentDeleteFile()
        }

    }

    function ensureElementSetup(component) {

        if(elementssetup.indexOf(component) < 0) {
            if(component == "openfile") {
                openfile.source = "openfile/OpenFile.qml"
                elementssetup.push(component)
            } else if(component == "thumbnails") {
                thumbnails.source = "mainview/Thumbnails.qml"
                elementssetup.push(component)
            } else if(component == "settingsmanager") {
                settingsmanager.source = "settingsmanager/SettingsManager.qml"
                elementssetup.push(component)
            } else if(component == "slideshowsettings") {
                slideshowsettings.source = "slideshow/SlideshowSettings.qml"
                slideshowbar.source = "slideshow/SlideshowBar.qml"
                elementssetup.push(component)
                elementssetup.push("slideshowbar")
            } else if(component == "slideshowbar") {
                slideshowsettings.source = "slideshow/SlideshowSettings.qml"
                slideshowbar.source = "slideshow/SlideshowBar.qml"
                elementssetup.push("slideshowsettings")
                elementssetup.push(component)
            } else if(component == "histogram") {
                histogram.source = "mainview/Histogram.qml"
                elementssetup.push(component)
            } else if(component == "filemanagement") {
                filemanagement.source = "filemanagement/Management.qml"
                elementssetup.push(component)
            } else if(component == "about") {
                about.source = "other/About.qml"
                elementssetup.push(component)
            }
        }

    }

}
