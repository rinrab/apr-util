vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rinrab/apr-util
    REF c7f6abcfa3345183aa4eb422e21f3e999f21a40f
    SHA512 0
    HEAD_REF 1.7.x
)

if (VCPKG_TARGET_IS_WINDOWS)
    vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
        FEATURES
            crypto      APU_HAVE_CRYPTO
            odbc        APU_HAVE_ODBC
            sqlite3     APU_HAVE_SQLITE3
            ldap        APR_HAS_LDAP
    )

    vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
            -DAPR_HAS_LDAP=OFF
            -DAPR_BUILD_TESTAPR=OFF
            -DINSTALL_PDB=ON
            ${FEATURE_OPTIONS}
    )

    vcpkg_cmake_install()
    vcpkg_copy_pdbs()

    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
else()
    # In development
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
