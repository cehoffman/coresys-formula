class Znc < Coresys::Formula
  url 'http://znc.in/releases/znc-0.206.tar.gz'
  digest :sha1, 'c5fe2575ef29187d2de5d08a08e17458c0ce54b9'

  def install
    system './configure', "--prefix=#{prefix}", '--enable-extra'
    system 'make', 'install'


    'https://raw.github.com/wired/colloquypush/master/znc/colloquy.cpp'
  end
end
