cmake_minimum_required(VERSION 3.16)

project(QtUiAssessment VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)


qt_add_executable(appQtUiAssessment
    main.cpp

    fontawesome/fontawesome.h
    fontawesome/fontawesome.cpp
    avatarprovider.h avatarprovider.cpp

    chatmodel.h chatmodel.cpp
    profilemodel.cpp profilemodel.h

    fontawesome/fontawesome.qrc
    res.qrc
)

qt_add_qml_module(appQtUiAssessment
    URI QtUiAssessment
    VERSION 1.0
    QML_FILES
        Main.qml
        components/SidebarButton.qml
        components/UserSideMenu.qml
        components/ExpandablePanel.qml
        components/ChatView.qml
        components/AwesomeIconButton.qml
        components/ChatPost.qml
        components/Badge.qml
)

qt_add_resources(appQtUiAssessment "app_icons"
    PREFIX "/"
    FILES
        icons/more.png
        icons/at.png
        icons/bookmark.png
        icons/hash.png
        icons/quick.png
)

qt_add_resources(appQtUiAssessment "app_fonts"
    PREFIX "/fonts"
    FILES
        fontawesome/fontawesome.ttf
)
set_target_properties(appQtUiAssessment PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

add_definitions(appQtUiAssessment
    -DAVATAR_DIRS="${CMAKE_CURRENT_SOURCE_DIR}/avatars"
)

target_link_libraries(appQtUiAssessment
    PRIVATE Qt6::Quick
)

install(TARGETS appQtUiAssessment
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
