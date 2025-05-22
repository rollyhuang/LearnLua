cmake_minimum_required(VERSION 3.10)
project(liblua
	VERSION 5.4.4
	# DESCRIPTION "Lua dynamic library"
	# HOMEPAGE_URL ""
	LANGUAGES C CXX # 启用了C和C++混编
)

# 如果未指定CMAKE_BUILD_TYPE，默认设置为Debug模式
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()
message(STATUS "CMakeLists.txt for ${PROJECT_NAME}")
message(STATUS "CMAKE_BUILD_TYPE is ${CMAKE_BUILD_TYPE}")

# set(CMAKE_C_VISIBILITY_PRESET hidden) # ignore "extern", hide all symbols

# -DLUA_COMPAT_5_1 -DLUA_COMPAT_5_2 -DLUA_COMPAT_MODULE
# LUA_USE_MACOSX and LUA_USE_LINUX are only available for lua.c and liblua, not for user
# LUA_BUILD_AS_DLL are for all windows components, include liblua, cmod library, and user exe which use liblua
if(APPLE)
	set(CMAKE_C_FLAGS         "-std=gnu99 -Wall -Wextra -DLUA_USE_MACOSX")
	set(CMAKE_C_FLAGS_DEBUG   "-g -DLUA_DEBUG") # LUA_DEBUG marco for ltable.c
	set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG")
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
	set(CMAKE_C_FLAGS         "-std=gnu99 -Wall -Wextra -DLUA_USE_LINUX")
	set(CMAKE_C_FLAGS_DEBUG   "-g -DLUA_DEBUG")
	set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG")
elseif(WIN32)
	set(CMAKE_C_FLAGS         "/DLUA_BUILD_AS_DLL") # /Wall
	set(CMAKE_C_FLAGS_DEBUG   "/ZI /Od /DLUA_DEBUG")
	set(CMAKE_C_FLAGS_RELEASE "/O2 /DNDEBUG")
endif()

# 添加全局头文件搜索路径
include_directories(./include)
include_directories(./core)
include_directories(./parser)

# 收集模块源文件列表保存到变量中
aux_source_directory(./core LUA_CORE_SRC)
aux_source_directory(./parser LUA_PARSER_SRC)
aux_source_directory(./embedlib LUA_EMBEDLIB_SRC)
aux_source_directory(./util LUA_UTIL_SRC)
# 使用通配符收集模块头文件保存到变量中
file(GLOB LUA_HEADERS "./include/*.h")
file(GLOB LUA_CORE_HEADERS "./core/*.h")
file(GLOB LUA_PARSER_HEADERS "./parser/*.h")

# 在IDE中组织项目源文件和头文件分组显示结构
source_group(core FILES ${LUA_CORE_SRC} ${LUA_CORE_HEADERS})
source_group(embedlib FILES ${LUA_EMBEDLIB_SRC})
source_group(util FILES ${LUA_UTIL_SRC})
source_group(include FILES ${LUA_HEADERS})

set(LIB_LUA_ALL_SRC
	${LUA_CORE_SRC}
	${LUA_PARSER_SRC}
	${LUA_EMBEDLIB_SRC}
	${LUA_UTIL_SRC}
	${LUA_HEADERS}
	${LUA_CORE_HEADERS}
	${LUA_PARSER_HEADERS}
)

# 编译构建lua动态库
add_library(${PROJECT_NAME} SHARED ${LIB_LUA_ALL_SRC})

set_target_properties(${PROJECT_NAME} PROPERTIES
	# OUTPUT_NAME "lua"
	OUTPUT_NAME_DEBUG "lua_d"
    OUTPUT_NAME_RELEASE "lua"
	VERSION ${PROJECT_VERSION}
	SOVERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
	POSITION_INDEPENDENT_CODE ON # 启用位置无关代码，构建动态库需要
)

if(WIN32)
	set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "lib")
endif(WIN32)

# API check for debug
# add_definitions(-DLUA_USE_APICHECK)
# target_compile_definitions(${PROJECT_NAME} PRIVATE LUA_USE_APICHECK)

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
	target_link_libraries(${PROJECT_NAME} m dl)
endif(CMAKE_SYSTEM_NAME MATCHES "Linux")

install(TARGETS ${PROJECT_NAME}
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
)
install(FILES ${LUA_HEADERS} DESTINATION include/lua)

install(TARGETS ${PROJECT_NAME}
	RUNTIME DESTINATION runner
	LIBRARY DESTINATION runner/lib
)

# add_subdirectory(test)
