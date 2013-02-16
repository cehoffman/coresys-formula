class Luajit < Coresys::Formula
  url 'http://luajit.org/download/LuaJIT-2.0.0.tar.gz'
  digest :sha1, 'b942f05d41ee193becad285618e7874d113cb976'

  def install
    system 'make', "PREFIX=#{prefix}", 'amalg'
    system 'make', "PREFIX=#{prefix}", 'amalg', 'install'
  end
end
