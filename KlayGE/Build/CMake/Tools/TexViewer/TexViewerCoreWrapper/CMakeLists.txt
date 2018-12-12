IF(MSVC_VERSION GREATER 1910)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zc:twoPhase-")
ENDIF()

SET(SOURCE_FILES 
	${KLAYGE_PROJECT_DIR}/Tools/src/TexViewer/TexViewerCoreWrapper/AssemblyInfo.cpp
	${KLAYGE_PROJECT_DIR}/Tools/src/TexViewer/TexViewerCoreWrapper/TexViewerCoreWrapper.cpp
)

SET(HEADER_FILES 
	${KLAYGE_PROJECT_DIR}/Tools/src/TexViewer/TexViewerCoreWrapper/TexViewerCoreWrapper.hpp
)

SOURCE_GROUP("Source Files" FILES ${SOURCE_FILES})
SOURCE_GROUP("Header Files" FILES ${HEADER_FILES})

INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${KLAYGE_PROJECT_DIR}/../KFL/include)
INCLUDE_DIRECTORIES(${KLAYGE_PROJECT_DIR}/Core/Include)
LINK_DIRECTORIES(${KLAYGE_PROJECT_DIR}/../KFL/lib/${KLAYGE_PLATFORM_NAME})
IF(KLAYGE_PLATFORM_DARWIN OR KLAYGE_PLATFORM_LINUX)
	LINK_DIRECTORIES(${KLAYGE_BIN_DIR})
ELSE()
	LINK_DIRECTORIES(${KLAYGE_OUTPUT_DIR})
ENDIF()
LINK_DIRECTORIES(${KLAYGE_TOOLS_LIB_OUTPUT_DIR})

STRING(REPLACE "/RTC1" "" CMAKE_CXX_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
STRING(REPLACE "/permissive-" "" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
STRING(REPLACE "/DEBUG:FASTLINK" "/DEBUG:FULL" CMAKE_SHARED_LINKER_FLAGS_DEBUG ${CMAKE_SHARED_LINKER_FLAGS_DEBUG})
STRING(REPLACE "/DEBUG:FASTLINK" "/DEBUG:FULL" CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO ${CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO})
IF(CMAKE_VERSION VERSION_LESS "3.12")
	SET(ADD_COMMON_LANGUAGE_RUNTIME FALSE)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /clr")
ELSE()
	SET(ADD_COMMON_LANGUAGE_RUNTIME TRUE)
ENDIF()
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHa")
SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /GR /Qpar-")
SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /GR /Qpar-")
SET(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL} /GR /Qpar-")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /ignore:4248")
ADD_LIBRARY(TexViewerCoreWrapper SHARED ${SOURCE_FILES} ${HEADER_FILES})

SET_TARGET_PROPERTIES(TexViewerCoreWrapper PROPERTIES
	PROJECT_LABEL TexViewerCoreWrapper
	DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
	OUTPUT_NAME TexViewerCoreWrapper
	VS_DOTNET_TARGET_FRAMEWORK_VERSION "v4.5"
	VS_DOTNET_REFERENCES "System;System.Windows;PresentationCore"
)
IF(ADD_COMMON_LANGUAGE_RUNTIME)
	SET_TARGET_PROPERTIES(TexViewerCoreWrapper PROPERTIES
		COMMON_LANGUAGE_RUNTIME "")
ENDIF()
ADD_DEPENDENCIES(TexViewerCoreWrapper TexViewerCore)

TARGET_LINK_LIBRARIES(TexViewerCoreWrapper
	debug TexViewerCore_d optimized TexViewerCore)

ADD_POST_BUILD(TexViewerCoreWrapper "")

INSTALL(TARGETS TexViewerCoreWrapper
	RUNTIME DESTINATION ${KLAYGE_BIN_DIR}
	LIBRARY DESTINATION ${KLAYGE_BIN_DIR}
	ARCHIVE DESTINATION ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
)

SET_TARGET_PROPERTIES(TexViewerCoreWrapper PROPERTIES FOLDER "Tools/TexViewer")