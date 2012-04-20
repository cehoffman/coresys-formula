class Weechat < Coresys::Formula
  url 'http://www.weechat.org/files/src/weechat-0.3.7.tar.bz2'
  digest :sha1, '897b79e18bbe947e4b78857ff1d428d17441d412'

  def install
    system 'cmake', "-DPREFIX=#{prefix}", '.'
    system 'make', 'install'
  end
end
