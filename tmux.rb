class Tmux < Coresys::Formula
  url 'http://sourceforge.net/projects/tmux/files/tmux/tmux-1.6/tmux-1.6.tar.gz'
  digest :sha1, '8756f6bcecb18102b87e5d6f5952ba2541f68ed3'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
