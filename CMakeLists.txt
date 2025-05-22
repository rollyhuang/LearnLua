cmake_minimum_required(VERSION 3.10)

project(LearnLua
	VERSION 5.4.4
	# DESCRIPTION "LearnLua project"
	# HOMEPAGE_URL ""
	LANGUAGES C CXX
)

# The name of the top level project.
message(STATUS "Top level project is ${CMAKE_PROJECT_NAME}")
message(STATUS "CMakeLists.txt for ${PROJECT_NAME}")

# 项目相关路径
message(STATUS "CMAKE_SOURCE_DIR   = ${CMAKE_SOURCE_DIR}") #顶级源代码目录（包含顶级 CMakeLists.txt 的目录）
message(STATUS "CMAKE_BINARY_DIR   = ${CMAKE_BINARY_DIR}") #顶级构建目录
message(STATUS "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}") #当前项目的源目录
message(STATUS "PROJECT_BINARY_DIR = ${PROJECT_BINARY_DIR}") #当前项目的构建目录
message(STATUS "CMAKE_CURRENT_SOURCE_DIR = ${CMAKE_CURRENT_SOURCE_DIR}") #当前处理的 CMakeLists.txt 所在目录
message(STATUS "CMAKE_CURRENT_BINARY_DIR = ${CMAKE_CURRENT_BINARY_DIR}") #当前处理的 CMakeLists.txt 对应的构建目录

# 安装相关路径
message(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}") #安装目标根目录
message(STATUS "CMAKE_INSTALL_BINDIR = ${CMAKE_INSTALL_BINDIR}") #二进制文件安装目录（通常为 bin）
message(STATUS "CMAKE_INSTALL_LIBDIR = ${CMAKE_INSTALL_LIBDIR}") #库文件安装目录（通常为 lib 或 lib64）
message(STATUS "CMAKE_INSTALL_INCLUDEDIR = ${CMAKE_INSTALL_INCLUDEDIR}") #头文件安装目录（通常为 include）

# 系统相关路径
message(STATUS "CMAKE_SYSTEM_PREFIX_PATH = ${CMAKE_SYSTEM_PREFIX_PATH}") #系统头文件和库文件的搜索路径
message(STATUS "CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}") #自定义 CMake 模块的搜索路径
message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}") #用于查找包的额外搜索路径

# 编译相关路径
message(STATUS "CMAKE_C_COMPILER = ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")
message(STATUS "CMAKE_RUNTIME_OUTPUT_DIRECTORY = ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}") #可执行文件输出目录
message(STATUS "CMAKE_LIBRARY_OUTPUT_DIRECTORY = ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}") #动态库输出目录
message(STATUS "CMAKE_ARCHIVE_OUTPUT_DIRECTORY = ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}") #静态库输出目录

# if(NOT CMAKE_BUILD_TYPE)
# 	set(CMAKE_BUILD_TYPE "Debug")
# endif()
# # message(STATUS "CMAKE_BUILD_TYPE is ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_INSTALL_PREFIX is ${CMAKE_INSTALL_PREFIX}")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_SKIP_INSTALL_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FLASE)
# set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib") # must before add_executable
set(CMAKE_XCODE_ATTRIBUTE_OTHER_CODE_SIGN_FLAGS "-o linker-signed")

function(install_script dir scriptname)
	install(PROGRAMS ${dir}/${scriptname}.lua DESTINATION bin RENAME ${scriptname})
	# install(PROGRAMS ${dir}/${scriptname}.lua DESTINATION scripts)
	# install(CODE "EXECUTE_PROCESS(COMMAND
	# 	${CMAKE_COMMAND} -E create_symlink
	# 	${CMAKE_INSTALL_PREFIX}/scripts/${scriptname}.lua
	# 	${CMAKE_INSTALL_PREFIX}/bin/${scriptname}) 
	# ")
endfunction(install_script dir scriptname)

add_subdirectory(src)
add_subdirectory(lua)
add_subdirectory(luac)

