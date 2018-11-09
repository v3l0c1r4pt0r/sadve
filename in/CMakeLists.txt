# this script is meant to install whole in/ tree, as CMakeLists.txt inside the
# modules are for processing durig sadve invocation
install (FILES define/CMakeLists.txt
               define/define.c.in
         DESTINATION share/${PROJECT_NAME}/define
)
