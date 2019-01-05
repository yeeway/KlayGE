set(EXTERNAL_PROJECT_DIR "${KLAYGE_ROOT_DIR}/External")
set(Boost_INCLUDE_DIR "${EXTERNAL_PROJECT_DIR}/boost" CACHE INTERNAL "" FORCE)

IF(KLAYGE_COMPILER_MSVC)
	IF(KLAYGE_PLATFORM_WINDOWS_STORE)
		SET(KLAYGE_FILESYSTEM_LIBRARY "kernel32")
	ELSE()
		SET(KLAYGE_FILESYSTEM_LIBRARY "")
	ENDIF()
ELSE()
	IF(KLAYGE_COMPILER_GCC AND (NOT KLAYGE_PLATFORM_WINDOWS OR NOT (KLAYGE_COMPILER_VERSION EQUAL 81)))
		SET(KLAYGE_FILESYSTEM_LIBRARY "stdc++fs")
	ELSEIF(KLAYGE_COMPILER_CLANG AND KLAYGE_PLATFORM_LINUX)
		IF(KLAYGE_COMPILER_VERSION LESS 70)
			SET(KLAYGE_FILESYSTEM_LIBRARY "c++experimental")
		ELSE()
			SET(KLAYGE_FILESYSTEM_LIBRARY "c++fs")
		ENDIF()
	ELSE()
		link_directories(${EXTERNAL_PROJECT_DIR}/lib/boost/${KLAYGE_PLATFORM_NAME})
		set(KLAYGE_FILESYSTEM_LIBRARY
			debug boost_filesystem${KLAYGE_OUTPUT_SUFFIX}${CMAKE_DEBUG_POSTFIX} optimized boost_filesystem${KLAYGE_OUTPUT_SUFFIX}
			debug boost_system${KLAYGE_OUTPUT_SUFFIX}${CMAKE_DEBUG_POSTFIX} optimized boost_system${KLAYGE_OUTPUT_SUFFIX}
		)
	ENDIF()
ENDIF()