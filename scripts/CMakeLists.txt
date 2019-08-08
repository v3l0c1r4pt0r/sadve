set(dollar "$")
configure_file (sadve.sh.in sadve.sh)
install (FILES ${CMAKE_BINARY_DIR}/scripts/sadve.sh
         DESTINATION bin
         RENAME sadve
         PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
                     GROUP_READ GROUP_EXECUTE
                     WORLD_READ WORLD_EXECUTE
)
