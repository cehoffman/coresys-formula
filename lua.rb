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
      s['CFLAGS'] = "#{ENV.cflags} -DLUA_COMPAT_ALL $(SYSCFLAGS) $(MYCFLAGS)"
      s['MYLDFLAGS'] = ENV.ldflags
    end

    inreplace 'src/luaconf.h', '/usr/local', Coresys.base

    (Coresys.base + 'lib/lua' + version.split('.')[0..1].join('.')).mkpath

    system 'make', 'linux', "INSTALL_TOP=#{prefix}", "INSTALL_MAN=#{man1}"
    system 'make', 'install', "INSTALL_TOP=#{prefix}", "INSTALL_MAN=#{man1}"
  end
end
