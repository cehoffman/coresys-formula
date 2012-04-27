class SSHGuardReprieve < Coresys::Formula
  url "git://gist.github.com/2511804.git", sha: 'f7647c'
  version 'f7547c'

  def install
    system 'cmake', "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
