class Luajit < Coresys::Formula
  url 'http://luajit.org/download/LuaJIT-2.0.0.tar.gz'
  digest :sha1, 'b942f05d41ee193becad285618e7874d113cb976'

  option '52compat', 'Enable 5.2 language features that break 5.1 programs'

  def install
    inreplace 'src/Makefile' do |m|
      m['BUILDMODE'] = 'dynamic'
      m['XCFLAGS'] = '-DLUAJIT_ENABLE_LUA52COMPAT'
    end if option?('52compat')

    system 'make', "PREFIX=#{prefix}", 'amalg'
    system 'make', "PREFIX=#{prefix}", 'amalg', 'install'

    if ENV.cygwin?
      cp 'src/cyglua51.dll', 'src/cyglua.dll'
      bin.install 'src/cyglua51.dll'
      lib.install 'src/cyglua.dll'
    end
  end
end
