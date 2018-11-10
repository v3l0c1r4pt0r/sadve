# this script is meant to install whole in/ tree, as CMakeLists.txt inside the
# modules are for processing durig sadve invocation
install (FILES simple/CMakeLists.txt
               simple/simple.c.in
         DESTINATION share/${PROJECT_NAME}/simple
)
