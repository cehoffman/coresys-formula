class Rainbarf < Coresys::Formula
  url 'https://github.com/creaktive/rainbarf.git'
  version 'HEAD'

  def install
    system 'perl', 'Build.PL'

    ENV['PERL_INSTALL_ROOT'] = prefix
    system './Build', 'install'

    prefix.install (prefix + 'usr/local').children
    system 'rm', '-rf', prefix + 'usr'
  end
end
