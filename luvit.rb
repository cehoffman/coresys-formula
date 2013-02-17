class Luvit < Coresys::Formula
  url 'https://github.com/luvit/luvit.git'
  version 'HEAD'
  
  def install
    system 'make', "PREFIX=#{prefix}", 'install'
  end
end
