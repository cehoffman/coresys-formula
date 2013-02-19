class Lua < Coresys::Formula
  url 'http://www.lua.org/ftp/lua-5.2.1.tar.gz'
  digest :sha1, '6bb1b0a39b6a5484b71a83323c690154f86b2021'

  option 'completion', 'Enable completion using readline'

  def patches
    ['http://luajit.org/patches/lua-5.2.0-advanced_readline.patch'] if ARGV.include?('--completion') 
  end

  def install
    inreplace 'src/Makefile' do |s|
      s['CC'] = ENV.cc
      # s['CFLAGS'] = "#{ENV.cflags} -DLUA_COMPAT_ALL $(SYSCFLAGS) $(MYCFLAGS)"
      s['MYLDFLAGS'] = ENV.ldflags
    end

    inreplace 'src/luaconf.h', '/usr/local', Coresys.base

    (Coresys.base + 'lib/lua' + version.split('.')[0..1].join('.')).mkpath

    if ENV.cygwin?
IO.popen(['patch', '-p1'], 'w') do |io|
  io.write <<-DIFF
diff -rupN a/Makefile b/Makefile
--- a/Makefile	2013-02-16 07:21:36.247669300 -0600
+++ b/Makefile	2013-02-16 07:19:34.037940300 -0600
@@ -36,7 +36,7 @@ RM= rm -f
 # == END OF USER SETTINGS -- NO NEED TO CHANGE ANYTHING BELOW THIS LINE =======

 # Convenience platforms targets.
-PLATS= aix ansi bsd freebsd generic linux macosx mingw posix solaris
+PLATS= aix ansi bsd freebsd generic linux macosx mingw posix solaris cygwin

 # What to install.
 TO_BIN= lua luac
diff -rupN a/src/Makefile b/src/Makefile
--- a/src/Makefile	2013-02-16 07:18:12.259415500 -0600
+++ b/src/Makefile	2013-02-16 07:20:45.663159000 -0600
@@ -120,6 +120,13 @@ posix:
 solaris:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_POSIX -DLUA_USE_DLOPEN" SYSLIBS="-ldl"

+cygwin:
+	$(MAKE) "LUA_A=cyglua.dll" "LUA_T=lua.exe" \\
+		"AR=$(CC) -shared -o" "RANLIB=strip --strip-unneeded" \\
+		"MYCFLAGS=-DLUA_USE_LINUX -DLUA_BUILD_AS_DLL" \\
+		"MYLIBS=-lreadline -lhistory" "MYLDFLAGS=-s" lua.exe
+	$(MAKE) "LUAC_T=luac.exe" luac.exe
+
 # list targets that do not create files (but not all makes understand .PHONY)
 .PHONY: all $(PLATS) default o a clean depend echo none

diff -rupN a/Makefile b/Makefile
--- a/Makefile	2013-02-16 07:46:21.373809600 -0600
+++ b/Makefile	2013-02-16 07:47:29.775650500 -0600
@@ -39,9 +39,9 @@ RM= rm -f
 PLATS= aix ansi bsd freebsd generic linux macosx mingw posix solaris

 # What to install.
-TO_BIN= lua luac
+TO_BIN= lua.exe luac.exe cyglua.dll
 TO_INC= lua.h luaconf.h lualib.h lauxlib.h lua.hpp
-TO_LIB= liblua.a
+TO_LIB= cyglua.dll
 TO_MAN= lua.1 luac.1

 # Lua version and release.
DIFF
end
    end

    system 'make', 'cygwin', "INSTALL_TOP=#{prefix}", "INSTALL_MAN=#{man1}"
    system 'make', 'install', "INSTALL_TOP=#{prefix}", "INSTALL_MAN=#{man1}"
  end
end
