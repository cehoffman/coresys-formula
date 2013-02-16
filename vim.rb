class Vim < Coresys::Formula
  url 'https://github.com/b4winckler/vim.git', tag: 'v7-3-820'
  homepage 'http://www.vim.org/'
  version '7.3.820'

  def install
    system './configure', "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--enable-gui=no",
                          "--without-x",
                          "--disable-nls",
                          "--enable-multibyte",
                          "--with-tlib=ncursesw",
                          "--enable-pythoninterp",
                          "--enable-rubyinterp=dynamic",
                          "--with-features=huge"
    system 'make'
    system 'make', 'install'
  end
end
