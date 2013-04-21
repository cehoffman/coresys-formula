class Tmux < Coresys::Formula
  url 'http://downloads.sourceforge.net/tmux/tmux-1.8.tar.gz'
  sha1 '08677ea914e1973ce605b0008919717184cbd033'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
