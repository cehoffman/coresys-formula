class Stderred < Coresys::Formula
  url 'https://github.com/sickill/stderred.git'
  version 'HEAD'

  def install
    system 'make', '64'
    lib.install 'lib64/libstderred.so'
  end
end
