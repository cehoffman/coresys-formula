class Stderred < Coresys::Formula
  url 'https://github.com/cehoffman/stderred.git'
  version 'HEAD'

  def install
    system 'make', 'lib64/stderred.so'
    lib.install 'lib64/stderred.so' => 'libstderred.so'
  end
end
